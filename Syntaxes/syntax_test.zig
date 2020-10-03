// SYNTAX TEST "Packages/Zig Language/Syntaxes/Zig.sublime-syntax"
// this is a syntactically meaningless collection of sample
// keywords and constructs to use in testing.

const std = @import("std");
//^^^ storage.modifier.zig
//        ^ keyword.operator.assignment.zig
//          ^^^^^^^ keyword.control.import.zig
//                 ^ punctuation.section.parens.begin.zig
//                  ^^^^^ string.quoted.double.zig
//                       ^ punctuation.section.parens.end.zig
//                        ^ punctuation.terminator.zig

pub fn main() !void {
//^ storage.modifier.zig
//  ^^ storage.type.function.zig
//     ^^^^ entity.name.function
//         ^ punctuation.section.parens.begin.zig
//          ^ punctuation.section.parens.end.zig
//            ^ keyword.operator.zig
//             ^^^^ storage.type.zig
//                  ^ punctuation.section.braces.begin.zig
    // If this program is run without stdout attached, exit with an error.
//  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.line.zig
    const stdout_file = std.io.getStdOut();
//  ^^^^^ storage.modifier.zig
//                    ^ keyword.operator.assignment.zig
//                             ^^^^^^^^^ variable.function.zig
//                                      ^ punctuation.section.parens.begin.zig
//                                       ^ punctuation.section.parens.end.zig
//                                        ^ punctuation.terminator.zig
    try stdout_file.writeAll("Hello, world!\n");
//  ^^^ keyword.control.conditional.zig
//                  ^^^^^^^^ variable.function.zig
//                          ^ punctuation.section.parens.begin.zig
//                           ^^^^^^^^^^^^^^^^^ string.quoted.double.zig
//                                         ^^ constant.character.escape.newline.zig
//                                            ^ punctuation.section.parens.end.zig
}


const var extern packed export pub noalias inline comptime nakedcc stdcallcc volatile align linksection threadlocal

const as = 2;
// <- storage.modifier.zig
//         ^ constant.numeric.integer.zig
//          ^ punctuation.terminator.zig
union
struct
enum
error

asd {
    .asd = asd,
}

   fn dump(
// ^^ storage.type.function.zig
//    ^^^^ entity.name.function
//        ^ punctuation.section.parens.begin.zig
    value: var.asda.ad.asd,
//  ^^^^^ variable.parameter.zig
//       ^ punctuation.separator.zig
//         ^^^^^^^^^^^^^^^ storage.type.zig
    // NYI some arg
    asdasd: Baddad
) void {
// <- punctuation.section.parens.end.zig
// ^^^ storage.type.zig
//     ^ punctuation.section.braces.begin.zig
}
// <- punctuation.section.braces.end.zig

   "for"
// ^^^^^ string.quoted.double.zig

break return continue asm defer errdefer unreachable

if else switch and or try catch orelse

async await suspend resume cancel noasync

while for

null undefined

fn usingnamespace test

bool f16 f32 f64 f128 void noreturn type anyerror anytype

promise anyframe
i2 u2 i3 u3 i4 u4 i5 u5 i6 u6 i7 u7 i8 u8 i16 u16 u29 i29 i32 u32 i64 u64 i128 u128 isize usize

.i368 .i686 .i23

c_short c_ushort c_int c_uint c_long c_ulong c_longlong c_ulonglong c_longdouble c_void

true false

a + b
//^ keyword.operator.arithmetic.zig
a += b
//^^ keyword.operator.assignment.zig

a +% b
//^^ keyword.operator.arithmetic.zig
a +%= b
//^^^ keyword.operator.assignment.zig

a - b
//^ keyword.operator.arithmetic.zig
a -= b
//^^ keyword.operator.assignment.zig

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
//^^ keyword.operator.logical.zig
a <<= b
//^^^ keyword.operator.logical.zig

a & b
a &= b
//^^ keyword.operator.assignment.zig

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

test "numbers" {
    123
//  ^^^ constant.numeric.integer.zig
    123.123
//  ^^^^^^^ constant.numeric.float.zig
    123.123e123
//  ^^^^^^^^^^^ constant.numeric.float.zig
    123.123E123
//  ^^^^^^^^^^^ constant.numeric.float.zig
    1e3
//  ^^^ constant.numeric.float.zig
    0x123
//  ^^^^^ constant.numeric.integer.hexadecimal.zig
    0x123.123
//  ^^^^^^^^^ constant.numeric.float.hexadecimal.zig
    0x123.123p123
//  ^^^^^^^^^^^^^ constant.numeric.float.hexadecimal.zig

    0o123
//  ^^^^^ constant.numeric.integer.octal.zig
    0b1
//  ^^^ constant.numeric.integer.binary.zig
    1_234_567;
//  ^^^^^^^^^ constant.numeric.integer.zig
    0xff00_00ff;
//  ^^^^^^^^^^^ constant.numeric.integer.hexadecimal.zig
    0b10000000_10101010;
    0b1000_0000_1010_1010;
    0x123_190.109_038_018p102;
//  ^^^^^^^^^^^^^^^^^^^^^^^^^ constant.numeric.float.hexadecimal.zig
    3.14159_26535_89793;
//  ^^^^^^^^^^^^^^^^^^^ constant.numeric.float.zig

    123.i812;
//  ^^^^^^^^ -constant.numeric
    a.111;

    var x: i123 = 0x7A;
//         ^^^^ storage.type.zig
    var x: usize = 0x7A;
//         ^^^^^ storage.type.zig

}

