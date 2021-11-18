Class {
	#name : #BaselineOfMockFlex,
	#superclass : #BaselineOf,
	#category : #BaselineOfMockFlex
}

{ #category : #baselines }
BaselineOfMockFlex >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec package: 'MockFlex'.
		spec package: 'MockFlex-Tests' with: [ spec requires: #('MockFlex') ]]
]
