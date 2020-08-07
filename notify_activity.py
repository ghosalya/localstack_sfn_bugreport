import boto3
from threading import Thread


sfn = boto3.client(
    "stepfunctions",
    endpoint_url="http://localhost:4566",
    aws_access_key_id="test",
    aws_secret_access_key="test",
)


def run_state_machine():
    sfn.start_execution(
        stateMachineArn="arn:aws:states:us-east-1:000000000000:stateMachine:test_state_machine",
    )


def notify_activity():
    print("getting task token")
    response = sfn.get_activity_task(
        activityArn="arn:aws:states:us-east-1:000000000000:activity:test_activity"
    )
    task_token = response["taskToken"]

    print("notifying task")
    sfn.send_task_success(taskToken=task_token, output="{\"message\": \"success\"}")


def run():
    run_state_machine()

    threads = [Thread(target=notify_activity) for i in range(90)]

    for process in threads:
        process.start()

    for process in threads:
        process.join()


if __name__ == "__main__":
    run()
