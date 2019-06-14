Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F51C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295CA20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFNUHS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:07:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:15874 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNUHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:07:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 13:07:13 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2019 13:07:13 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 14 Jun 2019 13:07:12 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.187]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.210]) with mapi id 14.03.0439.000;
 Fri, 14 Jun 2019 14:07:09 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for FSGSBASE
Thread-Topic: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
Thread-Index: AQHVBb/wZjduerPLCE6RrgdTn3cIcqabVRAAgADdggA=
Date:   Fri, 14 Jun 2019 20:07:08 +0000
Message-ID: <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.157.111]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D8A8A00E791B2499DC6B3C7940E1749@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 13, 2019, at 23:54, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Wed, 8 May 2019, Chang S. Bae wrote:
> 
>> Subject: x86/fsgsbase/64: Add documentation for FSGSBASE
> 
> The proper prefix is Documentation/x86: 
> 
>> From: Andi Kleen <ak@linux.intel.com>
>> 
>> v2: Minor updates to documentation requested in review.
>> v3: Update for new gcc and various improvements.
>> v4: Address the typos pointed by Randy Dunlap
> 
> Please move the vX annoations below the --- marker so they are stripped out
> automatically and I don't have to do it manually. They are not part of the
> final changelog.
> 
>> Documentation/x86/fsgs.txt | 103 +++++++++++++++++++++++++++++++++++++++++++++
> 
> The x86 documentation got converted to RST recently. Also as this is a
> 64bit specific documentation it belongs into Documentation/x86/x86_64 and
> not into the generic x86 directory.
> 
>> +++ b/Documentation/x86/fsgs.txt
>> @@ -0,0 +1,103 @@
>> +
> 
> Documentation files require a SPDX license identifier as any other file.
> 
>> +Using FS and GS prefixes on 64-bit x86 linux
> 
> Moving this into the 64 bit specific folder spares all the 'oh this is
> 64bit only' notices all over the place. 
> 
>> +
>> +The x86 architecture supports segment prefixes per instruction to add an
> 
> per instruction? It's only for instructions which access memory, not for
> instructions which are purely register based.
> 
>> +offset to an address.  On 64-bit x86, these are mostly nops, except for FS
>> +and GS.
>> +
>> +This offers an efficient way to reference a global pointer.
> 
> That sentence does not make any sense. What has this to do with global
> pointers?
> 
>> +The compiler has to generate special code to use these base registers,
>> +or they can be accessed with inline assembler.
>> +
>> +	mov %gs:offset,%reg
>> +	mov %fs:offset,%reg
>> +
>> +On 64-bit code, FS is used to address the thread local segment (TLS), declared
> 
> TLS is Thread Local Storage not Segment.
> 
>> +using thread. The compiler then automatically generates the correct prefixes
> 
> What means: declared using thread? I assume you meant declared with the
> __thread storage class specifier. If so, why not using the proper technical
> terms?
> 
>> +and relocations to access these values.
>> +
>> +FS is normally managed by the runtime code or the threading library.
>> +Overwriting it can break a lot of things (including syscalls and gdb),
>> +but it can make sense to save/restore it for threading purposes.
>> +
>> +GS is freely available, but may need special (compiler or inline assembler)
>> +code to use.
>> +
>> +Traditionally 64-bit FS and GS could be set by the arch_prctl system call
> 
> I don't see a tradition here and 'could' is just wrong.
> 
>> +
>> +	arch_prctl(ARCH_SET_GS, value)
>> +	arch_prctl(ARCH_SET_FS, value)
>> +
>> +[There was also an older method using modify_ldt(), inherited from 32-bit,
>> +but this is not discussed here.]
> 
> So why is it even mentioned when it's not longer existing?
> 
>> +However, using a syscall is problematic for user space threading libraries
>> +that want to context switch in user space. The whole point of them
>> +is avoiding the overhead of a syscall.
> 
> User space threading libraries are one particular use case and not really
> interesting for documenting this functionality. Documentation is about the
> concepts and not about what a particular usecase prefers.
> 
>> It's also cleaner for compilers
>> +wanting to use the extra register to use instructions to write
>> +it, or read it directly to compute addresses and offsets.
> 
> I don't see the value of this either.
> 
>> +Newer Intel CPUs (Ivy Bridge and later) added new instructions to directly
>> +access these registers quickly from user context:
> 
> The CPUs added new instructions?
> 
>> +	RDFSBASE %reg	read the FS base	(or _readfsbase_u64)
>> +	RDGSBASE %reg	read the GS base	(or _readgsbase_u64)
>> +
>> +	WRFSBASE %reg	write the FS base	(or _writefsbase_u64)
>> +	WRGSBASE %reg	write the GS base	(or _writegsbase_u64)
>> +
>> +If you use the intrinsics, include <immintrin.h> and set the -mfsgsbase option.
>> +
>> +The instructions are supported by the CPU when the "fsgsbase" string is shown
>> +in /proc/cpuinfo (or directly retrieved through the CPUID instruction,
>> +7:0 (ebx), word 9, bit 0).
>> +
>> +The instructions are only available to 64-bit binaries.
>> +
>> +In addition the kernel needs to explicitly enable these instructions, as it
>> +may otherwise not correctly context switch the state. Newer Linux
>> +kernels enable this. When the kernel does not enable the instruction
>> +they will fault with a #UD exception.
> 
> .....
> 
> This is completely unstructured information hastily cobbled together.
> 
> As time is pressing for the 5.3 merge window, I reworked the documentation
> as below. Please review and comment ASAP so I can merge the whole lot.
> 
> Thanks,
> 
> 	tglx
> 
> 8<------------------
> From: Thomas Gleixner <tglx@linutronix.de>
> Subject: Documentation/x86/64: Add documentation for GS/FS addressing mode
> Date: Thu,  13 Jun 2019 22:04:24 +0300
> 
> 
> Originally-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> Documentation/x86/x86_64/fsgs.rst  |  200 +++++++++++++++++++++++++++++++++++++
> Documentation/x86/x86_64/index.rst |    1 
> 2 files changed, 201 insertions(+)
> create mode 100644 Documentation/x86/fsgs.txt
> 
> --- /dev/null
> +++ b/Documentation/x86/x86_64/fsgs.rst
> @@ -0,0 +1,200 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Using FS and GS segments in user space applications
> +===================================================
> +
> +The x86 architecture supports segmentation. Instructions which access
> +memory can use segment register based addressing mode. The following
> +notation is used to address a byte within a segment:
> +
> +  Segment-register:Byte-address
> +
> +The segment base address is added to the Byte-address to compute the
> +resulting virtual address which is accessed. This allows to access multiple
> +instances of data with the identical Byte-address, i.e. the same code. The
> +selection of a particular instance is purely based on the base-address in
> +the segment register.
> +
> +In 32-bit mode the CPU provides 6 segments, which also support segment
> +limits. The limits can be used to enforce address space protections.
> +
> +In 64-bit mode the CS/SS/DS/ES segments are ignored and the base address is
> +always 0 to provide a full 64bit address space. The FS and GS segments are
> +still functional in 64-bit mode.
> +
> +Common FS and GS usage
> +------------------------------
> +
> +The FS segment is commonly used to address Thread Local Storage (TLS). FS
> +is usually managed by runtime code or a threading library. Variables
> +declared with the '__thread' storage class specifier are instantiated per
> +thread and the compiler emits the FS: address prefix for accesses to these
> +variables. Each thread has its own FS base address so common code can be
> +used without complex address offset calculations to access the per thread
> +instances. Applications should not use FS for other purposes when they use
> +runtimes or threading libraries which manage the per thread FS.
> +
> +The GS segment has no common use and can be used freely by
> +applications. There is no storage class specifier similar to __thread which
> +would cause the compiler to use GS based addressing modes. Newer versions
> +of GCC and Clang support GS based addressing via address space identifiers.
> +
> +
> +Reading and writing the FS/GS base address
> +------------------------------------------
> +
> +There exist two mechanisms to read and write the FS/FS base address:
> +
> + - the arch_prctl() system call
> +
> + - the FSGSBASE instruction family
> +
> +Accessing FS/GS base with arch_prctl()
> +--------------------------------------
> +
> + The arch_prctl(2) based mechanism is available on all 64bit CPUs and all
> + kernel versions.
> +
> + Reading the base:
> +
> +   arch_prctl(ARCH_GET_FS, &fsbase);
> +   arch_prctl(ARCH_GET_GS, &gsbase);
> +
> + Writing the base:
> +
> +   arch_prctl(ARCH_SET_FS, fsbase);
> +   arch_prctl(ARCH_SET_GS, gsbase);
> +
> + The ARCH_SET_GS prctl may be disabled depending on kernel configuration
> + and security settings.
> +
> +Accessing FS/GS base with the FSGSBASE instructions
> +---------------------------------------------------
> +
> + With the Ivy Bridge CPU generation Intel introduced a new set of
> + instructions to access the FS and GS base registers directly from user
> + space. These instructions are also supported on AMD Family 17H CPUs. The
> + following instructions are available:
> +
> +  =============== ===========================
> +  RDFSBASE %reg   Read the FS base register
> +  RDGSBASE %reg   Read the GS base register
> +  WRFSBASE %reg   Write the FS base register
> +  WRGSBASE %reg   Write the GS base register
> +  =============== ===========================
> +
> + The instructions avoid the overhead of the arch_prctl() syscall and allow
> + more flexible usage of the FS/GS addressing modes in user space
> + applications. This does not prevent conflicts between threading libraries
> + and runtimes which utilize FS and applications which want to use it for
> + their own purpose.
> +
> +FSGSBASE instructions enablement
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> + The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
> + available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
> +
> + The availability of the instructions is not enabling them
> + automatically. The kernel has to enable them explicitely in CR4. The
> + reason for this is that older kernels make assumptions about the values in
> + the GS register and enforce them when GS base is set via
> + arch_prctl(). Allowing user space to write arbitrary values to GS base
> + would violate these assumptions and cause malfunction.
> +
> + On kernels which do not enable FSGSBASE the execution of the FSGSBASE
> + instructions will fault with a #UD exception.
> +
> + The kernel provides reliable information about the enabled state in the
> + ELF AUX vector. If the HWCAP2_FSGSBASE bit is set in the AUX vector, the
> + kernel has FSGSBASE instructions enabled and applications can use them.
> + The following code example shows how this detection works::
> +
> +   #include <sys/auxv.h>
> +   #include <elf.h>
> +
> +   /* Will be eventually in asm/hwcap.h */
> +   #ifndef HWCAP2_FSGSBASE
> +   #define HWCAP2_FSGSBASE        (1 << 1)
> +   #endif
> +
> +   ....
> +
> +   unsigned val = getauxval(AT_HWCAP2);
> +
> +   if (val & HWCAP2_FSGSBASE)
> +        printf("FSGSBASE enabled\n");
> +
> +FSGSBASE instructions compiler support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +GCC version 6 and newer provide instrinsics for the FSGSBASE
> +instructions. Clang supports them as well.
> +

