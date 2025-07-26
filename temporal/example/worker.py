import asyncio

from temporalio.client import Client
from temporalio.worker import Worker

from activities import *
from workflows import MyFlow


async def main():
    client = await Client.connect("server.temporal:7233")
    worker = Worker(
        client,
        task_queue="my-task-queue",
        workflows=[MyFlow],
        max_concurrent_activities=2,
        activities=[step_hello, step_diff, step_process, step_notify],
    )
    await worker.run()


if __name__ == "__main__":
    asyncio.run(main())
