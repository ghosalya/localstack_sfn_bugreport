#! /usr/bin/env bash

export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

# create activity

aws stepfunctions create-activity \
    --name test_activity \
    --endpoint-url http://localhost:4566

# create dummy role for state machine
aws iam create-role \
    --role-name test_role \
    --assume-role-policy-document file://$(pwd)/trust-policy.json \
    --endpoint-url http://localhost:4566

aws stepfunctions create-state-machine \
    --name test_state_machine \
    --definition file://$(pwd)/state_machine.json \
    --role-arn arn:aws:iam::000000000000:role/test_role \
    --endpoint-url http://localhost:4566
