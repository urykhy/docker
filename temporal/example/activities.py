from temporalio import activity
from asyncio import sleep


@activity.defn
async def step_hello(params) -> str:
    return f"Hello, {params}!"


@activity.defn
async def step_diff(params) -> str:
    await sleep(0.05)
    return f"Diff, {params}!"


@activity.defn
async def step_process(params) -> str:
    await sleep(0.1)
    return f"Process, {params}!"


@activity.defn
async def step_notify(params) -> str:
    return f"Notify, {params}!"
