"
A MockBuilderTest is a test class for testing the behavior of MockBuilder
"
Class {
	#name : #MockFlexBuilderTest,
	#superclass : #TestCase,
	#category : #'MockFlex-Tests'
}

{ #category : #test }
MockFlexBuilderTest >> testCountArguments [

	| mockbuilder inputSelector expectedOutput |
	mockbuilder := MockFlexBuilder new.
	inputSelector := 'selector'.
	expectedOutput := 0.
	self
		assert: (mockbuilder countArguments: inputSelector)
		equals: expectedOutput.

	inputSelector := 'selector:with:'.
	expectedOutput := 2.
	self
		assert: (mockbuilder countArguments: inputSelector)
		equals: expectedOutput
]

{ #category : #test }
MockFlexBuilderTest >> testFormatSelectorWithArgs [

	"nominal case test"

	| mockbuilder inputSelector arguments expectedOutput |
	mockbuilder := MockFlexBuilder new.
	inputSelector := 'selector:with:'.
	arguments := { #arg_01. #arg_02 }.
	expectedOutput := 'selector: arg_01 with: arg_02 '.
	self
		assert:
		(mockbuilder formatSelector: inputSelector withArgs: arguments)
		equals: expectedOutput
]

{ #category : #test }
MockFlexBuilderTest >> testInstallMethodAt [

	"Nominal cases"

	| mockbuilder builtClass mockedInstance return expectedReturn capturedVar |
	"Preparation"
	mockbuilder := MockFlexBuilder new.
	mockbuilder installMethod: [ :a :b | a + b ] at: #sum:with:.
	builtClass := mockbuilder builtClass.

	capturedVar := 0.
	mockbuilder
		installMethod: [ 
			capturedVar := capturedVar + 1.
			capturedVar ]
		at: #counter.
	mockedInstance := builtClass new.


	"test method with arguments"
	return := mockedInstance sum: 1 with: 2.
	expectedReturn := 3.
	self assert: expectedReturn equals: return.

	"test method without arguments, with capture variable"
	self assert: mockedInstance counter equals: 1.
	self assert: mockedInstance counter equals: 2.
	self assert: mockedInstance counter equals: 3.

	self assert: capturedVar equals: 3
]

{ #category : #test }
MockFlexBuilderTest >> testNormalUsage [

	"Nominal cases"

	| mofo return expectedReturn capturedVar |
	"Preparation"
	mofo := MockFlexBuilder newMockedClass new. "The MockFlex object instance"
	"Adding a method to the mock"
	mofo class installMethod: [ :a :b | a + b ] at: #sum:with:.

	capturedVar := 0.
	mofo class
		installMethod: [ 
			capturedVar := capturedVar + 1.
			capturedVar ]
		at: #counter.


	"test method with arguments"
	return := mofo sum: 1 with: 2.
	expectedReturn := 3.
	self assert: expectedReturn equals: return.

	"test method without arguments, with capture variable"
	self assert: mofo counter equals: 1.
	self assert: mofo counter equals: 2.
	self assert: mofo counter equals: 3.

	self assert: capturedVar equals: 3
]
