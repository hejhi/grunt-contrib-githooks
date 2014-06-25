var spawn = require('child_process').spawn;

var grunt_process = spawn(
  '{{escapeBackslashes command}}',
  [ {{#if task}}'{{escapeBackslashes task}}'{{/if}}  ].concat({{#if args}}'{{{escapeBackslashes args}}}'.split(' '){{/if}}),
  {
    cwd: '{{escapeBackslashes gruntfileDirectory}}'
  }
);

grunt_process.stdout.on('data', function (data) {
  console.log(data);
});

grunt_process.stderr.on('data', function (data) {
  console.error(data);
  {{#unless preventExit}}process.exit();{{/unless}}
});

grunt_process.on('error', function (err) {
  console.error(err);
  {{#unless preventExit}}process.exit();{{/unless}}
});

grunt_process.on('close', function(exitCode) {
  {{#unless preventExit}}process.exit(exitCode);{{/unless}}
});