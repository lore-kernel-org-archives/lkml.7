Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B497C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75320665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mGIIUMfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFVKPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:15:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFVKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:15:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAFXb72098464
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:15:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAFXb72098464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198534;
        bh=YUVIuieJLfq91BpVgWhLOX1SNP1ACFEg55fZtnmD+K8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=mGIIUMfk9eatvh5ifX3cpc3CwEMiRUT3g6Ds4e51cQfPpZx5mzYjLHAoJZ0s8excz
         2BJyYW1Tw0GDJLATTi26GIeRdRjcssIXCUoPrwSFfRfPlAqa0AduyGClnZh9/onXIT
         fPQO397psz0WrNH2Efcgq5xr1ZK0xLuBqj0hXmL1Kt9s0/I7D+1k3XNjBw2+ptT7AI
         8CeDbq1Xc2snwH0r9Ll1SKT25ALhDHi9Gv64uRzOYLjl/Hux1mUJwcYRZBsEX3NyX3
         QszjOCCVYoIV7VbP4YS73aSv77/jRfK9LGnfCU8Iyw9hKCyI89lha/fpxQFJrSOkJ5
         z8oTwlH0JUNXA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAFWJ12098461;
        Sat, 22 Jun 2019 03:15:32 -0700
Date:   Sat, 22 Jun 2019 03:15:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2c7b5ac5d5a93c4b0557293d06c6677f765081a6@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, corbet@lwn.net,
        rdunlap@infradead.org, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        tglx@linutronix.de, ravi.v.shankar@intel.com
Reply-To: ravi.v.shankar@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          mingo@kernel.org, rdunlap@infradead.org, hpa@zytor.com,
          corbet@lwn.net, chang.seok.bae@intel.com
In-Reply-To: <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] Documentation/x86/64: Add documentation for GS/FS
 addressing mode
Git-Commit-ID: 2c7b5ac5d5a93c4b0557293d06c6677f765081a6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2c7b5ac5d5a93c4b0557293d06c6677f765081a6
Gitweb:     https://git.kernel.org/tip/2c7b5ac5d5a93c4b0557293d06c6677f765081a6
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 13 Jun 2019 22:04:24 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:57 +0200

Documentation/x86/64: Add documentation for GS/FS addressing mode

Explain how the GS/FS based addressing can be utilized in user space
applications along with the differences between the generic prctl() based
GS/FS base control and the FSGSBASE version available on newer CPUs.

Originally-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de
---
 Documentation/x86/x86_64/fsgs.rst  | 199 +++++++++++++++++++++++++++++++++++++
 Documentation/x86/x86_64/index.rst |   1 +
 2 files changed, 200 insertions(+)

