"
I am a segment between two vertices
"
Class {
	#name : #GSegment,
	#superclass : #GElement,
	#instVars : [
		'v1',
		'v2'
	],
	#category : #'Geometry-Elements'
}

{ #category : #'as yet unclassified' }
GSegment class >> with: aPoint1 with: aPoint2 [
	^ self new
		initializeWith: aPoint1 with: aPoint2;
		yourself
]

{ #category : #comparing }
GSegment >> = aSegment [
	self == aSegment ifTrue: [ ^ true ].
	self class = aSegment class ifFalse: [ ^ false ].
	
	^ (v1 =~ aSegment v1 and: [ v2 =~ aSegment v2 ])
		or: [ v1 =~ aSegment v2 and: [ v2 =~ aSegment v1 ] ]
]

{ #category : #properties }
GSegment >> alreadyExistIn: aSet [
	^ aSet detect: [ :segment | segment asLine = self asLine ] ifFound: [ true ] ifNone: [ false ]
]

{ #category : #properties }
GSegment >> asLine [
	^ GLine through: v1 and: v2
]

{ #category : #properties }
GSegment >> belowPoint: aGPoint [
	self flag: #todo. "This is only for 2D. We should review it to works with v1 and v2 that are 3D."
	^ (v2 x - v1 x) * (aGPoint y - v1 y) - ((v2 y - v1 y) * (aGPoint x - v1 x)) > 0
]

{ #category : #properties }
GSegment >> boundBy: aGPoint [
	^ self v1 = aGPoint or: [ self v2 = aGPoint ]
]

{ #category : #properties }
GSegment >> cutWith: frame [
	| coll |
	coll := OrderedCollection new.
	frame edges
		collect: [ :edge | edge intersectionPointWithSegment: self ]
		thenDo: [ :p | 
			(p notNil and: [ coll noneSatisfy: [ :p2 | p2 =~ p ] ])
				ifTrue: [ coll add: p ] ].
	coll
		ifEmpty: [ "self halt"
			(frame hasPoint: self v1)
				ifTrue: [ ^ self ]
				ifFalse: [ ^ nil ] ].
	coll size = 2
		ifTrue: [ ^ GSegment with: coll first with: coll second ].
	(frame hasPoint: self v1)
		ifTrue: [ ^ GSegment with: coll first with: self v1 ]
		ifFalse: [ ^ GSegment with: coll first with: self v2 ]
]

{ #category : #properties }
GSegment >> dist: p [
	self deprecated: 'Use #distanceTo:' transformWith: '`@receiver dist: `@statements' -> '`@receiver distanceTo: `@statements'.
	^ self distanceTo: p
]

{ #category : #properties }
GSegment >> distTo: point [
	self deprecated: 'Use #distanceTo:' transformWith: '`@receiver distTo: `@statements' -> '`@receiver distanceTo: `@statements'.
	^ self distanceTo: point
]

{ #category : #properties }
GSegment >> distanceTo: aGPoint [
	self flag: #todo. "«The distance between segments and rays may not be the same as the distance between their extended lines. » http://geomalgorithms.com/a07-_distance.html
	
	So apparently this implementation is wrong."
	^ self asLine dist: aGPoint
]

{ #category : #properties }
GSegment >> extendSegmVert: v to: frame [
	| points ver p |
	self flag: #todo.	"This is only for 2D. We should review it to works with v1 and v2 that are 3D."
	points := frame intersectionPointsWithLine: self asLine.
	ver := self vertices detect: [ :vi | vi ~= v ].
	p := ver x = v x
		ifTrue: [ ver y > v y
				ifTrue: [ points detect: [ :pi | pi y < v y ] ]
				ifFalse: [ points detect: [ :pi | pi y > v y ] ] ]
		ifFalse: [ ver x > v x
				ifTrue: [ points detect: [ :pi | pi x < v x ] ]
				ifFalse: [ points detect: [ :pi | pi x > v x ] ] ].
	^ GSegment with: ver with: p
]

{ #category : #properties }
GSegment >> extendWith: aGPoint and: frame [
	| points v |
	(self asLine includesPoint: aGPoint)
		ifFalse: [ ^ self ].
	(self v1 distanceTo: aGPoint) < (self v2 distanceTo: aGPoint)
		ifTrue: [ v1 := aGPoint ]
		ifFalse: [ v2 := aGPoint ].
	v := self vertices detect: [ :p | p ~= aGPoint ].
	points := frame intersectionPointsWithLine: self asLine.
	points size = 2
		ifTrue: [ ((GSegment with: aGPoint with: points first) includesPoint: v)
				ifTrue: [ ^ GSegment with: aGPoint with: points first ]
				ifFalse: [ ^ GSegment with: aGPoint with: points second ] ]
]

{ #category : #properties }
GSegment >> has: aGPoint [
	self deprecated: 'Use #includesPoint:' transformWith: '`@receiver has: `@statements' -> '`@receiver includesPoint: `@statements'.
	^ self includesPoint: aGPoint
]

{ #category : #properties }
GSegment >> hasOnLinePoint: aGPoint [
	| e k edges tr v|
	self flag: #todo. "This is only for 2D. We should rely on GPoints to be able to do it for n-dimensions."
	(self v1 =~ aGPoint or:[ self v2 =~ aGPoint] ) 
		ifTrue:[^true]
		ifFalse:[
			tr := ( GTriangle with: aGPoint with: self v1 with: self v2 ).
			edges:= tr edges.
			k := edges detectMax: [:ed | ed length].
			e := (1/2)*(
					(( self v1 x - self v2 x ) * ( aGPoint y - self v2 y )-
					(( self v1 y - self v2 y ) * ( aGPoint x - self v2 x )))
					abs
			/k length).
			v := tr vertices detect:[ :vi |  vi~= k v1 and:[ vi ~= k v2 ]].
			^ "k asLine hasPoint: v withApproximation: e."
			(k dist: v) <=~ (2*e)] 
	

]

{ #category : #properties }
GSegment >> hasOnLinePoint: aGPoint withRespectTo: vert [
	| e k edges tr v|
	self flag: #todo. "This is only for 2D. We should rely on GPoints to be able to do it for n-dimensions."
	(self v1 =~ aGPoint or:[ self v2 =~ aGPoint] ) 
		ifTrue:[^ true]
		ifFalse:[ "(vert x < self v2 x)
			ifTrue:[
				(vert x < p x and:[ p x < self v2 x ])
				or:[ (vert x < self v2 x and:[ p x > self v2 x ])]]"
			((
			( aGPoint x between: vert x and: self v2 x)and:
			[ aGPoint y between: vert y and: self v2 y]) 
		or:[ (self v2 x between: vert x and: aGPoint x) and:
			(self v2 y between: vert y and: aGPoint y)])
				ifFalse:[^ false]
				ifTrue:[
					tr := ( GTriangle with: aGPoint with: self v1 with: self v2 ).
					edges:= tr edges.
					k := edges detectMax: [:ed | ed length].
					e := (1/2)*(
							(( self v1 x - self v2 x ) * ( aGPoint y - self v2 y )-
							(( self v1 y - self v2 y ) * ( aGPoint x - self v2 x )))
							abs
					/k length).
					v := tr vertices detect:[ :vi |  vi~= k v1 and:[ vi ~= k v2 ]].
					^ "k asLine hasPoint: v withApproximation: e."
					(k dist: v) <=~ (2*e)]] 
	

]

{ #category : #properties }
GSegment >> hasOnLinePoint: aGPoint withRespectTo: vert withApprox: apro [
	| e k edges tr v eps |
	self flag: #todo.	"This is only for 2D. We should rely on GPoints to be able to do it for n-dimensions."
	(self v1 =~ aGPoint or: [ self v2 =~ aGPoint ])
		ifTrue: [ ^ true ]
		ifFalse: [ tr := GTriangle with: aGPoint with: self v1 with: self v2.
			edges := tr edges.
			k := edges detectMax: [ :ed | ed length ].
			eps := 1 / 2
				*
					(((self v1 x - self v2 x) * (aGPoint y - self v2 y)
						- ((self v1 y - self v2 y) * (aGPoint x - self v2 x))) abs
						/ k length).
			e := apro min: eps.
			(((aGPoint x isBetween: vert x and: self v2 x with: e)
				and: [ aGPoint y isBetween: vert y and: self v2 y with: e ])
				or: [ (self v2 x isBetween: vert x and: aGPoint x with: e)
						and: (self v2 y isBetween: vert y and: aGPoint y with: e) ])
				ifFalse: [ ^ false ]
				ifTrue: [ "tr := ( GTriangle with: p with: self v1 with: self v2 ).
					edges:= tr edges.
					k := edges detectMax: [:ed | ed length].
					e := (1/2)*(
							(( self v1 x - self v2 x ) * ( p y - self v2 y )-
							(( self v1 y - self v2 y ) * ( p x - self v2 x )))
							abs
					/k length)."
					v := tr vertices detect: [ :vi | vi ~= k v1 and: [ vi ~= k v2 ] ].
					(k distanceTo: v) <=~ (2 * e)
						ifTrue: [ ^ true	"(k asLine hasPoint: v withApproximation: e)" ]
						ifFalse: [ ^ false ] ]	"and:[ self asLine hasPoint: p withApproximation: e ]" ]
]

{ #category : #properties }
GSegment >> hasPoint: aGPoint [
	self deprecated: 'Use #hasPoint:' transformWith: '`@receiver hasPoint: `@statements' -> '`@receiver includesPoint: `@statements'.
	^ self includesPoint: aGPoint
]

{ #category : #initialization }
GSegment >> hash [
	^ v1 hash bitXor: v2 hash
]

{ #category : #properties }
GSegment >> includesPoint: aGPoint [
	"The point is on the segment if the sum of the distance from v1 to aGPoint and the distance of a GPoint to v2 is my length"

	^ (v2 distanceTo: aGPoint) + (aGPoint distanceTo: v1) =~ self length
]

{ #category : #initialization }
GSegment >> initializeWith: aPoint1 with: aPoint2 [
	v1 := aPoint1 asGPoint.
	v2 := aPoint2 asGPoint
]

{ #category : #properties }
GSegment >> intersect: aSegment [
	self flag: #todo.	"Use polymorphism to accept any kind of argument that is a GElement"
	^ (self asLine intersect: aSegment asLine)
		ifNotNil: [ :point | 
			((self includesPoint: point) and: [ aSegment includesPoint: point ])
				ifTrue: [ point ] ]
]

{ #category : #properties }
GSegment >> intersectionPointWithLine: aLine [
	^ (self asLine intersect: aLine)
		ifNotNil: [ :point | 
			(self includesPoint: point)
				ifTrue: [ point ]
				ifFalse: [ nil ] ]
]

{ #category : #properties }
GSegment >> intersectionPointWithRay: ray [
	^ (self asLine intersect: ray asLine)
		ifNotNil: [ :point | 
			((self includesPoint: point) and: [ ray includesPoint: point ])
				ifTrue: [ point ]
				ifFalse: [ nil ] ]
]

{ #category : #properties }
GSegment >> intersectionPointWithSegment: segm [
	^ (self asLine intersect: segm asLine)
		ifNotNil: [ :point | 
			((self includesPoint: point) and: [ segm includesPoint: point ])
				ifTrue: [ point ]
				ifFalse: [ nil ] ]
]

{ #category : #properties }
GSegment >> isOnLineWith: segm [
	self = segm
		ifTrue: [ ^ true ]
		ifFalse: [ ^ self asLine = segm asLine ]
]

{ #category : #properties }
GSegment >> length [
	"The distance between two points is the length of the vector transposing v1 into v2"

	^ (v2 - v1) length
]

{ #category : #properties }
GSegment >> midPoint [
	^ ((v1 coordinates + v2 coordinates) / 2) asGPoint
]

{ #category : #properties }
GSegment >> perpendicularBisector [
	self flag: #todo.	"This is only for 2D. We should rely on GPoints to be able to do it for n-dimensions."

	^ GLine a: v2 x - v1 x b: v2 y - v1 y c: (v1 x * v1 x - (v2 x * v2 x) + (v1 y * v1 y) - (v2 y * v2 y)) / 2
]

{ #category : #printing }
GSegment >> printOn: aStream [
	v1 printOn: aStream.
	aStream nextPutAll: '>-<'.
	v2 printOn: aStream
]

{ #category : #accessing }
GSegment >> v1 [
	^ v1
]

{ #category : #accessing }
GSegment >> v1: aGPoint [
	v1 := aGPoint
]

{ #category : #accessing }
GSegment >> v2 [
	^ v2
]

{ #category : #accessing }
GSegment >> v2: aGPoint [
	v2 := aGPoint
]

{ #category : #initialization }
GSegment >> vertices [
	^ { v1 . v2 }
]
