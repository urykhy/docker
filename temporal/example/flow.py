import asyncio
import json
import sys

from temporalio.client import Client
from workflows import FlowWithPrio, MyFlow, CanFlow


async def main():
    p = {"tasks": ["1", "2", "3", "4", "5", "6", "7"]}
    client = await Client.connect("server.temporal:7233")
    arguments = sys.argv[1:]

    if len(arguments) == 0 or arguments[0]=="MyFlow":
        result = await client.execute_workflow(
            MyFlow.run, p, id="my-workflow", task_queue="my-task-queue"
        )
    elif arguments[0]=="FlowWithPrio":
        r = await client.start_workflow(FlowWithPrio.run, p, id="flow-with-prio", task_queue="my-task-queue")
        await asyncio.sleep(2.5)
        await r.signal(
            FlowWithPrio.change_priority, json.dumps({"priority_key": 3, "fairness_key": "tier-1", "fairness_weight": 5})
        )
        result = await r.result()
    elif arguments[0]=="CanFlow":
        p["out"]=[]
        r = await client.start_workflow(CanFlow.run, p, id="flow-with-continue-as-new", task_queue="my-task-queue")
        result = await r.result()
    else:
        async for workflow in client.list_workflows("WorkflowType = 'CanFlow' AND ExecutionStatus = 'Completed'"):
            result = await client.get_workflow_handle(workflow_id=workflow.id, run_id=workflow.run_id).result()
            print(f"Workflow ID: {workflow.id}, status: {workflow.status}, Run ID: {workflow.run_id}, Output Result: {result}")
        result={}

    print(f"Result: {json.dumps(result, indent=4)}")


if __name__ == "__main__":
    asyncio.run(main())
