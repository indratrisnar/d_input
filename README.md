D'Input is a package that provide input widget to build faster input with default border style

## Features

- Input concise
- Input Label
- Input Title
- Input Validator
- Input Area
- Input Password
- Some Style

## Screenshot
<img src="https://github.com/indratrisnar/d_input/raw/master/pic/d_input1.png" alt="d_input1" width="300">
<img src="https://github.com/indratrisnar/d_input/raw/master/pic/d_input2.png" alt="d_input2" width="300">

## Usage

Some Simple Input
```dart
DInput(controller: TextEditingController()),

DInput(
    controller: TextEditingController(),
    hint: 'Hint 3',
    label: 'Label 3',
),

DInput(
    controller: TextEditingController(),
    hint: 'Hint 5',
    isRequired: true,
    title: 'Title 5',
),

DInput(            
    controller: TextEditingController(),
    maxLine: 4,
    minLine: 1,
    hint: 'Area',
),

DInputPassword(            
    controller: TextEditingController(),
),

DInputPassword(            
    controller: TextEditingController(),
    obsecureCharacter: 'x',
),
```

## Tutorial :
[Watch](https://youtu.be/x457Q5tl_Lk)

## Support :
Support me for more feature & packages
[Donate](https://www.paypal.com/paypalme/indratrisnar)


## Additional information
Check my app : [Visit](https://indratrisnar.github.io/projects.html)

Check My Tutorial & Course : [Watch](https://www.youtube.com/channel/UC0d_xINEvCtlDCpWfBpnYpA)
