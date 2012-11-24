#!/bin/bash
#

test_description='default context

This test checks that the default context functionality works.
'
. ./test-lib.sh

TEST_TODO_=todo.cfg

#
# check basic add/list with default context
#
TEST_TODO1_=todo1.cfg
sed -e "s/^.*export TODOTXT_DEFAULT_CONTEXTS=.*$/export TODOTXT_DEFAULT_CONTEXTS='@work'/" "${TEST_TODO_}" > "${TEST_TODO1_}"

test_todo_session 'checking TODOTXT_DEFAULT_CONTEXTS' <<EOF
>>> todo.sh -d "$TEST_TODO1_" add "item 1"
1 item 1 @work
TODO: 1 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 2 @home"
2 item 2 @home
TODO: 2 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 3 @"
3 item 3
TODO: 3 added.

>>> todo.sh -d "$TEST_TODO1_" ls
1 item 1 @work
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls @home
2 item 2 @home
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls @
1 item 1 @work
2 item 2 @home
3 item 3
--
TODO: 3 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls -@home
1 item 1 @work
3 item 3
--
TODO: 2 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls -@work
2 item 2 @home
3 item 3
--
TODO: 2 of 3 tasks shown
EOF

#
# check basic add/list with default context (using non-default
# TODOTXT_IGNORE_DEFAULT_CONTEXTS)
#
TEST_TODO2_=todo1.cfg
sed -e "s/^.*export TODOTXT_DEFAULT_CONTEXTS=.*$/export TODOTXT_DEFAULT_CONTEXTS='@work'/" -e "s/^.*export TODOTXT_IGNORE_DEFAULT_CONTEXTS=.*$/export TODOTXT_IGNORE_DEFAULT_CONTEXTS='@none'/" "${TEST_TODO_}" > "${TEST_TODO2_}"

cat > todo.txt <<EOF
EOF

test_todo_session 'checking TODOTXT_DEFAULT_CONTEXTS' <<EOF
>>> todo.sh -d "$TEST_TODO2_" add "item 1"
1 item 1 @work
TODO: 1 added.

>>> todo.sh -d "$TEST_TODO2_" add "item 2 @home"
2 item 2 @home
TODO: 2 added.

>>> todo.sh -d "$TEST_TODO2_" add "item 3a @"
3 item 3a @
TODO: 3 added.

>>> todo.sh -d "$TEST_TODO2_" add "item 3b @none"
4 item 3b
TODO: 4 added.

>>> todo.sh -d "$TEST_TODO2_" ls
1 item 1 @work
--
TODO: 1 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls @home
2 item 2 @home
--
TODO: 1 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls @
1 item 1 @work
2 item 2 @home
3 item 3a @
--
TODO: 3 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls -@
4 item 3b
--
TODO: 1 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls @none
1 item 1 @work
2 item 2 @home
3 item 3a @
4 item 3b
--
TODO: 4 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls -@home
1 item 1 @work
3 item 3a @
4 item 3b
--
TODO: 3 of 4 tasks shown

>>> todo.sh -d "$TEST_TODO2_" ls -@work
2 item 2 @home
3 item 3a @
4 item 3b
--
TODO: 3 of 4 tasks shown
EOF

test_done
