from datetime import timedelta
from temporalio import workflow

# Import activity, passing it through the sandbox without reloading the module
# with workflow.unsafe.imports_passed_through():
from activities import *


@workflow.defn
class MyFlow:
    @workflow.run
    async def run(self, params) -> str:
        x = []
        x.append(
            await workflow.execute_activity(
                step_hello, params, start_to_close_timeout=timedelta(seconds=5)
            )
        )

        w = []
        for t in params["tasks"]:
            w.append(
                workflow.start_activity(
                    step_diff, t, start_to_close_timeout=timedelta(seconds=5)
                )
            )
        for t in w:
            x.append(await t)

        w = []
        for t in params["tasks"]:
            w.append(
                workflow.start_activity(
                    step_process, t, start_to_close_timeout=timedelta(seconds=5)
                )
            )
        for t in w:
            x.append(await t)

        x.append(
            await workflow.execute_activity(
                step_notify, params, start_to_close_timeout=timedelta(seconds=5)
            )
        )
        return ",".join(x)
