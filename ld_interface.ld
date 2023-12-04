PHDRS {
    dummy PT_LOAD FLAGS(5) ;
    text PT_LOAD FLAGS(5) ;
    rodata PT_LOAD FLAGS(4) ;
    data PT_LOAD FLAGS(6) ;

    relro PT_GNU_RELRO FLAGS(4) ;
    stack PT_GNU_STACK FLAGS(6) ;
}

ENTRY(__ckb_bootloader_start)

SECTIONS {
    . = 0x0;
    .ckb.vm.dummy : ALIGN(0x1000) {
        BYTE(0)
    } : dummy

    . = 0x80000;

    .dynsym : {
        *(.dynsym)
    }
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
    }
    .dynamic : ALIGN(0x1000) {
        *(.dynamic)
    }

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
    }

    _end = .; PROVIDE (end = .);
}
