import time
from asyncio import sleep

from temporalio import activity


@activity.defn
async def step_hello(params) -> str:
    return f"Hello, {params}!"


@activity.defn
async def step_diff(params) -> str:
    info = activity.info()
    start_index = info.heartbeat_details[0] if info.heartbeat_details else 0
    result = info.heartbeat_details[1] if info.heartbeat_details else []
    for i in range(start_index, 4):
        await sleep(0.05)
        result.append(i)
        activity.heartbeat(i + 1, result)  # checkpoint
        if not info.heartbeat_details and i == 2:
            raise ValueError("raise to trigger retry by temporal")
    return f"Diff, {params}: {result}!"


@activity.defn
def step_process(params) -> str:
    time.sleep(0.1)
    return f"Process, {params}!"


@activity.defn
async def step_notify(params) -> str:
    return f"Notify, {params}!"
