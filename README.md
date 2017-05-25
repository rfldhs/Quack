# Quack

`Quack` is an addition to [Alamofire](https://github.com/Alamofire/Alamofire) which makes HTTP(s) calls easier and syntax cleaner.

With `Quack` HTTP(s) calls look that beautiful and easy:

```swift
let github = GithubClient()

github.repositories(owner: "cpageler93") { repos in
    switch repos {
    case .Success(let repos):
        // do something with repos (which is kind of [GithubRepository])
    case .Failure(let error):
        // handle error
    }
}
```

## Usage

### Base Classes

- `QuackClient` methods to make via HTTP(s)
- `QuackModel` parsing JSON to models (DTOs)

### Code to define a Service

```swift
class GithubClient: QuackClient {
    init() {
       super.init(url: URL(string: "https://api.github.com")!)
    }

    // synchronous
    public func repositories(owner: String) -> QuackResult<[GithubRepository]> {
        return respondWithArray(path: "/users/\(owner)/repos",
                                model: GithubRepository.self)
    }

    // asynchronous
    public func repositories(owner: String, completion: @escaping (QuackResult<[GithubRepository]>) -> (Void)) {
        return respondWithArrayAsync(path: "/users/\(owner)/repos",
                                     model: GithubRepository.self,
                                     completion: completion)
    }
}

class GithubRepository: QuackModel {
    let name: String?
    let fullName: String?
    let owner: String?

    required init?(json: JSON) {
        self.name = json["name"].string
        self.fullName = json["full_name"].string
        self.owner = json["owner"]["login"].string
    }
}
```

#### Code to call a service

```swift
let github = GithubClient()

// synchronous
let repos = github.repositories(owner: "cpageler93")
switch repos {
case .Success(let repos):
    // do something with repos (which is kind of [GithubRepository])
case .Failure(let error):
    // handle error
}


// asynchronous
github.repositories(owner: "cpageler93") { repos in
    switch repos {
    case .Success(let repos):
        // do something with repos (which is kind of [GithubRepository])
    case .Failure(let error):
        // handle error
    }
}

```

## Need Help?

Please [submit an issue](https://github.com/cpageler93/quack/issues) on GitHub or contact me via Mail or Twitter.

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.