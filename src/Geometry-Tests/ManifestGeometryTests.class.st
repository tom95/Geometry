"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGeometryTests,
	#superclass : #PackageManifest,
	#category : #'Geometry-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestGeometryTests class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'Geometry-Tests')) #'2018-12-18T15:06:35.385668+01:00') )
]
