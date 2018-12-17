Class {
	#name : #GRayTest,
	#superclass : #TestCase,
	#instVars : [
		'ray'
	],
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GRayTest >> testAngleInRadiansWith [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 5 , 24.
	ray2 := GRay origin: 3 , 4 direction: 4 , 7.
	self assert: (ray angleInRadiansWith: ray2) closeTo: 0.11635
]

{ #category : #tests }
GRayTest >> testCutWith [
	self assert: ((GRay origin: -10 , 10 direction: 20 , 30) cutWith: (GRectangle origin: -15 , 0 corner: 15 , 15)) v1 equals: -5 , 2 , 15.
	self assert: ((GRay origin: -10 , 10 direction: 20 , 30) cutWith: (GRectangle origin: -15 , 0 corner: 15 , 15)) v2 equals: -10 , 10.
	self assert: ((GRay origin: -30 , 0 direction: 20 , 30) cutWith: (GRectangle origin: -15 , 0 corner: 15 , 15)) v1 equals: -15 , 9.
	self assert: ((GRay origin: -30 , 0 direction: 20 , 30) cutWith: (GRectangle origin: -15 , 0 corner: 15 , 15)) v2 equals: -5 , 15.
	self assert: ((GRay origin: -30 , 30 direction: 20 , 30) cutWith: (GRectangle origin: -15 , 0 corner: 15 , 15)) equals: nil
]

{ #category : #tests }
GRayTest >> testEquals [
	| ray2 |
	ray := GRay origin: 0 , 0 direction: 1 , 1.
	ray2 := GRay origin: 0 , 0 direction: 2 , 2.
	self assert: ray equals: ray2.
	self assert: ray hash equals: ray2 hash.

	ray2 := GRay origin: 0,0 direction: 2, 3.
	self deny: ray equals: ray2.
	self deny: ray hash equals: ray2 hash
]

{ #category : #tests }
GRayTest >> testExtendBy [
	self assert: ((GRay origin: 0 , 0 direction: 12 , 9) extendBy1: 1) direction equals: 13 , (39 , 4).
	self assert: ((GRay origin: 0 , 0 direction: 12 , 9) extendBy1: 5) direction equals: 17 , (51 , 4)
	"self assert: ((GRay origin:0 ,0 direction: (4 ,2)) extendBy: 1) direction equals:5 ,(5/ 2).
	self assert: ((GRay origin:0 ,0 direction: (-4 ,-2)) extendBy: 1) direction equals: -5 ,(-5/ 2).
	self assert: ((GRay origin:0 ,0 direction: (-4 ,2)) extendBy: 1) direction equals: -5 ,(5/ 2).
	self assert: ((GRay origin:0 ,0 direction: (4 ,-2)) extendBy: 1) direction equals:5 ,(-5/ 2).
	self assert: ((GRay origin:0 ,0 direction: (12 ,9)) extendBy: 1) asLine equals: ((GRay origin:0 ,0 direction: ((12 ,9))) extendBy: 5) asLine.
	self deny: ((GRay origin:0 ,0 direction: (12 ,9)) extendBy: 1) asLine ~= ((GRay origin:0 ,0 direction: (12 ,9)) extendBy: 5) asLine.
	self assert: ((GRay origin:4 ,2 direction: (0 ,2)) extendBy: 1) direction equals: -1 ,2.
	self assert: ((GRay origin:4 ,2 direction: (4 ,0)) extendBy: 1) direction equals:4 ,-1.
	self assert: ((GRay origin:4 ,2 direction: (0 ,0)) extendBy: 1) direction equals: -1 ,(-1/ 2).
	self assert: ((GRay origin:4 ,2 direction: (2 ,1)) extendBy: 1) direction equals:1 ,(1/ 2).
	self assert: ((GRay origin: 63 ,61 direction: (62 ,61)) extendBy: 5) direction equals: 57 ,61
	"
]

{ #category : #tests }
GRayTest >> testFlipped [
	self assert: (GRay origin: 100 , 100 direction: 80 , 110) flipped direction equals: 120 , 90.
	self assert: (GRay origin: 100 , 100 direction: 120 , 90) flipped direction equals: 80 , 110
]

{ #category : #tests }
GRayTest >> testIncludesPoint [
	self deny: ((GRay origin: 100 , 100 direction: 80 , 110) includesPoint: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includesPoint: 120 , 90).
	self assert: ((GRay origin: 100 , 100 direction: 120 , 90) includesPoint: 100 , 100).
	self assert: ((GRay origin: 100 , 100 direction: 110 , 110) includesPoint: 150 , 150).
	self assert: ((GRay origin: 0 , 0 direction: 12 , 9) includesPoint: 13 , (39 / 4)).
	self assert: ((GRay origin: 28 , 30 direction: -14.19823766979061 , -21.67099433810146) includesPoint: 9 , 1).
	self assert: ((GRay origin: 20 , 23 direction: -16.331370027835703 , -32.66274005567141) includesPoint: 9 , 1)
	"self assert: ((( GRay origin: 0 , 0 direction: (12 ,9)) extendBy: 1 ) asSegment has: 13,(39/4)).
	self assert: ((( GRay origin: 0 , 0 direction: (12 , 9)) extendBy: 5 ) asSegment has: 13,(39/4)).
	self deny: 	((( GRay origin: 0 , 0 direction: (12 , 9)) extendBy: 1 ) asSegment has: 17,(51/4)).
	self assert: (((GRay origin: (57583 / 914) , (56095 / 914) direction: (62.998905906959145 , 61.37297058105469)) extendBy: 5) asSegment has: 62.998905906959145 , 61.37297058105469).
	self assert: (((GRay origin: 63 , 61 direction: (62 , 61)) extendBy: 5) asSegment has: 62 , 61).
	self assert: ((GRay origin: 0 , 0 direction: (12 , 9)) includesPoint: 13 , (39 / 4)).
	self deny: ((GRay origin: 0 , 0 direction: (12 , 9)) asSegment includesPoint: 13 , (39 / 4)).
	self assert: ((GRay origin: 0 , 0 direction: (13 , (39 / 4))) hasPoint: 12 , 9).
	self assert: ((GRay origin: 0 , 0 direction: (13 , (39 / 4))) asSegment hasPoint: 12 , 9)"
]

{ #category : #tests }
GRayTest >> testIntersect [
	self skip.
	self
		assert:
			((GRay origin: 28 , 30 direction: -14.19823766979061 , -21.67099433810146) asLine
				intersect: (GRay origin: 20 , 23 direction: -16.331370027835703 , -32.66274005567141) asLine)
		equals: 9 , 1
]

{ #category : #tests }
GRayTest >> testMultiply [
	self assert: (GRay origin: 0 , 0 direction: -12 , 16) * (GRay origin: 0 , 0 direction: 12 , 9) equals: 0
]
