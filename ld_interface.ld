ENTRY(__ckb_bootloader_start)

SECTIONS {
    . = 0x80000;

    .dynsym : {
        KEEP(*(.dynsym))
    } : base
    .gnu.hash : {
        *(.gnu.hash)
    }
    .hash : {
        *(.hash)
    }
    .dynstr : {
        *(.dynstr)
    }
    .rela : {
        *(.rela)
        *(.rela.*)
    }

    .text : ALIGN(0x1000) {
        *(.text)
        *(.text.*)
    } : text

    .rodata : ALIGN(0x1000) {
        *(.rodata)
        *(.rodata.*)
    } : rodata

    .data.rel.ro : ALIGN(0x1000) {
        *(.data.rel.ro)
        *(.data.rel.ro.*)
    } : relro
    .dynamic : ALIGN(0x1000) {
        KEEP(*(.dynamic))
        LONG(0)
    } : data : dynamic

    .data : ALIGN(0x1000) {
        *(.data)
        *(.data.*)
    } : data
    
    .bss : {
        *(.bss)
        *(.bss.*)
    }

    .stack : {
        *(.stack)
    } : stack

}
