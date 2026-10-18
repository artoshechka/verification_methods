#define N 5

mtype = { msgtype,REQUEST,GRANT,DONE };

chan c[N] = [0] of { mtype };
chan d[N] = [0] of { mtype };
chan w[N] = [0] of { mtype };

proctype phil(chan left,right,waiter;byte mn) {
	byte curState = 0;
	printf("MSC: phil # %d \n",mn);
	do
	:: (curState == 1) -> 
		waiter!REQUEST;
		waiter?GRANT;
		curState = 2;
	:: (curState == 2) -> 
		left!msgtype;
		curState = 3;
	:: (curState == 3) -> 
		right!msgtype;
		curState = 4;
	:: (curState == 4) -> 
		curState = 5;
	:: (curState == 5) -> 
		right!msgtype;
		curState = 6;
	:: (curState == 6) -> 
		left!msgtype;
		curState = 7;
	:: (curState == 7) -> 
		waiter!DONE;
		curState = 0;
	:: (curState == 0) -> 
		curState = 1;
	od
}

proctype fork(chan leftPhill,rightPhill) {
	byte curStateFork = 0;
	end:
	do
	:: (curStateFork == 0) -> 
		if
		:: rightPhill?msgtype -> curStateFork = 2;
		:: leftPhill?msgtype -> curStateFork = 1;
		:: skip;
		fi
	:: (curStateFork == 1) -> 
		leftPhill?msgtype -> curStateFork = 0;
	:: (curStateFork == 2) -> 
		rightPhill?msgtype -> curStateFork = 0;
	od
}

proctype waiter() {
	byte count = 0;
	do
	:: (count < N - 1) -> 
		if
		:: w[0]?REQUEST -> w[0]!GRANT;count++
		:: w[1]?REQUEST -> w[1]!GRANT;count++
		:: w[2]?REQUEST -> w[2]!GRANT;count++
		:: w[3]?REQUEST -> w[3]!GRANT;count++
		:: w[4]?REQUEST -> w[4]!GRANT;count++
		fi
	:: (count > 0) -> 
		if
		:: w[0]?DONE -> count--
		:: w[1]?DONE -> count--
		:: w[2]?DONE -> count--
		:: w[3]?DONE -> count--
		:: w[4]?DONE -> count--
		fi
	od
}

init {
	run phil(d[0],c[0],w[0],0);
	run phil(d[1],c[1],w[1],1);
	run phil(d[2],c[2],w[2],2);
	run phil(d[3],c[3],w[3],3);
	run phil(d[4],c[4],w[4],4);
	
	run fork(c[0],d[1]);
	run fork(c[1],d[2]);
	run fork(c[2],d[3]);
	run fork(c[3],d[4]);
	run fork(c[4],d[0]);
	
	run waiter();
}