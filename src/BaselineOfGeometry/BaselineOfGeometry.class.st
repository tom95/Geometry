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
	spec
		for: #common
		do: [
			spec preLoadDoIt: #updateTonelIfNeeded.
			"Packages"
			spec
				package: 'Geometry';
				package: 'Geometry-Tests' with: [ spec requires: #('Geometry') ].
				
			"Groups"
			spec
				group: 'Core' with: 'Geometry';
				group: 'Tests' with: #('Geometry-Tests') ]
]

{ #category : #'pre/post load' }
BaselineOfGeometry >> updateTonelIfNeeded [
	"In P6 update Tonel because it does not manage all the methods of the project."

	SystemVersion current major < 7 ifFalse: [ ^ self ].

	#('BaselineOfTonel' 'MonticelloTonel-Core' 'MonticelloTonel-FileSystem' 'MonticelloTonel-Tests') do: [ :each | (each asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem ].

	Metacello new
		baseline: 'Tonel';
		repository: 'github://pharo-vcs/tonel:v1.0.12';
		load
]
