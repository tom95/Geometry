Class {
	#name : #GNumberTest,
	#superclass : #GTestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
GNumberTest >> testIsBetween [
	self assert: (2 isBetween: 2.2 and: 5 with: 0.2).
	self assert: (1.8 isBetween: 1.8 and: 5 with: 0.2).
	self assert: (1.5 isBetween: 1.8 and: 5 with: 0.2).
	self deny: (1.5 isBetween: 1.8 and: 5 with: 0.1).
	self assert: (1.88 isBetween: 1.5 and: 5 with: 0.2)
]
