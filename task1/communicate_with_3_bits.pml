mtype = {msg, ack};
chan toProceccA = [2] of {mtype, bit};
chan toProceccB = [2] of {mtype, bit};
chan toProceccC = [2] of {mtype, bit};

active proctype ProcessA()
{
again: toProceccB ! msg, 1;
       toProceccA ? ack, 1;
       toProceccB ! msg, 0;
       toProceccA ? ack, 0;
goto again
}

active proctype ProcessB()
{
again: toProceccB ? msg, 1;
       toProceccC ! msg, 1;
       toProceccB ? msg, 0;
       toProceccC ! msg, 0;
goto again
}

active proctype ProcessC()
{
again: // toProceccC ? msg, 1;
       toProceccA ! ack, 1;
       // toProceccC ? msg, 0;
       toProceccA ! ack, 0;
goto again
}
