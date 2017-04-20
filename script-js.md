Opa
Functional programming
Pro: Run client, server, and database code in the same language
Con: Currently the least popular of these languages

Dart
Similar to Java/JavaScript
Pro: Can run client and server code in the same language (though in practice, this is not yet the best option)
Pro: In the future you will be able to run client code in the Dart VM in some browsers
Pro: Polymer MDV provides easy approach to encapsulation and re-use of components

Haxe
Similar to ActionScript
Pro: Mult-platform language: compile to other language/platforms besides for JavaScript (for instance, creating high-performance mobile games)

CoffeeScript
Similar to Ruby
Pro: Currently the most popular of these languages
Some features common to all the languages:

Compile to JavaScript
Interact with JavaScript code
I researched all of these for a project that never ended up happening. I never really got into CoffeeScript since it was less familiar to me given its Ruby flavor. Opa was very intriguing but I ultimately decided against it since it seemed to have a very small community, and I preferred something more class-based and object-oriented. I was familiar with Haxe already, having played around with it for a mobile game, but JavaScript didn't seem like a huge focus here: tutorials and samples were hard to come by.

With Dart, everything suddenly seemed to come together:

Given my Java/ActionScript/JavaScript background I knew the language before even writing a line of code
The WebUI (now Polymer) Model-Driven-View approach, provided a sane way to encapsulate and re-use components
A dedicated IDE (Dart Editor) that made debugging quick and easy
Pub package manager made it easy to quickly add 3rd-part libraries
Plenty of tutorials, articles, and documentation to help get me up to speed
Ultimately, you can build great web apps in any of these languages, but the one you choose will be influenced by your past experience. In my case, I was looking for a class-based, object-oriented solution, which made it between Haxe and Dart, and Dart was clearly the victor in terms of features, tooling, and support.




Every one of the mentioned languages have their advantages and disadvantages. All of them can be compiled/transpiled to JavaScript and therefore can be used in conjunction with Node.js

CoffeeScript:
Small, clear language with lots of code examples.
Effective once you've learned the basics.
Nice tools provided.
Compiled JavaScript runs on server (node.js).

Dart:
Google is driving it. This is both an advantage (big company which can develop quite good stuff) and a disadvantage (I don't see other companies / browser manufacturers support Dart in the near future, so the advantage of JavaScript - platform independency - is lost if you don't compile down to JavaScript).
Has an own virtual machine.
In this virtual machine it's faster than JavaScript (but as mentioned in item 1 this advantage is lost the moment you need platform independency).
Runs on the server.

TypeScript:
Microsoft is the developer of TypeScript.
Every piece of JavaScript code is valid TypeScript and therefore it integrates much better than the other two languages.
Aligns with future JavaScript standards.
Compiled JavaScript runs on server (node.js).
Similarities (syntax) to C#, if you're coming from that direction.

Personally, I prefer TypeScript because it integrates well with existing JS code and it's easy to understand if you already know a bit of JavaScript and C#. Another point why I chose TypeScript is that some day today's TypeScript will be standard JavaScript and therefore run in the browser. I see TypeScript as a language/tool that allows you to develop today's web applications with language features of tomorrow (or maybe the next year). Microsoft showed big interest in web technologies recently and is driving their tools in that department forward rather quickly. Actually you can develop Windows Store applications with TypeScript and so it's the only language of the three mentioned in your question that has some of an impact on modern (native) desktops. 

I think one should try all three of them and see which meets the needs and does the best job and provides the features needed.

ClojureScript
ClojureScript is a compiler for Clojure that targets JavaScript. It is designed to emit JavaScript code which is compatible with the advanced compilation mode of the Google Closure optimizing compiler.
