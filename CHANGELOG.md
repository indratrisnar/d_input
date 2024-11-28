## 0.5.1

- IconSpec
  - `backgroundColor` = Colors.transparent
  - `borderRadius`  
    if this property is used, `radius` will be ignored

## 0.5.0

DInputMix & DInputDropdown (now StateFullWidget)

- changes:
  - `boxBorder`
    ```dart
    const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 1,
      ),
    )
    ```
- new:
  - `focusedBoxRadius` : `boxRadius`
  - `focusedBoxBorder`
    ```dart
    const Border.fromBorderSide(
      BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    )
    ```
  - `focusedBoxColor` == `boxColor`

## 0.4.2

new property DInputMix:

- keyboardType
- keyboardAppearance

## 0.4.0

- new property `leftChildren` and `rightChildren` which return `List<Widget>` to add custom widget for your input. available for:
  - DInputMix
  - DInputDropdown:

## 0.3.4

- DInputMix:
  - fix implement obscure

## 0.3.3

- DInputDropdown:
  - new property `noBoxBorder`. default: false

## 0.3.2

- DInputMix:
  - new property `noBoxBorder`. default: false

## 0.3.1

- DInputMix:
  - new property `enabled`

## 0.3.0

- new widget: DInputDropdown
- DInputMix:
  - new property axis, cross box
- new example

## 0.2.2

- DInputMix
  - controller: nullable

## 0.2.1

- DInputMix
  - boxColor: Theme.of(context).colorScheme.surfaceContainer

## 0.2.0

- Add New Widget: DInputMix
- restructure lib

## 0.1.4

- remove typedef
- upgrade base sdk:
  - sdk: ^3.5.1
  - flutter: ">=3.24.1"

## 0.1.3

- add property `textAlign`

## 0.1.2

- add autofocus property

## 0.1.1

- add property custom style input text

## 0.1.0

- add property contentPadding

## 0.0.9

- add property radius for border

## 0.0.8

- add property fillColor

## 0.0.7

- add widget input password

## 0.0.6

- add properti onChange
- add properti onTap
- add properti spaceTitle & change default spaceTitle
- change color required to const Red

## 0.0.2

- add tutorial
- set default 1 line

## 0.0.1

first push for DInput
