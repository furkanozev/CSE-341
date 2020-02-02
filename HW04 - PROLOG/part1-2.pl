% Part1 and Part2 are in this file.

% knowledge base
flight(edirne,edremit).

flight(edremit,edirne).
flight(edremit,erzincan).

flight(erzincan,edremit).

flight(burdur,ısparta).

flight(ısparta,burdur).
flight(ısparta,izmir).

flight(izmir,ısparta).
flight(izmir,istanbul).

flight(istanbul,izmir).
flight(istanbul,antalya).
flight(istanbul,gaziantep).
flight(istanbul,ankara).
flight(istanbul,van).
flight(istanbul,rize).

flight(antalya,istanbul).
flight(antalya,konya).
flight(antalya,gaziantep).

flight(gaziantep,istanbul).
flight(gaziantep,antalya).

flight(konya,antalya).
flight(konya,ankara).

flight(ankara,konya).
flight(ankara,istanbul).
flight(ankara,van).

flight(van,ankara).
flight(van,istanbul).
flight(van,rize).

flight(rize,van).
flight(rize,istanbul).

%rules..
route(X, Y) :- routex(X, Y, []).
routex(X, Y, VisitList) :- flight(X, Z), not(member(Z, VisitList))
						, (Y = Z; routex(Z, Y, [X | VisitList])).

%---- PART 2 ----%

%facts..
distance(edirne,edremit,235).

distance(edremit,edirne,235).
distance(edremit,erzincan,1066).

distance(erzincan,edremit,1066).

distance(burdur,ısparta,25).

distance(ısparta,burdur,25).
distance(ısparta,izmir,309).

distance(izmir,ısparta,309).
distance(izmir,istanbul,329).

distance(istanbul,izmir,329).
distance(istanbul,antalya,483).
distance(istanbul,gaziantep,847).
distance(istanbul,ankara,352).
distance(istanbul,van,1262).
distance(istanbul,rize,373).

distance(antalya,istanbul,483).
distance(antalya,konya,192).
distance(antalya,gaziantep,592).

distance(gaziantep,istanbul,847).
distance(gaziantep,antalya,592).

distance(konya,antalya,192).
distance(konya,ankara,227).

distance(ankara,konya,227).
distance(ankara,istanbul,352).
distance(ankara,van,920).

distance(van,ankara,920).
distance(van,istanbul,1262).
distance(van,rize,373).

distance(rize,van,373).
distance(rize,istanbul,373).

%rules..
sroute(C1,C2,X) :- flight(C1,C2), distance(C1,C2,X).
sroute(C1,C2,X) :- flight(C1,C3), flight(C3,C2), distance(C1,C3,X1)
					, distance(C3,C2,X2), X is X1+X2.