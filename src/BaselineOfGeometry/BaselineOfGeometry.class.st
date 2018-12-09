"
A baseline for Geometrypackage
"
Class {
	#name : #BaselineOfGeometry,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGeometry'
}

{ #category : #baseline }
BaselineOfGeometry >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ spec package: 'Geometry' ]
]
