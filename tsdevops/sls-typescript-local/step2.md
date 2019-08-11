# API invoke

Now we also want to test the API. Therefore we install
[serverless-offline](
  https://www.npmjs.com/package/serverless-offline)

`npm install serverless-offline -D`{{execute}}

You also need to adjust *serverless.yml* plugin part

```yaml
plugins:
  - serverless-offline
```

Also we need to set the API event in *serverless.yml*

```yaml
functions:
  hello:
    handler: build/src/handler.hello
    events:
      - http:
          path: hello
          method: get
          cors: true
```

Per default you can send your request to `http://localhost:3000/`
Please see the
[documentation](
  https://www.npmjs.com/package/serverless-offline)
for configuration details

You can start the container at host in **another terminal**
(will be opened automatically)

`npx sls offline`{{execute T2}}

Or you can start it with docker in detached mode

```bash
docker run -v="${PWD}:/app/" -p="3000:3000" -w="/app/" node:12.7-alpine npx sls offline
```

now you are able to query the API in the **first terminal**
(switch back will be automatically)

`curl -X GET http://localhost:3000/hello`{{execute T1}}

You can see that the event in the lambda is getting a lot of parameter.
