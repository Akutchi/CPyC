# CPyC

This is a simple C to Python converter.

The goals of this project are numerous.
First, this project more or less came from my desire to learn more about Ada.
As such, there might be more efficient ways to do things; but - at this point in
time - I am not aware of them.
Second, the scope of the project will only be - at most - to manage parsing
functions. That is to say, I will try to translate the following elements :
- Variables Structures
- Control Flow
- Loops (for and while only)
- Functions

I will repeat it just in case, _I do not have the desire to create a full parser,
nor do I absolutely want my solution to be exhaustive or efficient_. First off,
I don't really have the time for that. Second, while I try to do things correctly
by creating a little bit of structure (see UML diagram below), I am well aware
that this is something that I code as I think about it mostly. That is to say,
it is more or less on the fly than anything (well, I do have some notions about
parsing; but hey.)



# Changelog

## 18/02/23 :

with T&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: int; \
with Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [0-9]+ \
with Variable&nbsp;: [\w\d]+

with E : (T) Variable (= Value);

The Program can now generate variable structure of the form of E

generation table :

| C           | Python |
|-------------|--------|
| int i = 23; | i = 23 |
| int j;      | j = 0  |

## 20/02/23 :

with T&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: int; \
with Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [0-9]+ \
with Variable&nbsp;: [\w\d]+ \
with Op&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: [+-*/]

with S : Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Variable | \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;S Op S

with E1 : (\<T\>) Variable (= S);

The Program can now generate variable structure of the form E1

e.g :
| ![C code](./doc/C_Variables.png) |
|:--:|
| *C code* |

| ![Python code](./doc/Python_Gen.png) |
|:--:|
| *Python code Generation* |

### Note :
I am well aware that variable name and values are enclosed in parenthesis as of
right now and I am currently hesitating as to what to do about it. Do I leave it
for the post-processing or do I want to tackle it during the printing process.
Part of me is slightly curving towards post-proc' as it is "another" task that
the printer should not worry about.

# Structure

![Structure of the code](./doc/Structure.png)
