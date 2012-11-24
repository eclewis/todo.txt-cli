#!/bin/bash
#

test_description='default context

This test checks that the default context functionality works.
'
. ./test-lib.sh

TEST_TODO_=todo.cfg

#
# check add with default context with default context disabled
# (with '@' placed in various positions)
#
TEST_TODO1_=todo1.cfg
sed -e "s/^.*export TODOTXT_DEFAULT_CONTEXTS=.*$/export TODOTXT_DEFAULT_CONTEXTS='@work'/" "${TEST_TODO_}" > "${TEST_TODO1_}"

test_todo_session 'checking TODOTXT_DEFAULT_CONTEXTS' <<EOF
>>> todo.sh -d "$TEST_TODO1_" add "item 1  " "and more"
1 item 1   and more @work
TODO: 1 added.

>>> todo.sh -d "$TEST_TODO1_" add "@ item 2  " "and more"
2 item 2   and more
TODO: 2 added.

>>> todo.sh -d "$TEST_TODO1_" add "item @ 3  " "and more"
3 item 3   and more
TODO: 3 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 4 @  " "and more"
4 item 4   and more
TODO: 4 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 5   @" "and more"
5 item 5 and more
TODO: 5 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 6   " @ "and more"
6 item 6 and more
TODO: 6 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 7   " "@ and more"
7 item 7 and more
TODO: 7 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 8   " "and @ more"
8 item 8    and more
TODO: 8 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 9   " "and more @"
9 item 9    and more
TODO: 9 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 10   " "and more @  "
10 item 10    and more  
TODO: 10 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 11   " "and more" @
11 item 11    and more
TODO: 11 added.
EOF

test_done
