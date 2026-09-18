mtype = {msg, ack};
chan to_sender = [2] of {mtype, bit};
chan to_receiver = [2] of {mtype, bit};

active proctype Sender()
{
again: to_receiver ! msg, 1;
       to_sender ? ack, 1;
       to_receiver ! msg, 0;
       to_sender ? ack, 0;
goto again
}

active proctype Receiver()
{
again: to_receiver ? msg, 1;
       to_sender ! ack, 1;
       to_receiver ? msg, 0;
       to_sender ! ack, 0;
goto again
}