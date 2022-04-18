# Frequently Bought Together Products for Salesforce

<!---[![Build](https://github.com/jongpie/NebulaLogger/actions/workflows/build.yml/badge.svg)](https://github.com/jongpie/NebulaLogger/actions/workflows/build.yml)
[![codecov](https://codecov.io/gh/jongpie/NebulaLogger/branch/main/graph/badge.svg?token=1DJPDRM3N4)](https://codecov.io/gh/jongpie/NebulaLogger)
--->

Designed for Salesforce admins, developers & architects. A robust logger for Apex, Lightning Components, Flow, Process Builder & Integrations.

## Unlocked Package - v4.7.0

[![Install Unlocked Package in a Sandbox](./images/btn-install-unlocked-package-sandbox.png)](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5Y0000015lXSQAY)
[![Install Unlocked Package in Production](./images/btn-install-unlocked-package-production.png)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5Y0000015lXSQAY)
[![View Documentation](./images/btn-view-documentation.png)](https://jongpie.github.io/NebulaLogger/)

## Managed Package - v4.7.0

[![Install Managed Package in a Sandbox](./images/btn-install-managed-package-sandbox.png)](https://test.salesforce.com/packaging/installPackage.apexp?mgd=true&p0=04t5Y0000015lXNQAY)
[![Install Managed Package in Production](./images/btn-install-managed-package-production.png)](https://login.salesforce.com/packaging/installPackage.apexp?mgd=true&p0=04t5Y0000015lXNQAY)
[![View Milestone](./images/btn-view-managed-package-milestone.png)](https://github.com/jongpie/NebulaLogger/milestone/6)

---

## Features

1. Easily add log entries via Apex, Lightning Components (lwc & aura), Flow & Process Builder to generate 1 consolidated, unified log
2. Manage & report on logging data using the `Log__c` and `LogEntry__c` objects
3. Leverage `LogEntryEvent__e` platform events for real-time monitoring & integrations
4. Enable logging and set the logging level for different users & profiles using `LoggerSettings__c` custom hierarchy setting
    - In addition to the required fields on this Custom Setting record, `LoggerSettings__c` ships with `SystemLogMessageFormat__c`, which uses Handlebars-esque syntax to refer to fields on the `LogEntryEvent__e` Platform Event. You can use curly braces to denote merge field logic, eg: `{OriginLocation__c}\n{Message__c}` - this will output the contents of `LogEntryEvent__e.OriginLocation__c`, a line break, and then the contents of `LogEntryEvent__e.Message__c`
5. Automatically mask sensitive data by configuring `LogEntryDataMaskRule__mdt` custom metadata rules
6. View related log entries on any Lighting SObject flexipage by adding the 'Related Log Entries' component in App Builder
7. Dynamically assign tags to `Log__c` and `LogEntry__c` records for tagging/labeling your logs
8. Plugin framework: easily build or install plugins that enhance the `Log__c` and `LogEntry__c` objects, using Apex or Flow (not currently available in the managed package)
9. Event-Driven Integrations with [Platform Events](https://developer.salesforce.com/docs/atlas.en-us.platform_events.meta/platform_events/platform_events_intro.htm), an event-driven messaging architecture. External integrations can subscribe to log events using the `LogEntryEvent__e` object - see more details at [the Platform Events Developer Guide site](https://developer.salesforce.com/docs/atlas.en-us.platform_events.meta/platform_events/platform_events_subscribe_cometd.htm)

Learn more about the design and history of the project on [Joys Of Apex blog post](https://www.joysofapex.com/advanced-logging-using-nebula-logger/)

---

## Installing

Nebula Logger is available as both an unlocked package and a managed package. The metadata is the same in both packages, but there are some differences in the available functionality & features. All examples in `README` are for the unlocked package (no namespace) - simply add the `Nebula` namespace to the examples if you are using the managed package.

<table>
    <thead>
        <tr>
            <th></th>
            <th>Unlocked Package (Recommended)</th>
            <th>Managed Package</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Namespace</td>
            <td>none</td>
            <td><code>Nebula</code></td>
        </tr>
        <tr>
            <td>Future Releases</td>
            <td>Faster release cycle: new patch versions are released (e.g., <code>v4.4.x</code>) for new enhancements & bugfixes that are merged to the <code>main</code> branch in GitHub</td>
            <td>Slower release cycle: new minor versions are only released (e.g., <code>v4.x</code>) once new enhancements & bugfixes have been tested and code is stabilized</td>
        </tr>
        <tr>
            <td>Public & Protected Apex Methods</td>
            <td>Any <code>public</code> and <code>protected</code> Apex methods are subject to change in the future - they can be used, but you may encounter deployment issues if future changes to <code>public</code> and <code>protected</code> methods are not backwards-compatible</td>
            <td>Only <code>global</code> methods are available in managed packages - any <code>global</code> Apex methods available in the managed package will be supported for the foreseeable future</td>
        </tr>
        <tr>
            <td>Apex Debug Statements</td>
            <td><code>System.debug()</code> is automatically called - the output can be configured with <code>LoggerSettings__c.SystemLogMessageFormat__c</code> to use any field on <code>LogEntryEvent__e</code></td>
            <td>Requires adding your own calls for <code>System.debug()</code> due to Salesforce limitations with managed packages</td>
        </tr>
        <tr>
            <td>Apex Stack Traces</td>
            <td>Automatically stored in <code>LogEntry__c.StackTrace__c</code> when calling methods like <code>Logger.debug('my message');</code></td>
            <td>Requires calling <code>parseStackTrace()</code> due to Salesforce limitations with managed packages. For example:<br><code>Logger.debug('my message').parseStackTrace(new DmlException().getStackTrace());</code></td>
        </tr>
        <tr>
            <td>Logger Plugin Framework</td>
            <td>Leverage Apex or Flow to build your own "plugins" for Logger - easily add your own automation to the any of the included objects: <code>LogEntryEvent__e</code>, <code>Log__c</code>, <code>LogEntry__c</code>, <code>LogEntryTag__c</code> and <code>LoggerTag__c</code>. The logger system will then automatically run your plugins for each trigger event (BEFORE_INSERT, BEFORE_UPDATE, AFTER_INSERT, AFTER_UPDATE, and so on).</td>
            <td>This functionality is not currently available in the managed package</td>
        </tr>
    </tbody>
</table>

---

## Getting Started

After deploying Nebula Logger to your org, there are a few additional configuration changes needed...

-   Assign permission set(s) to users
    -   `LoggerLogCreator` provides the minimum access needed for users to generate logs via Apex, Lightning Components, Flow or Process Builder
    -   `LoggerEndUser` provides access to generate logs, as well as read-only access to any log records shared with the user.
    -   `LoggerLogViewer` provides view-all access (read-only) to all log records. This does **not** provide access to generate logs.
    -   `LoggerAdmin` provides view-all and modify-all access to all log records.
-   Customize the default settings in `LoggerSettings__c`
    -   You can customize settings at the org, profile and user levels

---

### Logger for Apex: Quick Start

For Apex developers, the `Logger` class has several methods that can be used to add entries with different logging levels. Each logging level's method has several overloads to support multiple parameters.

```java
// This will generate a debug statement within developer console
System.debug('Debug statement using native Apex');

// This will create a new `Log__c` record with multiple related `LogEntry__c` records
Logger.error('Add log entry using Nebula Logger with logging level == ERROR');
Logger.warn('Add log entry using Nebula Logger with logging level == WARN');
Logger.info('Add log entry using Nebula Logger with logging level == INFO');
Logger.debug('Add log entry using Nebula Logger with logging level == DEBUG');
Logger.fine('Add log entry using Nebula Logger with logging level == FINE');
Logger.finer('Add log entry using Nebula Logger with logging level == FINER');
Logger.finest('Add log entry using Nebula Logger with logging level == FINEST');
Logger.saveLog();
```

This results in 1 `Log__c` record with several related `LogEntry__c` records.

![Apex Log Results](./images/apex-log.png)

---

### Logger for Lightning Components: Quick Start

For lightning component developers, the `logger` lwc provides very similar functionality that is offered in Apex. Simply embed the `logger` lwc in your component, and call the desired logging methods within your code.

```javascript
// For lwc, retrieve logger from your component's template
const logger = this.template.querySelector('c-logger');

logger.error('Hello, world!').addTag('some important tag');
logger.warn('Hello, world!');
logger.info('Hello, world!');
logger.debug('Hello, world!');
logger.fine('Hello, world!');
logger.finer('Hello, world!');
logger.finest('Hello, world!');
logger.saveLog();
```

```javascript
// For aura, retrieve logger from your component's markup
const logger = component.find('logger');

logger.error('Hello, world!').addTag('some important tag');
logger.warn('Hello, world!');
logger.info('Hello, world!');
logger.debug('Hello, world!');
logger.fine('Hello, world!');
logger.finer('Hello, world!');
logger.finest('Hello, world!');
logger.saveLog();
```

---

### Logger for Flow & Process Builder: Quick Start

Within Flow & Process Builder, you can select 1 of the several Logging actions

![Flow Logger Actions](./images/flow-logger-actions.png)

In this simple example, a Flow is configured after-insert and after-update to log a Case record (using the action 'Add Log Entry for an SObject Record')

![Flow Builder: Log Case](./images/flow-builder-log-case.png)

This results in a `Log__c` record with related `LogEntry__c` records.

![Flow Log Results](./images/flow-log.png)

---
