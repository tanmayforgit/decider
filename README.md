# Nayati
Nayati is a Rails engine that helps in creating a clean and maintainable multi tenant Rails application. Creating multitenant application with Nayati allows you to have models that do just database talking and business logic gets handled by a layer I like to call 'Operation layer'. The sequence in which these operations get executed for a tenant is put in database.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nayati'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install nayati
```
First run the install generator
```bash
$ rails generator nayati:install
```

## How to use
Nayati is meant to help in handling functional changes across tenants in your application.
Lets say you have a attendance system. Your company installs devices which have fingerprint scanning functionality. Your clients vary from
scools, gym, private companies. Now lets say you have 5 'operations' that can happen
in this workflow viz marking_attendace, notify_parents, give_extra_marks_for_consistency, notify_sitting_position, late_marking, notify_missing_registration
notify_number_of_late_marks

After installing, first generate a workflow e.g. attendance_management in example above.

```bash
$ rails generate nayati:workflow attendance_management
```

This will create a service class AttendanceManagementNayatiService which you are supposed to call in controller.

Service classes do following tasks
1. Find which workflow is supposed to run based on information passed from controller.
2. Create context that will be passed to every operation.
3. Return result object. By convention, this will return instance Nayati::WorkflowResults::Base object. You can have your own result object. Just create a class in app/models/nayati/workflow_results/#{workflow_name}.rb and nayati will pass instance of this class to operation classes.

Next we will create our operation classes. RESPONSIBILITIES OF A SINGLE OPERATION CLASS SHOULD NOT CHANGE ACROSS TENANTS. Rather this is how I define operation class. It is that piece of functionality which does not change across tenant. to create an operation class belonging to a workflow run

```bash
$ rails generate nayati:operation attendance_management marking_attendance
```

Next we will configure a workflow for a tenant. Lets say we are going to identify this workflow by name 'tenant_1_attendance_marking'. This tenant is a school and needs only marking_attendance and late_marking piece of functionality and if marking_attendance fails, you are supposed to nottify to register first. Nayati comes with a method to configure a workflow in database.

workflow_hash corresponding to sequence mentioned in above paragraph would be
```ruby
workflow_sequence_hash = {
  name: 'marking_attendance',
  workflow_identifier: 'tenant_1_attendance_marking',
  initial_operation_name: 'marking_attendance',
  operations: [
    { name: 'marking_attendance', after_failure_operation_name: 'notify_missing_registration', after_success_operation_name: 'late_marking' },
    { name: 'notify_missing_registration'},
    { name: 'late_marking'}
  ]
}
```

You can put this workflow in database by calling
```ruby
Nayati::Workflow.create_or_update_from_workflow_json(workflow_sequence_hash)
```

Next we will have a look at operation class
nayati:operation will generate operation class in app/nayati_operations/{workflow_name}/ directory which will automatically be initialized with operation_context that you created in nayati service class and result object when you call the 'call' method on service class.

By default nayati will first call to_fail? method of a operation class. If this method returns true, nayati will call perform_failure and next operation will be after_failure operation configured in database. If this method returns false, nayati will call perform method and next operation will be after_success operation configured in database. Nayati will stop when there is no operation to run.

## Sample

You can find a sample multitenant application here.
## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