Looks like GCC-4.6.4 and Clang 5 begin to support the intrinsics with -mfsgsbase,
according to their documentations:
	GCC - https://gcc.gnu.org/onlinedocs/gcc-4.6.4/gcc/X86-Built_002din-Functions.html#X86-Built_002din-Functions
	Clang - https://releases.llvm.org/5.0.0/tools/clang/docs/ClangCommandLineReference.html

> +  =================== ===========================
> +  _readfsbase_u64()   Read the FS base register
> +  _readfsbase_u64()   Read the GS base register
> +  _writefsbase_u64()  Write the FS base register
> +  _writegsbase_u64()  Write the GS base register
> +  =================== ===========================
> +
> +To utilize these instrinsics <immintrin.h> must be included in the source
> +code and the compiler option -mfsgsbase has to be added.
> +
> +Compiler support for FS/GS based addressing
> +-------------------------------------------
> +
> +GCC version 6 and newer provide support for FS/GS based addressing via
> +Named Address Spaces. GCC implements the following address space
> +identifiers for x86:
> +
> +  ========= ====================================
> +  __seg_fs  Variable is addressed relative to FS
> +  __seg_gs  Variable is addressed relative to GS
> +  ========= ====================================
> +
> +The preprocessor symbols __SEG_FS and __SEG_GS are defined when these
> +address spaces are supported. Code which implements fallback modes should
> +check whether these symbols are defined. Usage example::
> +
> +  #ifdef __SEG_GS
> +
> +  long data0 = 0;
> +  long data1 = 1;
> +
> +  long __seg_gs *ptr;
> +
> +  /* Check whether FSGSBASE is enabled by the kernel (HWCAP2_FSGSBASE) */
> +  ....
> +
> +  /* Set GS to point to data0 */
> +  _writegsbase_u64(&data0);
> +
> +  /* Access offset 0 of GS */
> +  ptr = 0;
> +  print("data0 = %ld\n", *ptr);
> +
> +  /* Set GS to point to data1 */
> +  _writegsbase_u64(&data1);
> +  /* ptr still addresses offset 0! */
> +  print("data1 = %ld\n", *ptr);
> +

s/print/printf/

Tested with GCC and Clang.

> +
> +Clang does not provide these address space identifiers, but it provides
> +an attribute based mechanism:
> +
> + ==================================== =====================================
> +  __attribute__((address_space(256))  Variable is addressed relative to GS
> +  __attribute__((address_space(257))  Variable is addressed relative to FS
> + ==================================== =====================================
> +
> +FS/GS based addressing with inline assembly
> +-------------------------------------------
> +
> +In case the compiler does not support address spaces, inline assembly can
> +be used for FS/GS based addressing mode::
> +
> +	mov %fs:offset, %reg
> +	mov %gs:offset, %reg
> +
> +	mov %reg, %fs:offset
> +	mov %reg, %gs:offset
> --- a/Documentation/x86/x86_64/index.rst
> +++ b/Documentation/x86/x86_64/index.rst
> @@ -14,3 +14,4 @@ x86_64 Support
>    fake-numa-for-cpusets
>    cpu-hotplug-spec
>    machinecheck
> +   fsgs
> 
> 
> 

