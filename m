Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42676C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069C52084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCKNTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfCKNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:35 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4R4i-1gsvWE2NyI-011Tkj for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 037/114] arch: powerpc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:49 +0100
Message-Id: <1552310346-7629-38-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:liRt97iKsVxpUwiG9VS5QQxwmYpujYN90hMTB9X8ih6aH/sAfvG
 muVWLktVt9QzeA324eI7LRwIHjKObWMx+WSfBQKRaiIJm4WAUh5musR69EUMizndq2mByNV
 2BIAT2Qf0krV7NRV1G/Okq3dEhgW4TU4g1ZoHXRde0UxyLnmYZ+Yy8UmtOl5SL1Y5OG99UY
 IKhfLKkY8b8tSZJ2DqDLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H2KIv4vbT2o=:A3cSlP8xdxfgUp+PAD7KQK
 0/sw4+PQ/w9xQtS9Xu4nQhhnIiwJwwsCIBh1A71ldVh+wsBwIUW4ccmzXL+bCXZ15f0Ans6tI
 MA/wb9CzuWGjB+fLciNnWbc+3zrjXzc6t7xYHbgBn+2shcFHYcUjdg98I2k0G+CnAWyryF7Qe
 rZQUpYFLq0AAujyjb7ZZOp1CG9wrGm0eV0Hzy5HuhJIgOiRfI3+qZ0bpGWuIlAadpf2hXJiuK
 B1jOs345xcAtPxFeO9N0JSZqVeakxEOMkPp91Aq35uZqhvKnSJxwxauKz/0GPo0FOE4xh08F1
 NHDYjfsclHchGoO2nZSMPRh/Ifi+nBrtkfqKXnnUOcD9Pk0BZxrii4DJ4YiYnw0pT3GTzZy5s
 JluY99sOphN+jhoGvqZk6tQQmID0Dp9LkZianuvzdlzY+NcX44f39mxAkR5iPcR596jCkOHnd
 UpP05q/Chula0EvxUZn06DL/cSpE/0ESUkFyWZnMcDebrF6dsEJkYL/tZJm4GFnkeNC6QnF3x
 Poi9P9jlgEEXnlMF+JR2OaBJdqo3wB3dsa4f9p33wxmSsOlfdunzy9kb0ahXWeVLt80lyXzuw
 drTZtriGw+BZRnnQYha2256qk3Wvt1sJB/wMkjg9PFTKG8rtYus0BLjmJ0zGWIESpoIklW0Ly
 i5G6/8tStG5RU7V35lvSkh4jC8G2aqQ5iOppe+oX24Xl18kSh3sbR6gMBi/al1nOTVlPlm/Ni
 mcMWsbYkYshMaRvZl2OwEDCW5o0cVsGjBC+y0g==
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

