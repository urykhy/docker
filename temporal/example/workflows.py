from datetime import timedelta

# Import activity, passing it through the sandbox without reloading the module
# with workflow.unsafe.imports_passed_through():
from activities import *
from temporalio import workflow


@workflow.defn
class MyFlow:
    @workflow.run
    async def run(self, params) -> str:
        x = []
        if workflow.patched('v1'):
            x.append(await workflow.execute_activity(step_hello, params, start_to_close_timeout=timedelta(seconds=5)))

            w = []
            for t in params["tasks"]:
                w.append(
                    workflow.start_activity(
                        step_diff, t, start_to_close_timeout=timedelta(seconds=5), heartbeat_timeout=timedelta(seconds=1)
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
