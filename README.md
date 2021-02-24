# Testing Code Scanning and Secret Scanning
A repository to test GHAS features

## Existing Code Databases
### jQuery Ajax Issue
The purpose of this small project is to build a query for a customer in which default queries didn't alert on a particular XSS vulnerability. A source coming from an jQuery function was not recognized by the default queries, so no alerted paths were shown as a result. A custom configuration was built such that `isSource`, `isSink` and `isAdditionalTaintStep` predicates were used to identify the specific tainted flow. For testing purposes, a simple text field and button were created to mock a XSS attack.

#### How to run this test project:
 - Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
   - Or update if already installed: `brew update`
 - Install php: `brew install php`
- Clone and cd `the name of this repo`
- Run `php -S localhost:8000 (or whatever port)`
  - Run `kill -9 $(lsof -t -i:<your-fav-port>)` if desired port was previously allocated. 
- Test the simple HTML elements.

## Querying Code Databases
Ceate your own db via the codeql-cli. Here's a [resource](https://github.com/github/vscode-codeql-starter/) for further instructions.

Database creation example:
```
codeql database create \
--language=javascript \
--source-root /fantastic-bassoon/jquery-ajax-example-code \
/test/
```
test
test
