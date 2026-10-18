#define fin (allRightSide == true)
#define gc (gAndC == false)
#define wg  (wAndG == false)	
bool  allRightSide,wAndG,gAndC;

active proctype river()
{
	bit f = 0,w = 0,g = 0,c = 0;
	do
	:: (f == 1) && (f == w) && (f == g) && (f == c) -> allRightSide = true;break;
	:: else -> 
		if
		:: (f == w) -> f = 1 - f;w = 1 - w;
		:: (f == g) -> f = 1 - f;g = 1 - g;
		:: (f == c) -> f = 1 - f;c = 1 - c;
		:: (true) -> f = 1 - f;
		fi;
		if
		:: (f != g) && (g == c) -> gAndC = true;
		:: (f != w) && (w == g) -> wAndG = true;
		:: else -> skip
		fi;
	od;
	printf("DONE!");
}
// never{
// 	do
// 	:: (fin & gc & wg) -> break;
// 	:: else
// 		od;	
// 	}
ltl {!( <> fin && []( wg && gc ) )}