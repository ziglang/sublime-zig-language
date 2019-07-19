// this is a syntactically meaningless collection of sample
// keywords and constructs to use in testing.

const var extern packed export pub noalias inline comptime nakedcc stdcallcc volatile align linksection threadlocal

 const as = 2;
union
struct
enum
error


"for"
break return continue asm defer errdefer unreachable

if else switch and or try catch orelse

async await suspend resume cancel

while for

null undefined

fn usingnamespace test

bool f16 f32 f64 f128 void noreturn type anyerror

promise

i2 u2 i3 u3 i4 u4 i5 u5 i6 u6 i7 u7 i8 u8 i16 u16 u29 i29 i32 u32 i64 u64 i128 u128 isize usize

.i368 .i686 .i23

c_short c_ushort c_int c_uint c_long c_ulong c_longlong c_ulonglong c_longdouble c_void

true false

a + b
a += b

a +% b
a +%= b

a - b
a -= b

a -% b
a -%= b

-a
-%a

a * b
a *= b

a *% b
a *%= b

a / b
a /= b

a % b
a %= b

a << b
a <<= b

a >> b
a >>= b

a & b
a &= b

a | b
a |= b

a ^ b
a ^= b

~a

a orelse b

a.?

a catch b
a catch |err| b

a and b
a or b

!a

a == b
a == null
a != b

a > b
a >= b

a < b
a <= b

a ++ b

a ** b

a.*

&a

a || b


123
123.123
123.123e123
123.123E123
1e3
0x123
0x123.123
0x123.123p123

0o123

0b1

123.i812
a.i111

slice[0..2]

/// TODO blah blah
// TODO blah blah

"adsfjioasdjfoiad"
c"adsfjioasdjfoiad"
\a
const \\ adsjfaf23n9

const v = fn(aas, 2342, 23) void;

fn foo(a:as) s {

}

fn foo() void;
extern fn bar() void;
extern fn foobar() void;



c\\ adsjfafsdjkl \x11 \u1245 \U123456
extern fn bar() void;
 c\\ adsjfafsdjkl \ \\ \ \xdeadbeef
extern fn foobar() void;
\\ adsjfafsdjkl

pub fn barfoo();

 \\ adsjfafsdjkl
}
"hello \x1 \n \t \\ \r 1m ' \\ \a \" \u{11}"
 extern fn foobarfoo() void;
 "\"hello\""
'a'
'ab'
'\''
'\a\naa'
'\a'
'\aaasas'
'\n'
fn(i13,Foo)Bar;
foo = bar;

@"overloaded" = 89;

@addWithOverflow
@alignCast
@alignOf
@ArgType
@atomicLoad
@atomicRmw
@bitCast
@bitOffsetOf
@boolToInt
@breakpoint
@bswap
@byteOffsetOf
@bytesToSlice
@cDefine
@cImport
@cInclude
@clz
@cmpxchgStrong
@cmpxchgWeak
@compileError
@compileLog
@ctz
@cUndef
@divExact
@divFloor
@divTrunc
@embedFile
@enumToInt
@errorName
@errorReturnTrace
@errorToInt
@errSetCast
@export
@fence
@field
@fieldParentPtr
@floatCast
@floatToInt
@frameAddress
@handle
@import
@inlineCall
@intCast
@intToEnum
@intToError
@intToFloat
@intToPtr
@IntType
@memberCount
@memberName
@memberType
@memcpy
@memset
@mod
@mulWithOverflow
@newStackCall
@noInlineCall
@OpaqueType
@panic
@popCount
@ptrCast
@ptrToInt
@rem
@returnAddress
@setAlignStack
@setCold
@setEvalBranchQuota
@setFloatMode
@setGlobalLinkage
@setRuntimeSafety
@shlExact
@shlWithOverflow
@shrExact
@sizeOf
@sliceToBytes
@sqrt
@subWithOverflow
@tagName
@TagType
@This()
@truncate
@typeId
@typeInfo
@typeName
@typeOf

pub extern "hellas" export fn @"eeeasla"(as: as) userdata;

pub extern "hellas" export fn hello(as: as) OO {

}

pub extern "ole32" stdcallcc fn CoTaskMemFree(pv: LPVOID,        asda: asdsad, sacz: @"zxc", )void;
pub stdcallcc fn CoUninitialize() void;

pub const Foo = extern struct {

};

const Err = error {

};
{
    : Bar,
}

const Bar = union {
    field: Bar,
    field: Bad = @This() {},
};

const Boof = union(enum) {

};


const Bad = enum(u8) {

};
var as: Bad = Bad {
    pub stdcallcc fn CoUninitialize() void;

};

blk: {
    break :blk void;
    var f = Bar {
        .val = 9
    }
}
