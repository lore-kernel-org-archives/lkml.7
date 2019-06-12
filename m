Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA75DC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAD220896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364805;
	bh=xGIDYjVpJmm23capjGAsogIH6KKchKRjiIt3KMeEzq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M28K4JZanspCVTbKEXIHfSoP8O2idfBJ8rEJ9O5P75rGaNlokr2uI00Yq08pHTu70
	 P9Q1DwJLusUVpQU5icroGA/HWQn032rk0NQ8X8qG9PrmPr7+ZrhA7Q8zZ8F/e7t3xl
	 jNtqIxSRMdOuf6xvyMUYvnoSkGMq2IJmbwsUL7MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFLSkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:40:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfFLSim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0VLakIBup/yQlJkWn9nXbGqz30AP75CDLkGAfkQkgYU=; b=YxHGEVy41G3Fj/zqKwQmrPfNak
        x/JK/NEjfRXJgGzWbjVO49aKfjX9LPEGJnsU8M0GMuvJtck4KXNHIB67SGDi6ZHfXy4gi9wK1mJr2
        +GzDPeoeTvjG30q6rVOgjK9fiOMv3kPSUs7vddY6u9BVfyi9JjTcDFiuO+9KXwQL/d5VOkimSM5jp
        JkqOM2R6LRp8QIItjdZRffz9OPb7s/EjdT9XbknvUgWyY/fIXqrWh8mGrd4bHBrNtxKDsGE/G1vXy
        ibGDRVV+qd0iD4PfrmgkhUvDg03wv2ESRUAFGnHqLzRl1braqMDfvr+bQ1ZgGLtNKhWGGy3X6lg48
        95cwa9Vg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006YU-ND; Wed, 12 Jun 2019 18:38:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002CD-JK; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH v1 30/31] docs: xtensa: convert to ReST
Date:   Wed, 12 Jun 2019 15:38:33 -0300
Message-Id: <cd2fa8ed3001db6dc9634e54a5a40f1d965bc427.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the xtensa documentation files to ReST, add an
index for them and adjust in order to produce a nice html
output via the Sphinx build system.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../xtensa/{atomctl.txt => atomctl.rst}       |  13 +-
 .../xtensa/{booting.txt => booting.rst}       |   5 +-
 Documentation/xtensa/index.rst                |  12 ++
 Documentation/xtensa/mmu.rst                  | 195 ++++++++++++++++++
 Documentation/xtensa/mmu.txt                  | 189 -----------------
 arch/xtensa/include/asm/initialize_mmu.h      |   2 +-
 6 files changed, 222 insertions(+), 194 deletions(-)
 rename Documentation/xtensa/{atomctl.txt => atomctl.rst} (81%)
 rename Documentation/xtensa/{booting.txt => booting.rst} (91%)
 create mode 100644 Documentation/xtensa/index.rst
 create mode 100644 Documentation/xtensa/mmu.rst
 delete mode 100644 Documentation/xtensa/mmu.txt

diff --git a/Documentation/xtensa/atomctl.txt b/Documentation/xtensa/atomctl.rst
similarity index 81%
rename from Documentation/xtensa/atomctl.txt
rename to Documentation/xtensa/atomctl.rst
index 1da783ac200c..1ecbd0ba9a2e 100644
--- a/Documentation/xtensa/atomctl.txt
+++ b/Documentation/xtensa/atomctl.rst
@@ -1,3 +1,7 @@
+===========================================
+Atomic Operation Control (ATOMCTL) Register
+===========================================
+
 We Have Atomic Operation Control (ATOMCTL) Register.
 This register determines the effect of using a S32C1I instruction
 with various combinations of:
@@ -8,7 +12,7 @@ with various combinations of:
      2. With and without An Intelligent Memory Controller which
         can do Atomic Transactions itself.
 
-The Core comes up with a default value of for the three types of cache ops:
+The Core comes up with a default value of for the three types of cache ops::
 
       0x28: (WB: Internal, WT: Internal, BY:Exception)
 
@@ -30,15 +34,18 @@ CUSTOMER-WARNING:
 Developers might find using RCW in Bypass mode convenient when testing
 with the cache being bypassed; for example studying cache alias problems.
 
-See Section 4.3.12.4 of ISA; Bits:
+See Section 4.3.12.4 of ISA; Bits::
 
                              WB     WT      BY
                            5   4 | 3   2 | 1   0
