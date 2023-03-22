#!/usr/bin/env bats
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

load ./helper

expect_ok() {
    [ "${1}" -eq 0 ]
}

expect_no() {
    [ "${1}" -eq 1 ]
}

test_schema() {
    local KIND=${1}
    local APIVER=${2}
    local EXAMPLE=${3}
    local verify_expectation=${4}
    local validate_status=""
    local validate_output=""
    local verify_expectation_status=""

    TMPDIR=$(mktemp -d -t "fury-distribution-test")

    mkdir -p "${TMPDIR}/tests/schemas/${KIND}/${APIVER}"

    yq "tests/schemas/${KIND}/${APIVER}/${EXAMPLE}.yaml" -o json  > "${TMPDIR}/tests/schemas/${KIND}/${APIVER}/${EXAMPLE}.json"

    validate() {
        jv "schemas/${KIND}/${APIVER}.json" "${TMPDIR}/tests/schemas/${KIND}/${APIVER}/${EXAMPLE}.json"
    }

    run validate
    validate_status="${status}"
    validate_output="${output}"

    run "${verify_expectation}" "${validate_status}"
    verify_expectation_status="${status}"

    # rm -rf "${TMPDIR}"

    if [ "${verify_expectation_status}" -ne 0 ]; then
        echo "${validate_output}" >&3

        return 1
    fi

    return 0
}

@test "001 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "001-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "001-ok" expect_ok
}

@test "001 - no" {
    info

    expect() {
        expect_no "${1}"

        local EXPECTED_ERROR_1="[S#/\$defs/Spec/else/properties/kubernetes/properties/vpcId/type] expected null, but got string"
        local EXPECTED_ERROR_2="[S#/\$defs/Spec/else/properties/kubernetes/properties/subnetIds/type] expected null, but got array"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi

        if [[ "${output}" != *"${EXPECTED_ERROR_2}"* ]]; then
            return 3
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "001-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "001-no" expect
}

@test "002 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "002-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "002-ok" expect_ok
}

@test "002 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec/then/properties/kubernetes/required] missing properties: 'vpcId', 'subnetIds'"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "002-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "002-no" expect
}

@test "003 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "003-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "003-ok" expect_ok
}

@test "003 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec.Distribution.Modules.Auth/allOf/0/else/properties/dex/type] expected null, but got object"
        local EXPECTED_ERROR_2="[S#/\$defs/Spec.Distribution.Modules.Auth/allOf/0/else/properties/pomerium/type] expected null, but got object"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi

        if [[ "${output}" != *"${EXPECTED_ERROR_2}"* ]]; then
            return 3
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "003-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "003-no" expect
}

@test "004 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "004-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "004-ok" expect_ok
}

@test "004 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec.Distribution.Modules.Auth/allOf/1/then/properties/provider/required] missing properties: 'basicAuth'"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "004-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "004-no" expect
}

@test "005 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "005-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "005-ok" expect_ok
}

@test "005 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec.Distribution/else/properties/modules/properties/aws/type] expected null, but got object"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "005-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "005-no" expect
}

@test "006 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "006-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "006-ok" expect_ok
}

@test "006 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec.Distribution.Modules.Ingress.Nginx.TLS/then/required] missing properties: 'secret'"
        local EXPECTED_ERROR_2="[S#/\$defs/Spec.Distribution/then/properties/modules/required] missing properties: 'aws'"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi

        if [[ "${output}" != *"${EXPECTED_ERROR_2}"* ]]; then
            return 2
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "006-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "006-no" expect
}

@test "007 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "007-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "007-ok" expect_ok
}

@test "007 - no" {
    info

    expect() {
        expect_no

        local EXPECTED_ERROR_1="[S#/\$defs/Spec.Distribution/then/properties/modules/required] missing properties: 'aws'"

        if [[ "${output}" != *"${EXPECTED_ERROR_1}"* ]]; then
            return 2
        fi
    }

    test_schema "private" "ekscluster-kfd-v1alpha2" "007-no" expect
    test_schema "public" "ekscluster-kfd-v1alpha2" "007-no" expect
}

@test "008 - ok" {
    info

    test_schema "private" "ekscluster-kfd-v1alpha2" "008-ok" expect_ok
    test_schema "public" "ekscluster-kfd-v1alpha2" "008-ok" expect_ok
}
