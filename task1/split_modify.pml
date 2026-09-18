#define N 128
#define size 16

chan ch = [size] of { short };
chan large = [size] of { short };
chan small = [size] of { short };

proctype split()
{
    short data;
    do
    :: ch ? data ->
        if
        :: (data >= 128) -> large ! data
        :: (data < 128)  -> small ! data
        fi
    od
}

proctype merge()
{
    short data;

    do
    :: if
       :: large ? data
       :: small ? data
       fi;
       ch ! data
    od
}

init
{
    ch ! 130;
    ch ! 12;
    run split();
    run merge();
}