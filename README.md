# ExAvatar

Generates Avatar Images based on two letters. 

## Usage

The easiest usage is to use [VS Code Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and open the folder within the container. Then you can open the application `iex -S mix` and run `ExAvatar.generate()`. If you have a custom set of letters or colors you can set them using a keyword list. 

## Examples

```
ExAvatar.generate()
ExAvatar.generate(letters: "ABC")
ExAvatar.generate(colors: ["red", "blue", "green"])
ExAvatar.generate(letters: "ABCD", colors: ["lightblue"])
```