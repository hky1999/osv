# Copyright (C) 2013 Cloudius Systems, Ltd.
#
# This work is open source software, licensed under the terms of the
# BSD license as described in the LICENSE file in the top-level directory.

#include <osv/drivers_config.h>
#include <xen/interface/elfnote.h>

#define elfnote(type, valtype, value) \
        .pushsection .note.xen, "a", @note; \
        .align 4; \
        .long 2f-1f; \
        .long 3f-2f; \
        .long type; \
1: \
        .asciz "Xen"; \
        .align 4; \
2: \
        valtype value; \
3: \
        .align 4; \
        .popsection

#define elfnote_val(type, value) elfnote(type, .quad, value)
#define elfnote_str(type, value) elfnote(type, .asciz, value)

#if CONF_drivers_xen
elfnote_val(XEN_ELFNOTE_ENTRY, xen_start)
elfnote_val(XEN_ELFNOTE_HYPERCALL_PAGE, hypercall_page)
elfnote_val(XEN_ELFNOTE_VIRT_BASE, OSV_KERNEL_VM_SHIFT)
elfnote_str(XEN_ELFNOTE_XEN_VERSION, "xen-3.0")
elfnote_str(XEN_ELFNOTE_GUEST_OS, "osv")
elfnote_str(XEN_ELFNOTE_GUEST_VERSION, "?.?")
elfnote_str(XEN_ELFNOTE_LOADER, "generic")
elfnote_str(XEN_ELFNOTE_FEATURES, "!writable_page_tables")
elfnote_str(XEN_ELFNOTE_BSD_SYMTAB, "yes")
#endif
elfnote_val(XEN_ELFNOTE_PHYS32_ENTRY, hvm_xen_start-OSV_KERNEL_VM_SHIFT)

.data

# This hints where pre-mapped free memory exists.
# We can then use it as the base for our stack pointer.
.global xen_bootstrap_end
.hidden xen_bootstrap_end
xen_bootstrap_end: .quad 0

.text
#if CONF_drivers_xen
.align 4096
.globl hypercall_page
.hidden hypercall_page
hypercall_page:
        1: jmp 1b
.align 4096

xen_start:
    mov %rsp, xen_bootstrap_end
    mov %rsi, %rdi
    call xen_init
    mov $0x0, %rdi
    jmp start64
#endif

.code32
hvm_xen_start:
    mov %ebx, hvm_xen_start_info-OSV_KERNEL_VM_SHIFT
    mov $0x7c00, %esp # Allocate some temporary stack -> TODO: Probably unnecessary
    mov $start32-OSV_KERNEL_VM_SHIFT, %eax
    jmp *%eax
