Source code related to StackOverflow question [How Locale could be used in multithreaded application to improve performance](https://stackoverflow.com/questions/31987777)

The user [@Erdem Emekligil](https://stackoverflow.com/users/3310251/erdem-emekligil) discovered some performance decrease when using `string.toUppercase()` with a Turkish locale in a multi-threaded application.

```
private Locale locale = new Locale("tr", "TR");

public void calculate(String arg1){
    String uppercase = arg1.toUpperCase(locale);
	...
}
```
The reason for the discovered behaviour was posted by user [@sibnick](https://stackoverflow.com/users/159923/sibnick)

> After short exploring it looks like JDK can't help you. I suggest get `java.lang.ConditionalSpecialCasing` class, copy it and fix problem with Hashtable. You may replace `Hashtable` with `HashMap`. I do not see any reason for using `Hashtable` here.

The code in this project runs some [JHM](https://openjdk.java.net/projects/code-tools/jmh) benchmarks.

 - upperCaseEN - calls `toUpperCase()` with English locale
 - upperCaseTR - calls `toUpperCase()` with Turkish locale
 - upperCasePatchedTR - `toUpperCase()` in case the string contains a `i` it used the Turkish locale (the upper case `i` will be `İ`) otherwise it uses the English locale
 
There is also one additional test how the performance is changed when `java.lang.ConditionalSpecialCasing` would use a `HashMap` instead of `Hashtable` internally.

---

Find below the steps to run benchmarks.

### preparation

In the current directory a sub-directory `./jdk8` with a JDK 8 installation is assumed. (which might be a symlink to an existing installation)

### compile

Compile the benchmarks and the patched version of `java.lang.ConditionalSpecialCasing` which uses a `HashMap` instead of a `HashTable` with

```
./compile.sh
```

### patch JRE

For running the test `upperCaseTR` executed with a patched `java.lang.ConditionalSpecialCasing` execute

```
./patch-jre.sh
```

The script creates a copy of the JRE from `./jre8` to `./jre8.patched` and replaces class `java.lang.ConditionalSpecialCasing` in the `rt.jar`.

### running the benchmarks

Executing

```
./run-benchmarks.sh
```

will execute following benchmarks

**_for JRE 8_**

 - upperCaseEN
 - upperCaseTR
 - upperCasePatchedTR

example result (results will be different on your machine)

```
Benchmark                        Mode  Cnt     Score    Error   Units
MyBenchmark.upperCaseEN         thrpt   25  9510.240 ± 57.932  ops/ms
MyBenchmark.upperCasePatchedTR  thrpt   25  8671.593 ± 80.248  ops/ms
MyBenchmark.upperCaseTR         thrpt   25   982.747 ± 21.723  ops/ms
```

**_for JRE with patched java.lang.ConditionalSpecialCasing_**

 - upperCaseTR

example result (results will be different on your machine)

```
Benchmark                 Mode  Cnt     Score     Error   Units
MyBenchmark.upperCaseTR  thrpt   25  3563.289 ± 102.668  ops/ms
```

In the log it's also printed that the patched class was used

```
# Warmup Iteration   1: patched class java.lang.ConditionalSpecialCasing
```

### interesting

Running the benchmarks with JDK 13 increases the performance between about 45% and 60%.

```
Benchmark                        Mode  Cnt      Score     Error   Units
MyBenchmark.upperCaseEN         thrpt   25  15488.625 ± 535.825  ops/ms
MyBenchmark.upperCasePatchedTR  thrpt   25  12624.747 ± 531.672  ops/ms
MyBenchmark.upperCaseTR         thrpt   25   1464.932 ±  43.479  ops/ms
```

### what's not done

There was no kind of investigation if replacing the `Hashtable` in class `java.lang.ConditionalSpecialCasing` by a `HashMap` might have some unexpected side effects in a multi-threaded environment.

---

### disclaimer

See the source as a PoC and not as production ready.
