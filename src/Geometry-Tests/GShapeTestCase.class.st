Class {
	#name : #GShapeTestCase,
	#superclass : #GElementTestCase,
	#category : #'Geometry-Tests'
}

{ #category : #testing }
GShapeTestCase class >> isAbstract [
	^ self = GShapeTestCase
]

{ #category : #accessing }
GShapeTestCase >> testBoundaryContains [
	^ self subclassResponsibility
]

{ #category : #accessing }
GShapeTestCase >> testEncompassingRectangle [
	^ self subclassResponsibility
]

{ #category : #accessing }
GShapeTestCase >> testFitInExtent [
	^ self subclassResponsibility
]
