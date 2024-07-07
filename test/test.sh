#!/bin/sh

source ../yaml_parser.sh

# Tests
declare -A tests=(
    [will_work_string]=value
    [will_work_number]=42
    [will_work_float]="3.14"
    [will_work_url]="http://www.my-domain.net"
    [will_work_mail]="name@post.email"
    [will_work_dollar_sign]="I love $USER"
    [will_work_comment_after_hash]="an#hash"
    [will_work_inline_comment]="something"
    [will_work_empty_hash_commented]=""
    [will_work_multiple_dashes]="abc---xyz"
    [will_work_single_quotes_hashtag1]="#hashtag"
    [will_work_single_quotes_hashtag2]="text #hashtag"
    [will_work_single_quotes_hashtag3]="text#hashtag"
    [will_work_single_quotes_dollar_sign]="I love $USER"
    [will_work_single_quotes_comment_in_string]="a string with # a comment"
    [will_work_double_quotes_hashtag1]="#hashtag"
    [will_work_double_quotes_hashtag2]="text #hashtag"
    [will_work_double_quotes_hashtag3]="text#hashtag"
    [will_work_double_quotes_dollar_sign]="I love $USER"
    [will_work_double_quotes_comment_in_string]="a string with # a comment"

    [will_work_lists_0_color]="red"
    [will_work_lists_0_form]="circle"
    [will_work_lists_1_color]="green"
    [will_work_lists_1_form]="square"
    [will_work_lists_2_deeper_list_2]="2"
    [will_work_lists_2_deeper_another_list_2]="5"

    [specials_dash_property]=OK
    [specials_dot_property]=OK
    [specials_multi_dash_property]=OK
    [specials_multi_dot_property]=OK
    [specials_starting_dash_property]=OK
    [specials_starting_dot_property]=OK
    [specials_starting_underscore_property]=OK

    [wont_work_multiple_spaces]="abc   xyz"
    [wont_work_quotes_in_quotes]="text with \"quotes\""
    [wont_work_multi_line_string]="this text is to long for one line"
    [wont_work_inline_list_2]="two"
)

main() {
    # parse_yaml "test.yml" "prefix_" "true" && echo
    eval $(yaml_parser::parse "test.yml")

    SUCCESSFUL_TESTS=0
    KNOWN_BUGS=0
    FAILED_TESTS=0
    for test in ${!tests[@]} ; do
        if [[ "${!test}" = "${tests[${test}]}" ]] ; then
            ((SUCCESSFUL_TESTS++))
        elif [[ ${test} == wont_work_* ]] ; then
            ((KNOWN_BUGS++))
        else
            ((FAILED_TESTS++))
            echo "FAILED: ${test} => '${!test}' != '${tests[${test}]}'"
        fi
    done #| sort

    echo "${SUCCESSFUL_TESTS} successful"
    echo "${KNOWN_BUGS} known bugs"
    echo "${FAILED_TESTS} failed"

    echo Array-Test: ${specials_array["dash_property"]}

    exit ${FAILED_TESTS}
}

main
