### Python formatter: align your equals signs!


Input:
```python
a = "foo"
bar = "baz"

cart = "horse"
def foobar(
    xx=12,
    y=9,   
):
    return (xx == y)
```

Output:
```python
a   = "foo"
bar = "baz"

cart = "horse"
def foobar(
    xx = 12,
    y  = 9,   
):
    return (xx == y)
```


Kind of like how `gofmt` does for Golang code.



# Run commands:
haskell - too hard!
C TBD
APL ? 
```bash
python python.py
go run main.go
node typescript.js
ruby   ruby.rb
```