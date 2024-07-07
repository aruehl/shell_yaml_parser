# yaml parser for shell (bash, zsh, ...)

The parser kann read this file

```yaml
---

will_work:
  string: value
  number: 42
  float: 3.14
  url: http://www.my-domain.net
  mail: name@post.email
  dollar_sign: I love $USER
  comment_after_hash: an#hash # and a comment
  inline_comment: something #comment
  empty_hash_commented: #comment
  multiple_dashes: abc---xyz

  single_quotes:
    hashtag1: '#hashtag'
    hashtag2: 'text #hashtag'
    hashtag3: 'text#hashtag'
    dollar_sign: 'I love $USER'
    comment_in_string: 'a string with # a comment'

  double_quotes:
    hashtag1: '#hashtag'
    hashtag2: 'text #hashtag'
    hashtag3: 'text#hashtag'
    dollar_sign: "I love $USER"
    comment_in_string: "a string with # a comment"

  lists:
    - color: red
      form: 'circle'
    -
      color: green

      form: "square"
    - deeper:
        list:
          - 0
          - 1
          - 2
        another_list:
          - 3
          - 4
          - 5

specials:
  dash-property: OK
  dot.property: OK
  multi-dash-property: OK
  multi.dot.property: OK
  -starting-dash-property: OK
  .starting.dot.property: OK
  _starting_underscore_property: OK

wont_work:
  inline_list: ["one", 'two', three]
  multiple_spaces: abc   xyz
  quotes_in_quotes: 'text with "quotes"'
  multi_line_description: >
            this text is to long
            for one line
```

and produces for that given file the following output:

```shell
declare -g -A prefix_will_work_array;
export prefix_will_work_string="value";
prefix_will_work_array[string]="value";
export prefix_will_work_number="42";
prefix_will_work_array[number]="42";
export prefix_will_work_float="3.14";
prefix_will_work_array[float]="3.14";
export prefix_will_work_url="http://www.my-domain.net";
prefix_will_work_array[url]="http://www.my-domain.net";
export prefix_will_work_mail="name@post.email";
prefix_will_work_array[mail]="name@post.email";
export prefix_will_work_dollar_sign="I love $USER";
prefix_will_work_array[dollar_sign]="I love $USER";
export prefix_will_work_comment_after_hash="an#hash";
prefix_will_work_array[comment_after_hash]="an#hash";
export prefix_will_work_inline_comment="something";
prefix_will_work_array[inline_comment]="something";
declare -g -A prefix_will_work_empty_hash_commented_array;
export prefix_will_work_multiple_dashes="abc---xyz";
prefix_will_work_array[multiple_dashes]="abc---xyz";
declare -g -A prefix_will_work_single_quotes_array;
export prefix_will_work_single_quotes_hashtag1="#hashtag";
prefix_will_work_single_quotes_array[hashtag1]="#hashtag";
export prefix_will_work_single_quotes_hashtag2="text #hashtag";
prefix_will_work_single_quotes_array[hashtag2]="text #hashtag";
export prefix_will_work_single_quotes_hashtag3="text#hashtag";
prefix_will_work_single_quotes_array[hashtag3]="text#hashtag";
export prefix_will_work_single_quotes_dollar_sign="I love $USER";
prefix_will_work_single_quotes_array[dollar_sign]="I love $USER";
export prefix_will_work_single_quotes_comment_in_string="a string with # a comment";
prefix_will_work_single_quotes_array[comment_in_string]="a string with # a comment";
declare -g -A prefix_will_work_double_quotes_array;
export prefix_will_work_double_quotes_hashtag1="#hashtag";
prefix_will_work_double_quotes_array[hashtag1]="#hashtag";
export prefix_will_work_double_quotes_hashtag2="text #hashtag";
prefix_will_work_double_quotes_array[hashtag2]="text #hashtag";
export prefix_will_work_double_quotes_hashtag3="text#hashtag";
prefix_will_work_double_quotes_array[hashtag3]="text#hashtag";
export prefix_will_work_double_quotes_dollar_sign="I love $USER";
prefix_will_work_double_quotes_array[dollar_sign]="I love $USER";
export prefix_will_work_double_quotes_comment_in_string="a string with # a comment";
prefix_will_work_double_quotes_array[comment_in_string]="a string with # a comment";
declare -g -A prefix_will_work_lists_array;
declare -g -a prefix_will_work_lists_0_array;
export prefix_will_work_lists_0_color="red";
prefix_will_work_lists_0_array[color]="red";
export prefix_will_work_lists_0_form="circle";
prefix_will_work_lists_0_array[form]="circle";
declare -g -a prefix_will_work_lists_1_array;
export prefix_will_work_lists_1_color="green";
prefix_will_work_lists_1_array[color]="green";
export prefix_will_work_lists_1_form="square";
prefix_will_work_lists_1_array[form]="square";
declare -g -a prefix_will_work_lists_2_array;
declare -g -A prefix_will_work_lists_2_deeper_array;
declare -g -A prefix_will_work_lists_2_deeper_list_array;
export prefix_will_work_lists_2_deeper_list_0="0";
prefix_will_work_lists_2_deeper_list_array+=("0");
export prefix_will_work_lists_2_deeper_list_1="1";
prefix_will_work_lists_2_deeper_list_array+=("1");
export prefix_will_work_lists_2_deeper_list_2="2";
prefix_will_work_lists_2_deeper_list_array+=("2");
declare -g -A prefix_will_work_lists_2_deeper_another_list_array;
export prefix_will_work_lists_2_deeper_another_list_0="3";
prefix_will_work_lists_2_deeper_another_list_array+=("3");
export prefix_will_work_lists_2_deeper_another_list_1="4";
prefix_will_work_lists_2_deeper_another_list_array+=("4");
export prefix_will_work_lists_2_deeper_another_list_2="5";
prefix_will_work_lists_2_deeper_another_list_array+=("5");
declare -g -a prefix_will_work_lists_3_array;
export prefix_will_work_lists_3_inline="["one", "two", "three"]";
prefix_will_work_lists_3_array[inline]="["one", "two", "three"]";
declare -g -A prefix_specials_array;
export prefix_specials_dash_property="OK";
prefix_specials_array[dash_property]="OK";
export prefix_specials_multi_dash_property="OK";
prefix_specials_array[multi_dash_property]="OK";
export prefix_specials_starting_dash_property="OK";
prefix_specials_array[_starting_dash_property]="OK";
export prefix_specials_dot_property="OK";
prefix_specials_array[dot_property]="OK";
export prefix_specials_multi_dot_property="OK";
prefix_specials_array[multi_dot_property]="OK";
export prefix_specials_starting_dot_property="OK";
prefix_specials_array[_starting_dot_property]="OK";
export prefix_specials_starting_underscore_property="OK";
prefix_specials_array[_starting_underscore_property]="OK";
declare -g -A prefix_wont_work_array;
export prefix_wont_work_multiple_spaces="abc   xyz";
prefix_wont_work_array[multiple_spaces]="abc   xyz";
export prefix_wont_work_quotes_in_quotes="text with "quotes"";
prefix_wont_work_array[quotes_in_quotes]="text with "quotes"";
```
you can 'eval()' that and use it in your script.