slice[0..2]
//     ^^ keyword.operator.other.zig

/// TODO blah blah
//  ^^^^^^^^^^^^^^^ comment.line.documentation.zig
// TODO blah blah
// ^^^^^^^^^^^^^^^ comment.line.todo.zig

"adsfjioasdjfoiad"
c"adsfjioasdjfoiad"
// <- string.quoted.double.zig
// ^^^^^^^^^^^^^^^^ string.quoted.double.zig
   '\a'
// ^^^^ string.quoted.single.zig
//  ^^ string.quoted.single.zig invalid.illegal.character.zig
const \\ adsjfaf23n9
// <- storage.modifier.zig
//    ^^^^^^^^^^^^^^^ string.quoted.other.zig
"ad//sd"
// ^^^^^ string.quoted.double.zig -comment

const v = fn(aas, 2342, 23) as;

fn foo(a:as) i32 {
// <- storage.type.function.zig
// ^^^ entity.name.function
//    ^ punctuation.section.parens.begin.zig
//     ^ variable.parameter.zig
//      ^ punctuation.separator.zig
//       ^^ storage.type.zig
//         ^ punctuation.section.parens.end.zig
//           ^^^ storage.type.zig
//               ^ punctuation.section.braces.begin.zig
}
// <- punctuation.section.braces.end.zig

fn foo() A![]Foo {
//       ^ storage.type.zig
//        ^ keyword.operator.zig
//           ^^^ storage.type.zig
}

extern fn bar() as as void;
extern fn foobar() void;

errdefer |err| std.debug.assert(err == error.Overflow);
// <- keyword.control.zig
//       ^ keyword.operator.bitwise.zig
//           ^ keyword.operator.bitwise.zig
//                             ^ punctuation.section.parens.begin.zig
//                                  ^^ keyword.operator.logical.zig
//                                     ^^^^^ storage.type.error.zig
//                                          ^ punctuation.accessor.zig
//                                           ^^^^^^^^ entity.name.error.zig
//                                                   ^ punctuation.section.parens.end.zig
//                                                    ^ punctuation.terminator.zig

test "strings" {
    c\\ adsjfafsdjkl \x11 \u1245 \U123456
    extern fn bar() void;
     c\\ adsjfafsdjkl \ \\ \ \xdeadbeef
    extern fn foobar() void;
    \\ adsjfafsdjkl

    pub fn barfoo();
    fn
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
//   ^^ string.quoted.single.zig constant.character.escape.newline.zig
    '💩';
}
   fn(i13i,Foo) Bar;
// ^^ storage.type.function.zig
//   ^ punctuation.section.parens.begin.zig
//    ^^^^ meta.function.parameters.zig storage.type.zig
//        ^ meta.function.parameters.zig punctuation.separator.zig
//         ^^^ meta.function.parameters.zig storage.type.zig
//            ^ meta.function.parameters.zig punctuation.section.parens.end.zig
//              ^^^ storage.type.zig

foo = bar;

    @"overloaded" = 89;
//   ^^^^^^^^^^^^ string.quoted.double.zig
//                ^ keyword.operator.assignment.zig

@cImport
// <- keyword.control.import.zig
@cInclude
@import
@exampleBuiltin
// <- support.function.zig

   typo@cImport
//     ^^^^^^^^ keyword.control.import.zig

*const asasd
// <- keyword.operator.arithmetic.zig
//^^^^ storage.modifier.zig
*const [N:0]u8
?[]T and *[N]T
.{
    .x = 13,
    .y = 67,
}
var i: Number = .{.int = 42};

pub extern "hellas" export fn @"eeeasla"(as: FN) userdata;

pub extern "hellas" export fn hello(as: as) AA!OO {
anyframe->U
}

pub extern "ole32" stdcallcc fn CoTaskMemFree(pv: *const LPVOID, asda: asdsad, sacz: @"zxc", asd: asd) oop!asd;

pub stdcallcc fn CoUninitialize() A![];
ident
pub const Foo = extern struct {
	fn_call()
};

asda: extern struct {

};

const Err = error {

};
{
    : Bar,
}
(asdasd)
const Bar = struct {
    field: Foo = 234"asas",
    comptime field: Bad = Fasd {},
    field: var 
};

const Boof = union(enum) {

};


const Bad = enum(u8) {
    Dummy,
    _
};
var as: Bad = Bad(u8) {
    pub stdcallcc fn CoUninitialize() void;

};

blk: {
// <- entity.name.label.zig
    break :blk val1;
//  ^^^^^ keyword.control.zig
//         ^^^ entity.name.label.zig
//                 ^ punctuation.terminator.zig
    var f = Bar {
//  ^^^ storage.modifier.zig
//        ^ keyword.operator.assignment.zig
//          ^^^ storage.type.zig
//              ^ punctuation.section.braces.begin.zig
        .val = 9
    }

}