+
+=========    ==================      ==================      ===============
   2 Bit
   Field
   Values     WB - Write Back         WT - Write Thru         BY - Bypass
----------    ---------------         -----------------     ----------------
+=========    ==================      ==================      ===============
     0        Exception               Exception               Exception
     1        RCW Transaction         RCW Transaction         RCW Transaction
     2        Internal Operation      Internal Operation      Reserved
     3        Reserved                Reserved                Reserved
+=========    ==================      ==================      ===============
diff --git a/Documentation/xtensa/booting.txt b/Documentation/xtensa/booting.rst
similarity index 91%
rename from Documentation/xtensa/booting.txt
rename to Documentation/xtensa/booting.rst
index 402b33a2619f..e1b83707e5b6 100644
--- a/Documentation/xtensa/booting.txt
+++ b/Documentation/xtensa/booting.rst
@@ -1,10 +1,13 @@
-Passing boot parameters to the kernel.
+=====================================
+Passing boot parameters to the kernel
+=====================================
 
 Boot parameters are represented as a TLV list in the memory. Please see
 arch/xtensa/include/asm/bootparam.h for definition of the bp_tag structure and
 tag value constants. First entry in the list must have type BP_TAG_FIRST, last
 entry must have type BP_TAG_LAST. The address of the first list entry is
 passed to the kernel in the register a2. The address type depends on MMU type:
+
 - For configurations without MMU, with region protection or with MPU the
   address must be the physical address.
 - For configurations with region translarion MMU or with MMUv3 and CONFIG_MMU=n
