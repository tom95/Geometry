"
I am a circle. I have a center in (cx, cy) and radius. My equation is: 
(x-cx)^2  + (y-cy)^2 = radius^2 or 
a * (x^2) + a * (y^2) + d * x + e * y + f = 0 

"
Class {
	#name : #GCircle,
	#superclass : #GEllipse,
	#category : #'Geometry-Shapes'
}

{ #category : #'instance creation' }
GCircle class >> center: aPoint1 radius: aNumber [
	^ self center: aPoint1 vertex: aPoint1 x , (aPoint1 y + aNumber) coVertex: aPoint1 x + aNumber , aPoint1 y
]

{ #category : #comparing }
GCircle >> boundaryContains: aPoint [
	^ self radius =~ (self center distanceTo: aPoint)
]

{ #category : #accessing }
GCircle >> perimeter [
	^ 2π * self radius
]

{ #category : #printing }
GCircle >> printOn: aStream [
	aStream nextPutAll: ('x² + y² = {1}²' format: {self radius})
]

{ #category : #accessing }
GCircle >> radius [
	^ self semiMajorAxisLength
]

{ #category : #'public interface' }
GCircle >> upperPoint [
	^ center x , ( center y + self radius )
]
