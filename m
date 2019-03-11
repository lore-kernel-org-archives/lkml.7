Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC87FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7515C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfCKPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:53:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKPxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:53:48 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQeDw-1hNo2C38cQ-00NjRZ; Mon, 11 Mar 2019 16:53:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     alistair@popple.id.au, mporter@kernel.crashing.org,
        oss@buserror.net, galak@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] arch: powerpc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 16:53:31 +0100
Message-Id: <1552319611-5446-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:bTT/RPSEmBh/6cRBbK/h9wD8TNAz9CM5Wht2EGcAkJQh5wp9HRe
 nD4a04UR6jxklI/myrEhrM5FMUjbdNo61Wchx0rkvwndAa+O3FBryTSrafFKJFksq1Gz9XS
 XtdAb5YyDYezMUvhRFrxMtWr97UoaWRAYE8hD2EdvtHE7IhdOJI4EmIKJGsH8iAsS/b1qiJ
 yRDsP8gl2WZXJfPJGAHkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NPJxHC9Z18M=:jY0ALs/JeAirZfuaWr026E
 LYDmy/JN2xganoV1co8hh9PpgxSL1QiN5r5ppicDMarDtWs1kWVk35BuMK+yT1f/+hiAREt1S
 JChNNdTEKelGN59N4q47Cs+0eseOXkRKpMXV8toz2tB2Cn12IVQic1X9ms5QHTQGlMP6fRmm/
 U3qp8pOXdfzd09w5T3QwLVnKNLNoPs+Um3BZ0RSD/sGDV3449r8CB1t8i4d+7FalZVz3Yc8H1
 xPECF6cNiGuTKktl7CzwQIma99k3g0OYA0M8hnMtrxAHN+lgVVZ2AoOYuaTwdfeMOBXhUYfM2
 aUC52vqsdJ3eb1hYDeWLcIuDYq7XK3ArSd/4RIt5RLKys99tCiSK9gVHfoDJsg9F6w350iYQB
 ozIbbvovAY1YzxD2lMLefO16P4tTyT79+mLtK0y34/kpR9D0a7x1eBEdNaziIStwytVWSJI+N
 QmZV2HZbvOslPo/AlVjC4hsurtlHyjmvZodaqPokV7zL9G8OzGmptlqB2BC/vdStBWD/qJvi5
 OIg7DeZrUc28cJ9cNm5imyr+BkwhEnFbn4Ioq5phtJRwWMFWI3yzTWu8Vnm1pD4rt+agWI/5w
 fAWivf0RiaR10kTPK5Znd4ocduNfDZFuKoCrUfak518ypewaxSUjQVOGnImJoXIMuhWv/XWQX
 vR8rgUCq7gX8XQ/dfxAfQ628y1kRS5Xezth8QGR3CRYBz5odrJ46xsYVMUoVbuc/83+WW1Fnm
 VQksA7P/pwxh0uhO2a2hmPNLsZpgVeEgCPHiSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/powerpc/Kconfig                   | 28 ++++++++++++++--------------
 arch/powerpc/kvm/Kconfig               |  6 +++---
 arch/powerpc/platforms/40x/Kconfig     |  7 +++----
 arch/powerpc/platforms/44x/Kconfig     | 10 +++++-----
 arch/powerpc/platforms/85xx/Kconfig    |  8 ++++----
 arch/powerpc/platforms/86xx/Kconfig    |  6 +++---
 arch/powerpc/platforms/maple/Kconfig   |  2 +-
 arch/powerpc/platforms/pseries/Kconfig | 18 +++++++++---------
 arch/powerpc/sysdev/xics/Kconfig       | 13 ++++++-------
 9 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82..ea29d94 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -48,7 +48,7 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
 	# Allow randomisation to consume up to 512MB of address space (2^29).
 	default 11 if PPC_256K_PAGES	# 11 = 29 (512MB) - 18 (256K)
 	default 13 if PPC_64K_PAGES	# 13 = 29 (512MB) - 16 (64K)
