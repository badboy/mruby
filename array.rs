#![no_std]
#![feature(lang_items)]

#![feature(libc)]
extern crate libc;

pub type Value = [u8; 16];

#[no_mangle]
pub unsafe extern fn array_copy(mut dst: *mut Value, src: *const Value, size: libc::c_int)
{
    let size = size as isize;
    for i in 0..size {
        *dst.offset(i) = *src.offset(i);
    }
}

use core::fmt;

#[lang = "eh_personality"]
#[no_mangle]
pub extern fn eh_personality() { }

#[lang = "panic_fmt"]
#[no_mangle]
pub extern fn rust_begin_panic(_: fmt::Arguments,
                               _: &'static str,
                               _: u32) -> ! {
    loop {}
}
