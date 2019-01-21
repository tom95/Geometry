Class {
	#name : #GElementTestCase,
	#superclass : #GTestCase,
	#category : #'Geometry-Tests'
}

{ #category : #testing }
GElementTestCase class >> isAbstract [
	^ self = GElementTestCase
]

{ #category : #accessing }
GElementTestCase >> testIncludes [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithArc [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithEllipse [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithLine [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithPolygon [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithRay [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testIntersectionsWithSegment [
	^ self subclassResponsibility
]

{ #category : #accessing }
GElementTestCase >> testTranslateBy [
	^ self subclassResponsibility
]