-	default 15 if PPC_16K_PAGES 	# 15 = 29 (512MB) - 14 (16K)
+	default 15 if PPC_16K_PAGES	# 15 = 29 (512MB) - 14 (16K)
 	default 17			# 17 = 29 (512MB) - 12 (4K)
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
@@ -246,9 +246,9 @@ config PPC
 	#
 
 config PPC_BARRIER_NOSPEC
-    bool
-    default y
-    depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
+	bool
+	default y
+	depends on PPC_BOOK3S_64 || PPC_FSL_BOOK3E
 
 config EARLY_PRINTK
 	bool
@@ -430,13 +430,13 @@ config MATH_EMULATION_HW_UNIMPLEMENTED
 endchoice
 
 config PPC_TRANSACTIONAL_MEM
-       bool "Transactional Memory support for POWERPC"
-       depends on PPC_BOOK3S_64
-       depends on SMP
-       select ALTIVEC
-       select VSX
-       ---help---
-         Support user-mode Transactional Memory on POWERPC.
+	bool "Transactional Memory support for POWERPC"
+	depends on PPC_BOOK3S_64
+	depends on SMP
+	select ALTIVEC
+	select VSX
+	---help---
+	  Support user-mode Transactional Memory on POWERPC.
 
 config LD_HEAD_STUB_CATCH
 	bool "Reserve 256 bytes to cope with linker stubs in HEAD text" if EXPERT
@@ -937,7 +937,7 @@ config FSL_SOC
 	bool
 
 config FSL_PCI
- 	bool
+	bool
 	select ARCH_HAS_DMA_SET_MASK
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
@@ -1049,14 +1049,14 @@ config DYNAMIC_MEMSTART
 	select NONSTATIC_KERNEL
 	help
 	  This option enables the kernel to be loaded at any page aligned
-	  physical address. The kernel creates a mapping from KERNELBASE to 
+	  physical address. The kernel creates a mapping from KERNELBASE to
 	  the address where the kernel is loaded. The page size here implies
 	  the TLB page size of the mapping for kernel on the particular platform.
 	  Please refer to the init code for finding the TLB page size.
 
 	  DYNAMIC_MEMSTART is an easy way of implementing pseudo-RELOCATABLE
 	  kernel image, where the only restriction is the page aligned kernel
-	  load address. When this option is enabled, the compile time physical 
+	  load address. When this option is enabled, the compile time physical
 	  address CONFIG_PHYSICAL_START is ignored.
 
 	  This option is overridden by CONFIG_RELOCATABLE
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index bfdde04..cfc4cbe 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -184,9 +184,9 @@ config KVM_MPIC
 	select HAVE_KVM_MSI
 	help
 	  Enable support for emulating MPIC devices inside the
-          host kernel, rather than relying on userspace to emulate.
-          Currently, support is limited to certain versions of
-          Freescale's MPIC implementation.
+	  host kernel, rather than relying on userspace to emulate.
+	  Currently, support is limited to certain versions of
+	  Freescale's MPIC implementation.
 
 config KVM_XICS
 	bool "KVM in-kernel XICS emulation"
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index ad2bb14..6da813b 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -16,12 +16,12 @@ config EP405
 	  This option enables support for the EP405/EP405PC boards.
 
 config HOTFOOT
-        bool "Hotfoot"
+	bool "Hotfoot"
 	depends on 40x
 	select PPC40x_SIMPLE
 	select FORCE_PCI
-        help
-	 This option enables support for the ESTEEM 195E Hotfoot board.
+	help
+	  This option enables support for the ESTEEM 195E Hotfoot board.
 
 config KILAUEA
 	bool "Kilauea"
@@ -80,7 +80,6 @@ config OBS600
 	help
 	  This option enables support for PlatHome OpenBlockS 600 server
 
-
 config PPC40x_SIMPLE
 	bool "Simple PowerPC 40x board support"
 	depends on 40x
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 35be81f..b369ed4 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -40,12 +40,12 @@ config EBONY
 	  This option enables support for the IBM PPC440GP evaluation board.
 
 config SAM440EP
-        bool "Sam440ep"
+	bool "Sam440ep"
 	depends on 44x
