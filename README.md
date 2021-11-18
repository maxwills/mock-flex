# mock-flex
A simple mocking framework

## Baseline

```Smalltalk
Metacello new
    baseline: 'MockFlex';
    repository: 'github://maxwills/mock-flex:main';
    load.
```

## Example
```Smalltalk
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
  ```
