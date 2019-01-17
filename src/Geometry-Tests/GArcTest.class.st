"
A G1DElementTest is a test class for testing the behavior of G1DElement
"
Class {
	#name : #GArcTest,
	#superclass : #GTestCase,
	#instVars : [
		'arc'
	],
	#category : #'Geometry-Tests'
}

{ #category : #accessing }
GArcTest >> actualClass [
	^ GArc
]

{ #category : #test }
GArcTest >> testAngle [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc angle equals: 90 degrees
]

{ #category : #test }
GArcTest >> testCentralAngle [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc centralAngle equals: 90 degrees.
	self assert: arc centralAngle equals: arc angle.
]

{ #category : #test }
GArcTest >> testEndPoint [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc endPoint equals: 8 , 8
]

{ #category : #test }
GArcTest >> testIncludes [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: (arc includes: 8.8284271247462 , 6).
	self deny: (arc includes: 8 , 6).
	self deny: (arc includes: 4 , 4).
	self deny: (arc includes: 4 , 8).
	
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 3, 6.
	self assert: (arc includes: 8.8284271247462 , 6).
	self deny: (arc includes: 8 , 6).
	self deny: (arc includes: 4 , 4).
	self assert: (arc includes: 4 , 8).
]

{ #category : #test }
GArcTest >> testLength [
	arc := GArc center: 6 , 6 origin: 8 , 4 direction: 10 , 10.
	self assert: arc length =~ 4.442882938158366
]

{ #category : #test }
GArcTest >> testRadius [
	arc := GArc center: 6 , 6 origin: 10 , 6 direction: 10 , 10.
	self assert: arc radius equals: 4
]
