"
I am a project of Euclidean geometry.
"
Class {
	#name : #ManifestGeometry,
	#superclass : #PackageManifest,
	#category : #'Geometry-Manifest'
}

{ #category : #'code-critics' }
ManifestGeometry class >> ruleRBIfTrueReturnsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GSegment #= #false)) #'2018-12-12T22:32:30.12924+01:00') #(#(#RGMethodDefinition #(#GPoint #to:intersects:to: #false)) #'2018-12-12T23:31:47.80624+01:00') )
]
