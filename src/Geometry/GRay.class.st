"
Description
--------------------

A ray starts out at a point and continues off to infinity

A ray is a geometry figure defined by an initial point, the origin, and another point to define a direction.

Examples
--------------------

TODO	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	directionPoint:		<aGPoint>		A point that can be anywhere on the ray and defining the direction of the ray.
	initialPoint:		<aGPoint>		A GPoint defining the end point of the ray.

"
Class {
	#name : #GRay,
	#superclass : #GElement,
	#instVars : [
		'initialPoint',
		'directionPoint'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'instance creation' }
GRay class >> origin: aGPoint direction: anotherPoint [
	^ self new
		initializeWithOrigin: aGPoint direction: anotherPoint;
		yourself
]

{ #category : #arithmetic }
GRay >> * aRay [

^ ( self origin x - self direction x ) * ( aRay origin x - aRay direction x ) 
+ (( self origin y - self direction y ) * ( aRay origin y - aRay direction y ) )
]

{ #category : #arithmetic }
GRay >> + aRay [
	| newOrigin vector |
	
	newOrigin := self origin + aRay origin / 2.
	
	vector := (self direction - self origin) + 
				 (aRay direction - aRay origin).

	^ GRay origin: newOrigin direction: newOrigin + vector
 
]

{ #category : #comparing }
GRay >> = aRay [
	self == aRay ifTrue: [ ^ true ].
	self class = aRay class ifFalse: [ ^ false ].

	^ self origin =~ aRay origin and: [ (self angleInRadiansWith: aRay) closeTo: 0 ]
]

{ #category : #arithmetic }
GRay >> angleInRadiansWith: aGRay [ 
	^ (self direction - self origin) angleInRadiansWith: (aGRay direction - aGRay origin)
]

{ #category : #converting }
GRay >> asLine [
	^ GLine through: self origin and: self direction
]

{ #category : #converting }
GRay >> asSegment [
	^ GSegment with: initialPoint with: directionPoint
]

{ #category : #properties }
GRay >> cutWith: frame [
	| coll |
	coll := OrderedCollection new.
	frame edges
		collect: [ :edge | edge intersectionPointWithRay: self ]
		thenDo: [ :p | (p notNil and: [ coll noneSatisfy: [ :p2 | p2 =~ p ] ]) ifTrue: [ coll add: p ] ].
	coll isEmpty
		ifTrue: [ ^ nil ]
		ifFalse: [ coll size = 2 ifTrue: [ ^ GSegment with: coll first with: coll second ] ifFalse: [ ^ GSegment with: coll first with: self origin ] ]
]

{ #category : #accessing }
GRay >> direction [
	^directionPoint 

]

{ #category : #'rectangle functions' }
GRay >> extendBy1: num [
|vect k  xn yn|
	( self origin x = self direction x ) 
		ifTrue:[ xn := self origin x.
			( self origin y > self direction y )
				ifFalse:[ yn := self direction y + num. ] 
				ifTrue:[ yn := self direction y - num ] ]
		ifFalse:[
			k := ( self origin y - ( self direction y ) )/( self origin x - ( self direction x ) ).
			( self origin x > self direction x ) 
				ifFalse:[ xn := self direction x + num. ] 
				ifTrue:[ xn := self direction x - num. ].
			yn := self direction y + ( k *( xn - self direction x ))].
	vect := GRay origin: self origin direction: ( xn @ yn ).
	(vect asLine = self asLine)
	ifTrue:[^vect]

]

{ #category : #'rectangle functions' }
GRay >> extendBy: num [
	| cos sin |
	self length = 0
		ifTrue: [ directionPoint := ((directionPoint - initialPoint) x * num) @ ((directionPoint - initialPoint) y * num) ]
		ifFalse: [ cos := (directionPoint - initialPoint) x / self length.
			sin := (directionPoint - initialPoint) y / self length.
			directionPoint := (cos * num * self length) @ (sin * num * self length) ].
	^ self
]

{ #category : #'rectangle functions' }
GRay >> extendWith: num [
	| cos sin |
	cos := (directionPoint - initialPoint) x / self length.
	sin := (directionPoint - initialPoint) y / self length.
	directionPoint := (self direction x + (cos * num)) @ (self direction y + (sin * num)).
	^ self
]

{ #category : #properties }
GRay >> flipped [
	^ GRay origin: self origin direction: initialPoint + (initialPoint - directionPoint)
]

{ #category : #properties }
GRay >> hasPoint: aGPoint [
	self deprecated: 'Use #hasPoint:' transformWith: '`@receiver hasPoint: `@statements' -> '`@receiver includesPoint: `@statements'.
	^ self includesPoint: aGPoint
]

{ #category : #comparing }
GRay >> hash [
	"We define the hash by its origin and the angle the ray has with the x axis."

	^ self origin hash bitXor: (self direction - self origin angleInRadiansWith: {1 . 1} asGVector) hash
]

{ #category : #properties }
GRay >> includesPoint: aPoint [
	^ (initialPoint - directionPoint) signFuz = (initialPoint - aPoint) signFuz or: [ initialPoint = aPoint ]
]

{ #category : #initialization }
GRay >> initialize [
	super initialize.
	initialPoint := 0@0.
	directionPoint := 0@0
]

{ #category : #initialization }
GRay >> initializeWithOrigin: aGPoint direction: anotherGPoints [
	initialPoint  := aGPoint asGPoint.
	directionPoint  := anotherGPoints asGPoint
]

{ #category : #accessing }
GRay >> length [
	"A ray is not finite."

	^ Float infinity
]

{ #category : #accessing }
GRay >> origin [ 
	^initialPoint

]
