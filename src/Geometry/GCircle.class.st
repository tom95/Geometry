"
I am a circle. I have a center in (cx, cy) and radius. My equation is: 
(x-cx)^2  + (y-cy)^2 = radius^2 or 
a * (x^2) + a * (y^2) + d * x + e * y + f = 0 

"
Class {
	#name : #GCircle,
	#superclass : #GShape,
	#instVars : [
		'center',
		'radius'
	],
	#category : #'Geometry-Shapes'
}

{ #category : #'as yet unclassified' }
GCircle class >> center: aPoint1 radius: aNumber [
	^ self new initializeWithCenter: aPoint1 radius: aNumber
]

{ #category : #comparing }
GCircle >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ center =~ anObject center and: [ radius =~ anObject radius ]
]

{ #category : #accessing }
GCircle >> area [
	^ 2 * Float pi * self radius squared
]

{ #category : #comparing }
GCircle >> boundaryContains: aPoint [
	^ self radius =~ (self center distanceTo: aPoint)
]

{ #category : #comparing }
GCircle >> boundaryContainsAny: points [
	^ points anySatisfy: [ :point | self boundaryContains: point ]
]

{ #category : #comparing }
GCircle >> boundaryContainsWhichOf: points [
	^ points select: [ :point | self boundaryContains: point ]
]

{ #category : #accessing }
GCircle >> center [
	"Since we have it, diretly return it to be faster than my original implementation"
	
	^ center
]

{ #category : #testing }
GCircle >> contains: aPoint [
	^ (self includesPoint: aPoint) and: [ (self boundaryContains: aPoint) not ]
]

{ #category : #accessing }
GCircle >> encompassingRectangle [
	^ (center + ({radius . radius} asGVector)) corner: (center + ({radius negated. radius negated} asGVector))
]

{ #category : #comparing }
GCircle >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ center hash bitXor: radius hash
]

{ #category : #testing }
GCircle >> includesPoint: aGPoint [
	^ self radius >=~ (self center distanceTo: aGPoint)
]

{ #category : #initialization }
GCircle >> initializeWithCenter: aPoint1 radius: aNumber [
	center := aPoint1 asGPoint.
	radius := aNumber.
]

{ #category : #intersections }
GCircle >> intersectionsWith: anElement [
	^ anElement intersectionsWithCircle: self
]

{ #category : #intersections }
GCircle >> intersectionsWithLine: aGLine [
	| h k b m c e t b2m2 b2 m2 k2 t2 tk sqrt b2m x1 x2 y1 y2 sqrtContent |
	h := center x.
	k := center y.
	b := self radius.
	aGLine b = 0 ifTrue: [ self flag: #todo.	"Not yet supported" ^ {} ].
	m := aGLine a / aGLine b negated.
	c := aGLine c / aGLine b negated.
	e := c - k.
	t := c + (m * h).
	b2 := b squared.
	m2 := m squared.
	k2 := k squared.
	t2 := t squared.
	b2m := b2 * m.
	b2m2 := b2 * m2.
	tk := t * k.
	sqrtContent := b2m2 + b2 - t2 - k2 + (2 * tk).
	sqrtContent >= 0 ifFalse: [ ^ {} ].	"No intersections"
	sqrt := (b2m2 + b2 - t2 - k2 + (2 * tk)) sqrt.

	x1 := (h * b2 - (m * b2 * e) + (b2 * sqrt)) / (b2m2 + b2).
	x2 := (h * b2 - (m * b2 * e) - (b2 * sqrt)) / (b2m2 + b2).
	y1 := (b2 * t + (k * b2m2) + (b2m * sqrt)) / (b2m2 + b2).
	y2 := (b2 * t + (k * b2m2) - (b2m * sqrt)) / (b2m2 + b2).

	^ {(x1 , y1) . (x2 , y2)} asSet
]

{ #category : #accessing }
GCircle >> perimeter [
	^ 2 * self radius * Float pi
]

{ #category : #'public interface' }
GCircle >> polygonOn: points [
|polygonSegm firstP notUsedPoints currentP|
	currentP := points anyOne.
	firstP := currentP.
	notUsedPoints := points asOrderedCollection remove: currentP; yourself.
	polygonSegm := OrderedCollection new.
	
	[ notUsedPoints isNotEmpty ] whileTrue: [
		| nextP |
		nextP := notUsedPoints detectMin: [ :point | point distanceTo: currentP ].
		polygonSegm add:( GSegment with: currentP with: nextP).
		currentP := nextP.
		notUsedPoints remove: currentP ].
	polygonSegm add:( GSegment with: currentP with: firstP).
	^ polygonSegm
]

{ #category : #accessing }
GCircle >> radius [
	^ radius
]

{ #category : #'public interface' }
GCircle >> upperPoint [
	^ center x , ( center y + radius )
]
