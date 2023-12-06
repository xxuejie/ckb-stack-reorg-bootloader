# ckb-stack-reorg-bootloader

This is a bootloader for [CKB-VM](https://github.com/nervosnetwork/ckb-vm) programs, which enables the following behavior:

* Stack is moved from 0 - 512KB region
* Code starts from 512KB upwards

Assuming a program then leverages heap memory starting at `_end` and upwards, there will be no chance of overlapping between stack and heap. This enables us to use as much heap memory as possible, while also keeping program safe.

To use this bootloader, include `bootloader.S` in our program, then also use `ld_interface.ld` as the linker script. An example making those changes to a CKB-VM program, can be found [here](https://github.com/xxuejie/ckb-zero-lock/commit/90bc2392e026204e385db2943a97fef289cd861b).

Note that the default provided file is configured to use a stack of 512KB. For certain programs, this might not be enough(e.g., [ckb-auth](https://github.com/nervosnetwork/ckb-auth) requires a big stack to hold secp256k1 precomputed tables). You can use the following commands to build bootloader with a bigger stack, for example, 2MB:

```
./regenerate 0x200000
```

After the command finishes, `bootloader.S` and `ld_interface.ld` will be updated accordingly, feel free to then copy those 2 files to your project to setup a bigger stack.

For now, this library is only tested against the following environment:

* `rust-lld` or `lld` from LLVM used as the final linker
* CKB-VM script version 1 or above is used