diff --git a/Documentation/x86/x86_64/fsgs.rst b/Documentation/x86/x86_64/fsgs.rst
new file mode 100644
index 000000000000..380c0b5ccca2
--- /dev/null
+++ b/Documentation/x86/x86_64/fsgs.rst
@@ -0,0 +1,199 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Using FS and GS segments in user space applications
+===================================================
+
+The x86 architecture supports segmentation. Instructions which access
+memory can use segment register based addressing mode. The following
+notation is used to address a byte within a segment:
+
+  Segment-register:Byte-address
+
+The segment base address is added to the Byte-address to compute the
+resulting virtual address which is accessed. This allows to access multiple
+instances of data with the identical Byte-address, i.e. the same code. The
+selection of a particular instance is purely based on the base-address in
+the segment register.
+
+In 32-bit mode the CPU provides 6 segments, which also support segment
+limits. The limits can be used to enforce address space protections.
+
+In 64-bit mode the CS/SS/DS/ES segments are ignored and the base address is
+always 0 to provide a full 64bit address space. The FS and GS segments are
+still functional in 64-bit mode.
+
+Common FS and GS usage
+------------------------------
+
+The FS segment is commonly used to address Thread Local Storage (TLS). FS
+is usually managed by runtime code or a threading library. Variables
+declared with the '__thread' storage class specifier are instantiated per
+thread and the compiler emits the FS: address prefix for accesses to these
+variables. Each thread has its own FS base address so common code can be
+used without complex address offset calculations to access the per thread
+instances. Applications should not use FS for other purposes when they use
+runtimes or threading libraries which manage the per thread FS.
+
+The GS segment has no common use and can be used freely by
+applications. GCC and Clang support GS based addressing via address space
+identifiers.
+
+Reading and writing the FS/GS base address
+------------------------------------------
+
+There exist two mechanisms to read and write the FS/FS base address:
+
+ - the arch_prctl() system call
+
+ - the FSGSBASE instruction family
+
+Accessing FS/GS base with arch_prctl()
+--------------------------------------
+
+ The arch_prctl(2) based mechanism is available on all 64bit CPUs and all
+ kernel versions.
+
+ Reading the base:
+
+   arch_prctl(ARCH_GET_FS, &fsbase);
+   arch_prctl(ARCH_GET_GS, &gsbase);
+
+ Writing the base:
+
+   arch_prctl(ARCH_SET_FS, fsbase);
+   arch_prctl(ARCH_SET_GS, gsbase);
+
+ The ARCH_SET_GS prctl may be disabled depending on kernel configuration
+ and security settings.
+
+Accessing FS/GS base with the FSGSBASE instructions
+---------------------------------------------------
+
+ With the Ivy Bridge CPU generation Intel introduced a new set of
+ instructions to access the FS and GS base registers directly from user
+ space. These instructions are also supported on AMD Family 17H CPUs. The
+ following instructions are available:
+
+  =============== ===========================
+  RDFSBASE %reg   Read the FS base register
+  RDGSBASE %reg   Read the GS base register
+  WRFSBASE %reg   Write the FS base register
+  WRGSBASE %reg   Write the GS base register
+  =============== ===========================
+
+ The instructions avoid the overhead of the arch_prctl() syscall and allow
+ more flexible usage of the FS/GS addressing modes in user space
+ applications. This does not prevent conflicts between threading libraries
+ and runtimes which utilize FS and applications which want to use it for
+ their own purpose.
+
+FSGSBASE instructions enablement
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ The instructions are enumerated in CPUID leaf 7, bit 0 of EBX. If
+ available /proc/cpuinfo shows 'fsgsbase' in the flag entry of the CPUs.
+
+ The availability of the instructions does not enable them
+ automatically. The kernel has to enable them explicitly in CR4. The
+ reason for this is that older kernels make assumptions about the values in
+ the GS register and enforce them when GS base is set via
+ arch_prctl(). Allowing user space to write arbitrary values to GS base
+ would violate these assumptions and cause malfunction.
+
+ On kernels which do not enable FSGSBASE the execution of the FSGSBASE
+ instructions will fault with a #UD exception.
+
+ The kernel provides reliable information about the enabled state in the
+ ELF AUX vector. If the HWCAP2_FSGSBASE bit is set in the AUX vector, the
+ kernel has FSGSBASE instructions enabled and applications can use them.
+ The following code example shows how this detection works::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+
+   /* Will be eventually in asm/hwcap.h */
+   #ifndef HWCAP2_FSGSBASE
+   #define HWCAP2_FSGSBASE        (1 << 1)
+   #endif
+
+   ....
+
+   unsigned val = getauxval(AT_HWCAP2);
+
+   if (val & HWCAP2_FSGSBASE)
+        printf("FSGSBASE enabled\n");
+
+FSGSBASE instructions compiler support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+GCC version 4.6.4 and newer provide instrinsics for the FSGSBASE
+instructions. Clang supports them as well.
+
+  =================== ===========================
+  _readfsbase_u64()   Read the FS base register
+  _readfsbase_u64()   Read the GS base register
+  _writefsbase_u64()  Write the FS base register
+  _writegsbase_u64()  Write the GS base register
+  =================== ===========================
+
+To utilize these instrinsics <immintrin.h> must be included in the source
+code and the compiler option -mfsgsbase has to be added.
+
+Compiler support for FS/GS based addressing
+-------------------------------------------
+
+GCC version 6 and newer provide support for FS/GS based addressing via
+Named Address Spaces. GCC implements the following address space
+identifiers for x86:
+
+  ========= ====================================
+  __seg_fs  Variable is addressed relative to FS
+  __seg_gs  Variable is addressed relative to GS
+  ========= ====================================
+
+The preprocessor symbols __SEG_FS and __SEG_GS are defined when these
+address spaces are supported. Code which implements fallback modes should
+check whether these symbols are defined. Usage example::
+
+  #ifdef __SEG_GS
+
+  long data0 = 0;
+  long data1 = 1;
+
+  long __seg_gs *ptr;
+
+  /* Check whether FSGSBASE is enabled by the kernel (HWCAP2_FSGSBASE) */
+  ....
+
+  /* Set GS to point to data0 */
+  _writegsbase_u64(&data0);
+
+  /* Access offset 0 of GS */
+  ptr = 0;
+  printf("data0 = %ld\n", *ptr);
+
+  /* Set GS to point to data1 */
+  _writegsbase_u64(&data1);
+  /* ptr still addresses offset 0! */
+  printf("data1 = %ld\n", *ptr);
+
+
+Clang does not provide the GCC address space identifiers, but it provides
+address spaces via an attribute based mechanism in Clang 5 and newer
+versions:
+
+ ==================================== =====================================
+  __attribute__((address_space(256))  Variable is addressed relative to GS
+  __attribute__((address_space(257))  Variable is addressed relative to FS
+ ==================================== =====================================
+
+FS/GS based addressing with inline assembly
+-------------------------------------------
+
+In case the compiler does not support address spaces, inline assembly can
+be used for FS/GS based addressing mode::
+
+	mov %fs:offset, %reg
+	mov %gs:offset, %reg
+
+	mov %reg, %fs:offset
+	mov %reg, %gs:offset
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index d6eaaa5a35fc..a56070fc8e77 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -14,3 +14,4 @@ x86_64 Support
    fake-numa-for-cpusets
    cpu-hotplug-spec
    machinecheck
+   fsgs
