# Ruby DOM manipulation with Opal-Jquery

## Intro

 > Rick is using the list app

Today I've built a simple Todo app using Jquery. It's a very simple app, but what's interesting is that I was able to build it entirely in Ruby using the Opal compiler. I didn't write any javascript while building it and that's what Opal is about- running Ruby code on the front end. Let's learn how this can be done.

## Background

 > Rick is viewing Opal-JQ page

[Link](https://github.com/opal/opal-jquery)

The main dependency in this project aside from opal is opal jquery. It allows you to call JQuery functions from within your Ruby code.

## Background II

 > Rick is viewing Picnic CSS

[Link](http://www.picnicss.com/test/)

For styling of elements I will use PicnicCSS. I chose it for its simplicity. If you want to learn more, take a look at the documentation.

## Scaffold the Folders

 > Rick is at the terminal

I will start the project by making an app folder to put the Ruby files in

```
mkdir app
```

And also a gemfile, rakefile and index.html file.

```
touch Gemfile
touch Rakefile
touch index.html
```

## Add dependencies

 > Rick has Gemfile open

Then we add opal and opal-jquery to our Gemfile

```
source 'https://rubygems.org'

gem 'opal', '0.7.2'
gem 'opal-jquery', '0.3.0'
```

## Install

 > Rick is in the terminal

And run bundle install to fetch all dependencies

```
bundle install
```

## Rake file

Since Opal must be compiled from Ruby into Javascript, I will create a build command in Rake to automate the task.

That way, we can just type `rake build` to compile our application.

```
require 'opal'
require 'opal-jquery'

desc "Build our app to build.js"
task :build do
end
```

After requiring the gems and scaffolding a rake task, I'll call append_path to add our app folder to the load path.

```
  Opal.append_path "app"
```

then we can compile the Ruby file into a Javascript string.

```
  compiler_output = Opal::Builder.build("application").to_s
```

That string can be written to a javascript file

```
  File.binwrite "build.js", compiler_output
```

Running this rake task will create a file called build.js and we can include that file inside of HTML files.

## Base HTML

I will add some base HTML.

This is going to include things like JQuery, some CSS files, and also the compiled ruby output

 > Highlight CSS file and JQuery CDN

It also has the application HTML

 > Highlight the HTML inside <main>

```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/picnicss/4.0.1/picnic.min.css">
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/picnicss/4.0.1/plugins.min.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script src="build.js"></script>
    <style type="text/css">
      .center {
          margin-left: auto;
          margin-right: auto;
          width: 70%;
      }
    </style>
  </head>
  <body>
    <main id="app" class="center">
      <header>
        <div>
          <h1>Todos</h1>
          <form id="form" autocomplete="off">
            <input id="input" placeholder="Enter text..."/>
          </form>
        </div>
      </header>
      <hr/>
      <section id="list">
      </section>
    </main>
  </body>
</html>
```
## Writing the app

Now let's write our clientside Ruby code.

Code is loaded using standard ruby require statements, which we will need to load JQuery and the Opal runtime environment.

```
require 'opal'
require 'opal-jquery'
```

Just like with a traditional JQuery application, we will need to tie in to the DOM ready event so that the code does not execute before the page is finished loading.

```ruby
Document.ready? do
end
```

JQuery selectors can be accessed using the Document.find method. In our case, I'm going to make a selector that finds the list of TODO items, the input form and the text box within the input form. I will manipulate these selectors and add events later.
```ruby
  list = Document.find('#list')
  form = Document.find('#form')
  text_box = form.find('input')

```

Adding events to DOM elements is very similar to native JQuery. You just call the `(dot on)` method and pass in the event name. In our case, a form submission.

```
  form.on(:submit) do |event|
  end
```

## Writing the event handler

Within the form event handler, there are several things that need to happen. We must prevent the browser from performing the default form submission action, which would cause the page to refresh. We must also append an item to the todo list and lastly empty the input box so that the user can enter the next todo item.

Opal JQuery events have a method called 'prevent' which is the same thing as JQuery's prevent default function.

```
    event.prevent
```

We add an item to the todo list by creating a new object from class Element and filling it with a string template.

```
    item = Element.new('div.row')
    item.html = "<div class='card'><p>#{text_box.value}</p></div>"
```

I will attach an on click event that removes the element from the page and lastly I will append the DOM element to our todo list.

```
    item.on(:click) { item.remove }
    list.append(item)
```

Finally, I will clear out the form input.

```
    text_box.value = ''
```

## Demo

 > Rick has browser open to static file

Let's give the app one last look to make sure it worked.

 > Rick adds a few notes into the app and trys to delete a few.

Now the app is complete.

## Closing Notes about clearwaterrb / Vienna

 > Rick has two screens open showing vienna and clearwaterrb homepages

 [Vienna](https://github.com/opal/vienna) [Clearwater](https://github.com/clearwater-rb/clearwater)

The example we went over today was pretty simple, so JQuery was an acceptable option. If you are building larger scale applications, it may be worth looking into a more extensible front end framework such as Vienna or ClearwaterRB. If you would like to learn more about these frameworks, let us know in the comments section.

