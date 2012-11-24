#!/bin/bash
#

test_description='default context

This test checks that the default context functionality works.
'
. ./test-lib.sh

TEST_TODO_=todo.cfg

#
# check add/list with default context with quoted context for add
#
TEST_TODO1_=todo1.cfg
sed -e "s/^.*export TODOTXT_DEFAULT_CONTEXTS=.*$/export TODOTXT_DEFAULT_CONTEXTS='@work'/" "${TEST_TODO_}" > "${TEST_TODO1_}"

test_todo_session 'checking TODOTXT_DEFAULT_CONTEXTS' <<EOF
>>> todo.sh -d "$TEST_TODO1_" add "item 1   and more"
1 item 1   and more @work
TODO: 1 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 2" "@home   and more"
2 item 2 @home   and more
TODO: 2 added.

>>> todo.sh -d "$TEST_TODO1_" add "item 3" "@   and more"
3 item 3   and more
TODO: 3 added.

>>> todo.sh -d "$TEST_TODO1_" ls
1 item 1   and more @work
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls item
1 item 1   and more @work
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls item @home
2 item 2 @home   and more
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls item @
1 item 1   and more @work
2 item 2 @home   and more
3 item 3   and more
--
TODO: 3 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls @home
2 item 2 @home   and more
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls @
1 item 1   and more @work
2 item 2 @home   and more
3 item 3   and more
--
TODO: 3 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls -@home
1 item 1   and more @work
3 item 3   and more
--
TODO: 2 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls -@work
2 item 2 @home   and more
3 item 3   and more
--
TODO: 2 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls "  and more"
1 item 1   and more @work
--
TODO: 1 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls "  and more" @
1 item 1   and more @work
2 item 2 @home   and more
3 item 3   and more
--
TODO: 3 of 3 tasks shown

>>> todo.sh -d "$TEST_TODO1_" ls "  and more" @home
2 item 2 @home   and more
--
TODO: 1 of 3 tasks shown
EOF

test_done
