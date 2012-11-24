#!/bin/bash
#

test_description='default context with multiline add

This test checks that the default context functionality works.
'
. ./test-lib.sh

TEST_TODO_=todo.cfg

#
# check default context with multiline add
#
TEST_TODO1_=todo1.cfg
sed -e "s/^.*export TODOTXT_DEFAULT_CONTEXTS=.*$/export TODOTXT_DEFAULT_CONTEXTS='@work'/" "${TEST_TODO_}" > "${TEST_TODO1_}"

## Multiple line addition
# Create the expected file
echo "1 item 1 @work
TODO: 1 added." > "$HOME/expect.multi"
echo "2 item 2
TODO: 2 added." >>"$HOME/expect.multi"
echo "3 item 3 @home
TODO: 3 added." >>"$HOME/expect.multi"

test_expect_success 'multiline add with default context set' '
(
# Run addm
"$HOME/bin/todo.sh" -d ${TEST_TODO1_} addm "item 1
item 2 @
item 3 @home" > "$HOME/output.multi"

# Test output against expected
diff "$HOME/output.multi" "$HOME/expect.multi"
if [ $? -ne 0 ]; then
  exit 1
else
  exit 0
fi
)
'


test_done