-        select 440EP
-        select FORCE_PCI
-        help
-          This option enables support for the ACube Sam440ep board.
+	select 440EP
+	select FORCE_PCI
+	help
+	  This option enables support for the ACube Sam440ep board.
 
 config SEQUOIA
 	bool "Sequoia"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index d1af0ee2..fa3d29d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -147,10 +147,10 @@ config SOCRATES
 	  This option enables support for the Socrates board.
 
 config KSI8560
-        bool "Emerson KSI8560"
-        select DEFAULT_UIMAGE
-        help
-          This option enables support for the Emerson KSI8560 board
+	bool "Emerson KSI8560"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the Emerson KSI8560 board
 
 config XES_MPC85xx
 	bool "X-ES single-board computer"
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 0a61011..07a9d60 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -62,9 +62,9 @@ config GEF_SBC610
 	  This option enables support for the GE SBC610.
 
 config MVME7100
-        bool "Artesyn MVME7100"
-        help
-          This option enables support for the Emerson/Artesyn MVME7100 board.
+	bool "Artesyn MVME7100"
+	help
+	  This option enables support for the Emerson/Artesyn MVME7100 board.
 
 endif
 
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
index 08d530a..86ae210 100644
--- a/arch/powerpc/platforms/maple/Kconfig
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -14,5 +14,5 @@ config PPC_MAPLE
 	select MMIO_NVRAM
 	select ATA_NONSTANDARD if ATA
 	help
-          This option enables support for the Maple 970FX Evaluation Board.
+	  This option enables support for the Maple 970FX Evaluation Board.
 	  For more information, refer to <http://www.970eval.com>
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 9c6b3d8..c7ad9818 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -80,19 +80,19 @@ config LPARCFG
 	bool "LPAR Configuration Data"
 	depends on PPC_PSERIES
 	help
-	Provide system capacity information via human readable
-	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
+	  Provide system capacity information via human readable
+	  <key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
 
 config PPC_PSERIES_DEBUG
 	depends on PPC_PSERIES && PPC_EARLY_DEBUG
 	bool "Enable extra debug logging in platforms/pseries"
-        help
+	default y
+	help
 	  Say Y here if you want the pseries core to produce a bunch of
 	  debug messages to the system log. Select this if you are having a
 	  problem with the pseries core and want to see more of what is
 	  going on. This does not enable debugging in lpar.c, which must
 	  be manually done due to its verbosity.
-	default y
 
 config PPC_SMLPAR
 	bool "Support for shared-memory logical partitions"
@@ -117,16 +117,16 @@ config CMM
 	  balance memory across many LPARs.
 
 config HV_PERF_CTRS
-       bool "Hypervisor supplied PMU events (24x7 & GPCI)"
-       default y
-       depends on PERF_EVENTS && PPC_PSERIES
-       help
+	bool "Hypervisor supplied PMU events (24x7 & GPCI)"
+	default y
+	depends on PERF_EVENTS && PPC_PSERIES
+	help
 	  Enable access to hypervisor supplied counters in perf. Currently,
 	  this enables code that uses the hcall GetPerfCounterInfo and 24x7
 	  interfaces to retrieve counters. GPCI exists on Power 6 and later
 	  systems. 24x7 is available on Power 8 and later systems.
 
-          If unsure, select Y.
+	  If unsure, select Y.
 
 config IBMVIO
 	depends on PPC_PSERIES
diff --git a/arch/powerpc/sysdev/xics/Kconfig b/arch/powerpc/sysdev/xics/Kconfig
index 86fee42..304614c 100644
--- a/arch/powerpc/sysdev/xics/Kconfig
+++ b/arch/powerpc/sysdev/xics/Kconfig
@@ -1,15 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_XICS
-       def_bool n
-       select PPC_SMP_MUXED_IPI
-       select HARDIRQS_SW_RESEND
+	def_bool n
+	select PPC_SMP_MUXED_IPI
+	select HARDIRQS_SW_RESEND
 
 config PPC_ICP_NATIVE
-       def_bool n
+	def_bool n
 
 config PPC_ICP_HV
-       def_bool n
+	def_bool n
 
 config PPC_ICS_RTAS
-       def_bool n
-
+	def_bool n
-- 
1.9.1

