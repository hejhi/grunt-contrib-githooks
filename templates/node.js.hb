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

grunt_process.stdout.setEncoding('utf8');
grunt_process.stdout.on('data', function (data) {
  console.log(data);
});

grunt_process.stderr.setEncoding('utf8');
grunt_process.stderr.on('data', function (data) {
  console.error('stderr:', data);
});

grunt_process.on('error', function (err) {
  console.error(err);
  process.exit();
});

grunt_process.on('close', function(exitCode) {
  process.exit(exitCode);
});