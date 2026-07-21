import asyncio
import json

from temporalio.client import Client
from workflows import FlowWithPrio, MyFlow


async def main():
    p = {"tasks": ["1", "2", "3", "4", "5", "6", "7"]}
    client = await Client.connect("server.temporal:7233")
    # result = await client.execute_workflow(
    #    MyFlow.run, p, id="my-workflow", task_queue="my-task-queue"
    # )
    r = await client.start_workflow(FlowWithPrio.run, p, id="flow-with-prio", task_queue="my-task-queue")
    await asyncio.sleep(2.5)
    await r.signal(
        FlowWithPrio.change_priority, json.dumps({"priority_key": 3, "fairness_key": "tier-1", "fairness_weight": 5})
    )
    result = await r.result()

    print(f"Result: {json.dumps(result, indent=4)}")


if __name__ == "__main__":
    asyncio.run(main())