extern fn f2(s: *const *volatile u8) Error!GenericType(s) {

}

var asd: *const asd!asdads = 0;
var ba = 0;


blk: while () : (sas) {
error.asdasd;
}


const asas: u8asd;
addsaad

const alignment = blk: {
    const a = comptime meta.alignment(P);
    const b: a = fn() A!A;
    a = 23;
    if (a > 0) break :blk a;
    break :blk 1;
};
    std.debug.warn(run_qemu.getEnvMap() .get("PATH"));

///Given a pointer to a single item, returns a slice of the underlying bytes, preserving constness.
pub fn asBytes(ptr: var) asdsa!AsBytesReturnType(@typeOf(ptr)) {
    const P = @typeOf(ptr);
    return @ptrCast(AsBytesReturnType(P), ptr);
}
pub const LARGE_INTEGER = extern struct {
// <- storage.modifier.zig
//  ^^^^^ storage.modifier.zig
//        ^^^^^^^^^^^^^ entity.name.struct.zig
//                      ^ keyword.operator.assignment.zig
//                        ^^^^^^ storage.modifier.zig
//                               ^^^^^^ storage.type.struct.zig
//                                      ^ punctuation.section.braces.begin.zig
    _u2: extern struct {
//  ^^^ variable.other.member.zig
//     ^ punctuation.separator.zig
//       ^^^^^^ storage.modifier.zig
//              ^^^^^^ storage.type.struct.zig
//                     ^ punctuation.section.braces.begin.zig
        LowPart: fn(a, b, c)d,
//      ^^^^^^^ variable.other.member.zig
//             ^ punctuation.separator.zig
//               ^^ storage.type.function.zig
//                 ^ punctuation.section.parens.begin.zig
//                  ^ meta.function.parameters.zig storage.type.zig
//                   ^ meta.function.parameters.zig punctuation.separator.zig
//                     ^ meta.function.parameters.zig storage.type.zig
//                      ^ meta.function.parameters.zig punctuation.separator.zig
//                        ^ meta.function.parameters.zig storage.type.zig
//                         ^ meta.function.parameters.zig punctuation.section.parens.end.zig
//                          ^ storage.type.zig
//                           ^ punctuation.separator.zig
        HighPart: LONG,
//      ^^^^^^^^ variable.other.member.zig
//              ^ punctuation.separator.zig
//                ^^^^ storage.type.zig
//                    ^ punctuation.separator.zig
    },
//  ^ punctuation.section.braces.end.zig
//   ^ punctuation.separator.zig
    QuadPart: LONGLONG,
//  ^^^^^^^^ variable.other.member.zig
//          ^ punctuation.separator.zig
//            ^^^^^^^^ storage.type.zig
};

pub const GUID = extern struct {
//  ^^^^^ storage.modifier.zig
//        ^^^^ entity.name.struct.zig
//             ^ keyword.operator.assignment.zig
//               ^^^^^^ storage.modifier.zig
//                      ^^^^^^ storage.type.struct.zig
//                             ^ punctuation.section.braces.begin.zig
    Data1: c_ulong,
//  ^^^^^ variable.other.member.zig
//       ^ punctuation.separator.zig
//         ^^^^^^^ storage.type.zig
//                ^ punctuation.separator.zig
    Data2: c_ushort,
    Data3: c_ushort,
    Data4: [8]u8,
//  ^^^^^ variable.other.member.zig
//       ^ punctuation.separator.zig
//              ^ punctuation.separator.zig
};

pub async fn function() Error!ReturnType {
//  ^^^^^ keyword.control.async.zig
//        ^^ storage.type.function.zig
//           ^^^^^^^^ entity.name.function
}

pub async fn function(arg: Int, arg: I) !ReturnType {
    
}

test "enum literals" {
    const color1: Color = .Auto;
//  ^^^^^ storage.modifier.zig
//        ^^^^^^ variable.other.member.zig
//              ^ punctuation.separator.zig
//                ^^^^^ storage.type.zig
//                      ^ keyword.operator.assignment.zig
//                        ^^^^^ constant.language.enum
    const color2 = Color.Auto;
//                       ^^^^ -constant.language.enum
    const color2 = .{x}.Auto;
//                      ^^^^ -constant.language.enum
    assert(color1 == color2);

    const color = Color.On;
    const result = switch (color) {
        .Auto => false,
//      ^^^^^ constant.language.enum
//            ^ keyword.operator.assignment.zig
//             ^ keyword.operator.logical.zig
//               ^^^^^ constant.language.zig
        .On => true,
//      ^^^ constant.language.enum
        .Off => false,
//      ^^^^ constant.language.enum
    };
    assert(result);
}


test "fully anonymous list literal" {
    const args = .{ @as(u32, 1234), @as(f64, 12.34)});
    assert(args.@"0" == 1234);
//               ^^^ string.quoted.double.zig
    assert(args.@"1" == 12.34);
//               ^^^ string.quoted.double.zig
}
