Source code related to StackOverflow question [how to run all methods one by one in multiple class by setting priroty using testng](https://stackoverflow.com/questions/59639168)

### preparation

Review the script `run.sh` and amend the location of the Java JDK and Maven.

### executing the tests

Executing

```
./run-tests.sh
```

example output

```
[INFO] --- maven-surefire-plugin:2.22.0:test (default-test) @ playground.testng ---
[INFO] 
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running TestSuite
test1
test2
test3
test4
[INFO] Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.73 s - in TestSuite
```

### additional note

The code was taken as it was provided in the original question. 

---

### disclaimer

See the source as a PoC and not as production ready.
