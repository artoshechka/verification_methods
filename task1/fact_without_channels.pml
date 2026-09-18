int result = 1;
int depth = 0;

proctype fact(int n)
{
    if
    :: (n <= 1) -> skip
    :: (n >= 2) ->
        result = result * n;
        run fact(n - 1)
    fi
}

init
{
    run fact(5);
    (depth == 0);
    printf("result = %d\n", result)
}