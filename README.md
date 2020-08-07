# localstack_sfn_bugreport

## Description

When there are many processes that tries to hit stepfunction's `getActivityTask`
endpoint, other part of localstack is not responsive.

## How to Reproduce

> Note: This requires you to have `docker` and `python`, with `awscli` and `boto3`
> installed.

1. Run `./start_localstack.sh` to start localstack in Docker.
2. Run `./setup_resources.sh` to create stepfunction activity, role and state machine.
3. Run `python notify_activity.py` to start 1 state machine execution, and have
    multiple parallel calls to `getActivityTask`.

**Expected Behaviour**:

    * Many of the calls to `getActivityTask` eventually time out
    * Other localstack endpoints (i.e. `http://localhost:4566/health`) and other
        services are still accessible

**Actual Behaviour**:

    * Other localstack endpoints (i.e. `http://localhost:4566/health`) and other
        services are not responding
