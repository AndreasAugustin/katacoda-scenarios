# Npm scripts

If you open **package.json** in the editor you see that some basic scripts are defined

`npm run compile`{{execute}}

In **tsconfig.json** the files to compile are defined in **src/** and **test/** folder.
Also the build artefacts directory is set there to **build/**.
Because you don't want to checkin the build artefacts into your *VCS* the *build/*
folder is excluded in the *.gitignore*

`npm run clean`{{execute}}

This cleans up the build artefacts.

`npm run check`{{execute}}

This runs the
[tslint](
    https://www.npmjs.com/package/tslint)
checks.

`npm run fix`{{execute}}

If you have some tslint error, then just run this command to automatically
fix some of the issues.

Just test it:

- delete the last line in *src/index.ts*
- run `npm run check`{{execute}} (there will be errors)
- run `npm run fix`{{execute}} (this will add the empty line again)
- run `npm run check`{{execute}} again (you see that there is no error anymore)

Just play around a bit and have some fun.