diff --git a/Documentation/xtensa/index.rst b/Documentation/xtensa/index.rst
new file mode 100644
index 000000000000..5a24e365e35f
--- /dev/null
+++ b/Documentation/xtensa/index.rst
@@ -0,0 +1,12 @@
+:orphan:
+
+===================
+Xtensa Architecture
+===================
+
+.. toctree::
+   :maxdepth: 1
+
+   atomctl
+   booting
+   mmu
diff --git a/Documentation/xtensa/mmu.rst b/Documentation/xtensa/mmu.rst
new file mode 100644
index 000000000000..e52a12960fdc
--- /dev/null
+++ b/Documentation/xtensa/mmu.rst
@@ -0,0 +1,195 @@
+=============================
+MMUv3 initialization sequence
+=============================
+
+The code in the initialize_mmu macro sets up MMUv3 memory mapping
+identically to MMUv2 fixed memory mapping. Depending on
+CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX symbol this code is
+located in addresses it was linked for (symbol undefined), or not
+(symbol defined), so it needs to be position-independent.
+
+The code has the following assumptions:
+
+  - This code fragment is run only on an MMU v3.
+  - TLBs are in their reset state.
+  - ITLBCFG and DTLBCFG are zero (reset state).
+  - RASID is 0x04030201 (reset state).
+  - PS.RING is zero (reset state).
+  - LITBASE is zero (reset state, PC-relative literals); required to be PIC.
+
+TLB setup proceeds along the following steps.
+
+  Legend:
+
+    - VA = virtual address (two upper nibbles of it);
+    - PA = physical address (two upper nibbles of it);
+    - pc = physical range that contains this code;
+
+After step 2, we jump to virtual address in the range 0x40000000..0x5fffffff
+or 0x00000000..0x1fffffff, depending on whether the kernel was loaded below
+0x40000000 or above. That address corresponds to next instruction to execute
+in this code. After step 4, we jump to intended (linked) address of this code.
+The scheme below assumes that the kernel is loaded below 0x40000000.
+
+ ====== =====  =====  =====  =====   ====== =====  =====
+ -      Step0  Step1  Step2  Step3          Step4  Step5
+
+   VA      PA     PA     PA     PA     VA      PA     PA
+ ====== =====  =====  =====  =====   ====== =====  =====
+ E0..FF -> E0  -> E0  -> E0          F0..FF -> F0  -> F0
+ C0..DF -> C0  -> C0  -> C0          E0..EF -> F0  -> F0
+ A0..BF -> A0  -> A0  -> A0          D8..DF -> 00  -> 00
+ 80..9F -> 80  -> 80  -> 80          D0..D7 -> 00  -> 00
+ 60..7F -> 60  -> 60  -> 60
+ 40..5F -> 40         -> pc  -> pc   40..5F -> pc
+ 20..3F -> 20  -> 20  -> 20
+ 00..1F -> 00  -> 00  -> 00
+ ====== =====  =====  =====  =====   ====== =====  =====
+
+The default location of IO peripherals is above 0xf0000000. This may be changed
+using a "ranges" property in a device tree simple-bus node. See the Devicetree
+Specification, section 4.5 for details on the syntax and semantics of
+simple-bus nodes. The following limitations apply:
+
+1. Only top level simple-bus nodes are considered
+
+2. Only one (first) simple-bus node is considered
+
+3. Empty "ranges" properties are not supported
+
+4. Only the first triplet in the "ranges" property is considered
+
+5. The parent-bus-address value is rounded down to the nearest 256MB boundary
+
+6. The IO area covers the entire 256MB segment of parent-bus-address; the
+   "ranges" triplet length field is ignored
+
+
+MMUv3 address space layouts.
+============================
+
+Default MMUv2-compatible layout::
+
+                        Symbol                   VADDR       Size
+  +------------------+
+  | Userspace        |                           0x00000000  TASK_SIZE
+  +------------------+                           0x40000000
+  +------------------+
+  | Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
+  +------------------+
+  | KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
+  +------------------+                           0x8e400000
+  +------------------+
+  | VMALLOC area     |  VMALLOC_START            0xc0000000  128MB - 64KB
+  +------------------+  VMALLOC_END
+  | Cache aliasing   |  TLBTEMP_BASE_1           0xc7ff0000  DCACHE_WAY_SIZE
+  | remap area 1     |
+  +------------------+
+  | Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
+  | remap area 2     |
+  +------------------+
+  +------------------+
+  | KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  |                  |                                       (4MB * DCACHE_N_COLORS)
+  +------------------+
+  | Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
+  |                  |                                       NR_CPUS *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  +------------------+  FIXADDR_TOP              0xcffff000
+  +------------------+
+  | Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xd0000000  128MB
+  +------------------+
+  | Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xd8000000  128MB
+  +------------------+
+  | Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
+  +------------------+
+  | Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
+  +------------------+
+
+
+256MB cached + 256MB uncached layout::
+
+                        Symbol                   VADDR       Size
+  +------------------+
+  | Userspace        |                           0x00000000  TASK_SIZE
+  +------------------+                           0x40000000
+  +------------------+
+  | Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
+  +------------------+
+  | KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
+  +------------------+                           0x8e400000
+  +------------------+
+  | VMALLOC area     |  VMALLOC_START            0xa0000000  128MB - 64KB
+  +------------------+  VMALLOC_END
+  | Cache aliasing   |  TLBTEMP_BASE_1           0xa7ff0000  DCACHE_WAY_SIZE
+  | remap area 1     |
+  +------------------+
+  | Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
+  | remap area 2     |
+  +------------------+
+  +------------------+
+  | KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  |                  |                                       (4MB * DCACHE_N_COLORS)
+  +------------------+
+  | Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
+  |                  |                                       NR_CPUS *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  +------------------+  FIXADDR_TOP              0xaffff000
+  +------------------+
+  | Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xb0000000  256MB
+  +------------------+
+  | Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xc0000000  256MB
+  +------------------+
+  +------------------+
+  | Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
+  +------------------+
+  | Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
+  +------------------+
+
+
+512MB cached + 512MB uncached layout::
+
+                        Symbol                   VADDR       Size
+  +------------------+
+  | Userspace        |                           0x00000000  TASK_SIZE
+  +------------------+                           0x40000000
+  +------------------+
+  | Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
+  +------------------+
+  | KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
+  +------------------+                           0x8e400000
+  +------------------+
+  | VMALLOC area     |  VMALLOC_START            0x90000000  128MB - 64KB
+  +------------------+  VMALLOC_END
+  | Cache aliasing   |  TLBTEMP_BASE_1           0x97ff0000  DCACHE_WAY_SIZE
+  | remap area 1     |
+  +------------------+
+  | Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
+  | remap area 2     |
+  +------------------+
+  +------------------+
+  | KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  |                  |                                       (4MB * DCACHE_N_COLORS)
+  +------------------+
+  | Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
+  |                  |                                       NR_CPUS *
+  |                  |                                       DCACHE_N_COLORS *
+  |                  |                                       PAGE_SIZE
+  +------------------+  FIXADDR_TOP              0x9ffff000
+  +------------------+
+  | Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xa0000000  512MB
+  +------------------+
+  | Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xc0000000  512MB
+  +------------------+
+  | Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
+  +------------------+
+  | Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
+  +------------------+
diff --git a/Documentation/xtensa/mmu.txt b/Documentation/xtensa/mmu.txt
deleted file mode 100644
index 318114de63f3..000000000000
--- a/Documentation/xtensa/mmu.txt
+++ /dev/null
@@ -1,189 +0,0 @@
-MMUv3 initialization sequence.
-
-The code in the initialize_mmu macro sets up MMUv3 memory mapping
-identically to MMUv2 fixed memory mapping. Depending on
-CONFIG_INITIALIZE_XTENSA_MMU_INSIDE_VMLINUX symbol this code is
-located in addresses it was linked for (symbol undefined), or not
-(symbol defined), so it needs to be position-independent.
-
-The code has the following assumptions:
-  This code fragment is run only on an MMU v3.
-  TLBs are in their reset state.
-  ITLBCFG and DTLBCFG are zero (reset state).
-  RASID is 0x04030201 (reset state).
-  PS.RING is zero (reset state).
-  LITBASE is zero (reset state, PC-relative literals); required to be PIC.
-
-TLB setup proceeds along the following steps.
-
-  Legend:
-    VA = virtual address (two upper nibbles of it);
-    PA = physical address (two upper nibbles of it);
-    pc = physical range that contains this code;
-
-After step 2, we jump to virtual address in the range 0x40000000..0x5fffffff
-or 0x00000000..0x1fffffff, depending on whether the kernel was loaded below
-0x40000000 or above. That address corresponds to next instruction to execute
-in this code. After step 4, we jump to intended (linked) address of this code.
-The scheme below assumes that the kernel is loaded below 0x40000000.
-
-        Step0  Step1  Step2  Step3          Step4  Step5
-        =====  =====  =====  =====          =====  =====
-   VA      PA     PA     PA     PA     VA      PA     PA
- ------    --     --     --     --   ------    --     --
- E0..FF -> E0  -> E0  -> E0          F0..FF -> F0  -> F0
- C0..DF -> C0  -> C0  -> C0          E0..EF -> F0  -> F0
- A0..BF -> A0  -> A0  -> A0          D8..DF -> 00  -> 00
- 80..9F -> 80  -> 80  -> 80          D0..D7 -> 00  -> 00
- 60..7F -> 60  -> 60  -> 60
- 40..5F -> 40         -> pc  -> pc   40..5F -> pc
- 20..3F -> 20  -> 20  -> 20
- 00..1F -> 00  -> 00  -> 00
-
-The default location of IO peripherals is above 0xf0000000. This may be changed
-using a "ranges" property in a device tree simple-bus node. See the Devicetree
-Specification, section 4.5 for details on the syntax and semantics of
-simple-bus nodes. The following limitations apply:
-
-1. Only top level simple-bus nodes are considered
-
-2. Only one (first) simple-bus node is considered
-
-3. Empty "ranges" properties are not supported
-
-4. Only the first triplet in the "ranges" property is considered
-
-5. The parent-bus-address value is rounded down to the nearest 256MB boundary
-
-6. The IO area covers the entire 256MB segment of parent-bus-address; the
-   "ranges" triplet length field is ignored
-
-
-MMUv3 address space layouts.
-============================
-
-Default MMUv2-compatible layout.
-
-                      Symbol                   VADDR       Size
-+------------------+
-| Userspace        |                           0x00000000  TASK_SIZE
-+------------------+                           0x40000000
-+------------------+
-| Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
-+------------------+
-| KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
-+------------------+                           0x8e400000
-+------------------+
-| VMALLOC area     |  VMALLOC_START            0xc0000000  128MB - 64KB
-+------------------+  VMALLOC_END
-| Cache aliasing   |  TLBTEMP_BASE_1           0xc7ff0000  DCACHE_WAY_SIZE
-| remap area 1     |
-+------------------+
-| Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
-| remap area 2     |
-+------------------+
-+------------------+
-| KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-|                  |                                       (4MB * DCACHE_N_COLORS)
-+------------------+
-| Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
-|                  |                                       NR_CPUS *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-+------------------+  FIXADDR_TOP              0xcffff000
-+------------------+
-| Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xd0000000  128MB
-+------------------+
-| Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xd8000000  128MB
-+------------------+
-| Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
-+------------------+
-| Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
-+------------------+
-
-
-256MB cached + 256MB uncached layout.
-
-                      Symbol                   VADDR       Size
-+------------------+
-| Userspace        |                           0x00000000  TASK_SIZE
-+------------------+                           0x40000000
-+------------------+
-| Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
-+------------------+
-| KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
-+------------------+                           0x8e400000
-+------------------+
-| VMALLOC area     |  VMALLOC_START            0xa0000000  128MB - 64KB
-+------------------+  VMALLOC_END
-| Cache aliasing   |  TLBTEMP_BASE_1           0xa7ff0000  DCACHE_WAY_SIZE
-| remap area 1     |
-+------------------+
-| Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
-| remap area 2     |
-+------------------+
-+------------------+
-| KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-|                  |                                       (4MB * DCACHE_N_COLORS)
-+------------------+
-| Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
-|                  |                                       NR_CPUS *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-+------------------+  FIXADDR_TOP              0xaffff000
-+------------------+
-| Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xb0000000  256MB
-+------------------+
-| Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xc0000000  256MB
-+------------------+
-+------------------+
-| Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
-+------------------+
-| Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
-+------------------+
-
-
-512MB cached + 512MB uncached layout.
-
-                      Symbol                   VADDR       Size
-+------------------+
-| Userspace        |                           0x00000000  TASK_SIZE
-+------------------+                           0x40000000
-+------------------+
-| Page table       |  XCHAL_PAGE_TABLE_VADDR   0x80000000  XCHAL_PAGE_TABLE_SIZE
-+------------------+
-| KASAN shadow map |  KASAN_SHADOW_START       0x80400000  KASAN_SHADOW_SIZE
-+------------------+                           0x8e400000
-+------------------+
-| VMALLOC area     |  VMALLOC_START            0x90000000  128MB - 64KB
-+------------------+  VMALLOC_END
-| Cache aliasing   |  TLBTEMP_BASE_1           0x97ff0000  DCACHE_WAY_SIZE
-| remap area 1     |
-+------------------+
-| Cache aliasing   |  TLBTEMP_BASE_2                       DCACHE_WAY_SIZE
-| remap area 2     |
-+------------------+
-+------------------+
-| KMAP area        |  PKMAP_BASE                           PTRS_PER_PTE *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-|                  |                                       (4MB * DCACHE_N_COLORS)
-+------------------+
-| Atomic KMAP area |  FIXADDR_START                        KM_TYPE_NR *
-|                  |                                       NR_CPUS *
-|                  |                                       DCACHE_N_COLORS *
-|                  |                                       PAGE_SIZE
-+------------------+  FIXADDR_TOP              0x9ffff000
-+------------------+
-| Cached KSEG      |  XCHAL_KSEG_CACHED_VADDR  0xa0000000  512MB
-+------------------+
-| Uncached KSEG    |  XCHAL_KSEG_BYPASS_VADDR  0xc0000000  512MB
-+------------------+
-| Cached KIO       |  XCHAL_KIO_CACHED_VADDR   0xe0000000  256MB
-+------------------+
-| Uncached KIO     |  XCHAL_KIO_BYPASS_VADDR   0xf0000000  256MB
-+------------------+
diff --git a/arch/xtensa/include/asm/initialize_mmu.h b/arch/xtensa/include/asm/initialize_mmu.h
index 323d05789159..3b054d2bede0 100644
--- a/arch/xtensa/include/asm/initialize_mmu.h
+++ b/arch/xtensa/include/asm/initialize_mmu.h
@@ -42,7 +42,7 @@
 #if XCHAL_HAVE_S32C1I && (XCHAL_HW_MIN_VERSION >= XTENSA_HWVERSION_RC_2009_0)
 /*
  * We Have Atomic Operation Control (ATOMCTL) Register; Initialize it.
- * For details see Documentation/xtensa/atomctl.txt
+ * For details see Documentation/xtensa/atomctl.rst
  */
 #if XCHAL_DCACHE_IS_COHERENT
 	movi	a3, 0x25	/* For SMP/MX -- internal for writeback,
-- 
2.21.0

