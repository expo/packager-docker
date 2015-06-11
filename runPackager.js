var child_process = require('child_process');

child_process.exec('npm install', {
  cwd: '/var/pkgur/app-src',
}, function (err, result) {
  child_process.spawn('./node_modules/react-native/packager/packager.sh', ['--root=/var/pkgur/app-src', '--assetRoots=/var/pkgur/app-src'], {
    cwd: '/var/exponent-packager',
    stdio: 'inherit',
  });
});

