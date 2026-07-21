import asyncio
import json
from datetime import timedelta

# Import activity, passing it through the sandbox without reloading the module
# with workflow.unsafe.imports_passed_through():
from activities import *
from temporalio import workflow
from temporalio.common import Priority
from temporalio.exceptions import ActivityError


@workflow.defn
class MyFlow:
    @workflow.run
    async def run(self, params) -> str:
        x = []
        if workflow.patched("v1"):
            x.append(await workflow.execute_activity(step_hello, params, start_to_close_timeout=timedelta(seconds=5)))

            w = []
            for t in params["tasks"]:
                w.append(
                    workflow.start_activity(
                        step_diff,
                        t,
                        start_to_close_timeout=timedelta(seconds=5),
                        heartbeat_timeout=timedelta(seconds=1),
                    )
                )
            for t in w:
                x.append(await t)

            w = []
            for t in params["tasks"]:
                w.append(workflow.start_activity(step_process, t, start_to_close_timeout=timedelta(seconds=5)))
            for t in w:
                x.append(await t)

            x.append(await workflow.execute_activity(step_notify, params, start_to_close_timeout=timedelta(seconds=5)))
        return ",".join(x)


@workflow.defn
class FlowWithPrio:
    def __init__(self) -> None:
        self.tasks = {}

    @workflow.run
    async def run(self, params) -> list[str]:
        priority = json.dumps({"priority_key": 3, "fairness_key": "tier-1", "fairness_weight": 10})
        for step in params["tasks"]:
            t = workflow.start_activity(
                step_hello,
                {"step": step},
                start_to_close_timeout=timedelta(seconds=5),
                heartbeat_timeout=timedelta(seconds=2),
                priority=Priority(**json.loads(priority)),
            )
            self.tasks[step] = t
        return await asyncio.gather(*[self._wait_and_restart(x) for x in self.tasks.items()])

    async def _wait_and_restart(self, x):
        step, t = x
        while True:
            try:
                return await t
            except ActivityError as e:
                print(f"cancelled {e.cause}: {e.message}")
                t = workflow.start_activity(
                    step_hello,
                    {"step": step, "new": True},
                    start_to_close_timeout=timedelta(seconds=5),
                    heartbeat_timeout=timedelta(seconds=2),
                    priority=Priority(**json.loads(self._new_priority)),
                )
                self.tasks[step] = t

    @workflow.signal
    def change_priority(self, priority: str):
        self._new_priority = priority
        for step, t in self.tasks.items():
            if not t.done():
                print(f"about to cancel task for {step}")
                t.cancel()
