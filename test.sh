#!/bin/bash

if grep -q "Week 9 DevOps CI/CD Pipeline" index.html
then
    echo "TEST PASSED"
    exit 0
else
    echo "TEST FAILED"
    exit 1
fi
