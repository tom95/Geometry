Class {
	#name : #PharoPointTest,
	#superclass : #TestCase,
	#category : #'Geometry-Tests'
}

{ #category : #tests }
PharoPointTest >> testHasOnTheSameSideAs [
	self assert:(1@1 has: 3@2 onTheSameSideAs: 2@2)
		equals: true.
	self assert:(1@1 has: 1@1 onTheSameSideAs: 2@2)
		equals: true.
	self assert:(1@1 has: -1@2 onTheSameSideAs: 2@2)
		equals: false.
]

{ #category : #tests }
PharoPointTest >> testHasOnTheSameSideAs1 [

	self assert:(((17674/229)@(14582/229)) has: ((9244/147)@(1090/21)) 
				onTheSameSideAs: (76.82622578909061@64.97050543967634))
		equals: false.
		
	self assert:(((17674/229)@(14582/229)) has: ((-28206/397)@(50382/397)) 
				onTheSameSideAs: (76.82622578909061@64.97050543967634))
		equals: true
]
