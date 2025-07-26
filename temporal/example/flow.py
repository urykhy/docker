import asyncio

from workflows import MyFlow
from temporalio.client import Client


async def main():
    p = {"tasks": [{"id": "1"}, {"id": "2"}, {"id": "3"}]}
    client = await Client.connect("server.temporal:7233")
    result = await client.execute_workflow(
        MyFlow.run, p, id="my-workflow", task_queue="my-task-queue"
    )
    print(f"Result: {result}")


if __name__ == "__main__":
    asyncio.run(main())
