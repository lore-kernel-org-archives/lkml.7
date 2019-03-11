Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B253FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794542184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfCKN2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:46 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfCKNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbc2-1hLyga2pZM-00L1Ox for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 038/114] arch: mips: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:50 +0100
Message-Id: <1552310346-7629-39-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:4jxTtnbVDfrLf6gUqm7M2H8Ik7c+5qQpRUH8lKdb3eJdHiw/ehl
 5jDHMhNV9k+1WRePOmk3UTwToIdEA+TnNK//+RBA24ykKP7UFwNcP+df051JlnJxFZxQ7IY
 HO6nM/gQPg8cG5xdt57kjhCW4nGHqAZ6wMAN48dqsvLaelco0X3euOchgyZ9jq1VNW5voM8
 4higDbi7VbI1QLpRfxMUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VlBy/jwlOGM=:ZqV4yjRUjaRBVLvrlP/uQ7
 v5/HsFUU51TDZ1smDuFbtO4m+sloZyqWyBMg1aovEj2XhiYup9b6SQ00h5y9JsfeyuO4ZB8T0
 lIshDn9/KmezCQ6SHz9W6IrBBblq3CdcXhOsLHIuGQkXZuZjvU3Bm6sYwhsQ9qZ5hf8Pc91kq
 f15PC+g5pSFHbw6kncMOfQ+XOkexY3AyJbqv96+1Rok6BhFOXKb+G8WixdGMQm6LJZWOLNc89
 5SEumQF9XGOPaUsXbg/U9IGCQU6XqAovnHS9dq6xm3bN5hH139AtYdfK5A/CP7c+e9lq1CCLu
 FRiVKhMI66/6bSBji40jbasQ7giZ3/5J11KiUlC6srfdEBJ/SAe4D3OXEFq26QYCk/3mBCGJe
 mMC2P6svXz41tXR3S+tqIYnmeQxb0TTssrAHjLNYnJ/pJe+BA5JN3sp/ZgNTl0TSX+XksJq7Y
 cfaBQghJnC6tB4MWZadQDccuAl+G1V39m3Chw8QtgmlIagg3RrxquOOyMyYbNbfv07jsFzwgu
 /GovhgSydjDOoLAFbLFmeKM7+N/X4k6T7TaKRTRHLxpZd7ZQA4cGUJZ0bgxLuEoY8hTNwpaRO
 rm2l8Twk3DETp0fY9s8Mw9Pey8U+VzSq/F/ohqaf7n36e8VxnmF6cPfBat3/eyPsBhSN7SVMs
 qCd7azOlCyr640+NX/nk1/GfhmH4jzbSXykgxouOJgbAb6h+TDXHeg6tlJ+lNdwHNkK3Rmwum
 Vql954WsvKz6H2Cjv2I1nf1jk9QEoT8b5j13UQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/mips/Kconfig                | 61 ++++++++++++++++++++--------------------
 arch/mips/bcm47xx/Kconfig        |  8 +++---
 arch/mips/bcm63xx/boards/Kconfig |  2 +-
 arch/mips/pic32/Kconfig          |  8 +++---
 4 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0..de67165 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -276,7 +276,7 @@ config BCM47XX
 	select BCM47XX_SPROM
 	select BCM47XX_SSB if !BCM47XX_BCMA
 	help
-	 Support for BCM47XX based boards
+	  Support for BCM47XX based boards
 
 config BCM63XX
 	bool "Broadcom BCM63XX based boards"
@@ -295,7 +295,7 @@ config BCM63XX
 	select MIPS_L1_CACHE_SHIFT_4
 	select CLKDEV_LOOKUP
 	help
-	 Support for BCM63XX based boards
+	  Support for BCM63XX based boards
 
 config MIPS_COBALT
 	bool "Cobalt Server"
@@ -374,10 +374,10 @@ config MACH_JAZZ
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_100HZ
 	help
-	 This a family of machines based on the MIPS R4030 chipset which was
-	 used by several vendors to build RISC/os and Windows NT workstations.
-	 Members include the Acer PICA, MIPS Magnum 4000, MIPS Millennium and
-	 Olivetti M700-10 workstations.
+	  This a family of machines based on the MIPS R4030 chipset which was
+	  used by several vendors to build RISC/os and Windows NT workstations.
+	  Members include the Acer PICA, MIPS Magnum 4000, MIPS Millennium and
+	  Olivetti M700-10 workstations.
 
 config MACH_INGENIC
 	bool "Ingenic SoC based machines"
@@ -573,14 +573,14 @@ config NXP_STB220
 	bool "NXP STB220 board"
 	select SOC_PNX833X
 	help
-	 Support for NXP Semiconductors STB220 Development Board.
+	  Support for NXP Semiconductors STB220 Development Board.
 
 config NXP_STB225
 	bool "NXP 225 board"
 	select SOC_PNX833X
 	select SOC_PNX8335
 	help
-	 Support for NXP Semiconductors STB225 Development Board.
+	  Support for NXP Semiconductors STB225 Development Board.
 
 config PMC_MSP
 	bool "PMC-Sierra MSP chipsets"
@@ -722,9 +722,9 @@ config SGI_IP28
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select MIPS_L1_CACHE_SHIFT_7
-      help
-        This is the SGI Indigo2 with R10000 processor.  To compile a Linux
-        kernel that runs on these, say Y here.
+	help
+	  This is the SGI Indigo2 with R10000 processor.  To compile a Linux
+	  kernel that runs on these, say Y here.
 
 config SGI_IP32
 	bool "SGI IP32 (O2)"
@@ -1175,9 +1175,9 @@ config HOLES_IN_ZONE
 config SYS_SUPPORTS_RELOCATABLE
 	bool
 	help
-	 Selected if the platform supports relocating the kernel.
-	 The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
-	 to allow access to command line and entropy sources.
+	  Selected if the platform supports relocating the kernel.
+	  The platform must provide plat_get_fdt() if it selects CONFIG_USE_OF
+	  to allow access to command line and entropy sources.
 
 config MIPS_CBPF_JIT
 	def_bool y
@@ -2120,8 +2120,8 @@ config MIPS_PGD_C0_CONTEXT
 # Set to y for ptrace access to watch registers.
 #
 config HARDWARE_WATCHPOINTS
-       bool
-       default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6
+	bool
+	default y if CPU_MIPSR1 || CPU_MIPSR2 || CPU_MIPSR6
 
 menu "Kernel type"
 
@@ -2185,10 +2185,10 @@ config PAGE_SIZE_4KB
 	bool "4kB"
 	depends on !CPU_LOONGSON2 && !CPU_LOONGSON3
 	help
-	 This option select the standard 4kB Linux page size.  On some
-	 R3000-family processors this is the only available page size.  Using
-	 4kB page size will minimize memory consumption and is therefore
-	 recommended for low memory systems.
+	  This option select the standard 4kB Linux page size.  On some
+	  R3000-family processors this is the only available page size.  Using
+	  4kB page size will minimize memory consumption and is therefore
+	  recommended for low memory systems.
 
 config PAGE_SIZE_8KB
 	bool "8kB"
@@ -2481,7 +2481,6 @@ config SB1_PASS_2_1_WORKAROUNDS
 	depends on CPU_SB1 && CPU_SB1_PASS_2
 	default y
 
-
 choice
 	prompt "SmartMIPS or microMIPS ASE support"
 
@@ -2689,16 +2688,16 @@ config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image"
 	depends on RELOCATABLE
 	---help---
-	   Randomizes the physical and virtual address at which the
-	   kernel image is loaded, as a security feature that
-	   deters exploit attempts relying on knowledge of the location
-	   of kernel internals.
+	  Randomizes the physical and virtual address at which the
+	  kernel image is loaded, as a security feature that
+	  deters exploit attempts relying on knowledge of the location
+	  of kernel internals.
 
-	   Entropy is generated using any coprocessor 0 registers available.
+	  Entropy is generated using any coprocessor 0 registers available.
 
-	   The kernel will be offset by up to RANDOMIZE_BASE_MAX_OFFSET.
+	  The kernel will be offset by up to RANDOMIZE_BASE_MAX_OFFSET.
 
-	   If unsure, say N.
+	  If unsure, say N.
 
 config RANDOMIZE_BASE_MAX_OFFSET
 	hex "Maximum kASLR offset" if EXPERT
@@ -2828,7 +2827,7 @@ choice
 	prompt "Timer frequency"
 	default HZ_250
 	help
-	 Allows the configuration of the timer frequency.
+	  Allows the configuration of the timer frequency.
 
 	config HZ_24
 		bool "24 HZ" if SYS_SUPPORTS_24HZ || SYS_SUPPORTS_ARBIT_HZ
@@ -3128,10 +3127,10 @@ config ARCH_MMAP_RND_BITS_MAX
 	default 15
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
-       default 8
+	default 8
 
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
-       default 15
+	default 15
 
 config I8253
 	bool
diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 2947103..6889f74 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -15,9 +15,9 @@ config BCM47XX_SSB
 	select SSB_DRIVER_GPIO
 	default y
 	help
-	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
+	  Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
 
-	 This will generate an image with support for SSB and MIPS32 R1 instruction set.
+	  This will generate an image with support for SSB and MIPS32 R1 instruction set.
 
 config BCM47XX_BCMA
 	bool "BCMA Support for Broadcom BCM47XX"
@@ -31,8 +31,8 @@ config BCM47XX_BCMA
 	select BCMA_DRIVER_GPIO
 	default y
 	help
-	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
+	  Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
 
-	 This will generate an image with support for BCMA and MIPS32 R2 instruction set.
+	  This will generate an image with support for BCMA and MIPS32 R2 instruction set.
 
 endif
diff --git a/arch/mips/bcm63xx/boards/Kconfig b/arch/mips/bcm63xx/boards/Kconfig
index f60d966..492c3bd 100644
--- a/arch/mips/bcm63xx/boards/Kconfig
+++ b/arch/mips/bcm63xx/boards/Kconfig
@@ -5,7 +5,7 @@ choice
 	default BOARD_BCM963XX
 
 config BOARD_BCM963XX
-       bool "Generic Broadcom 963xx boards"
+	bool "Generic Broadcom 963xx boards"
 	select SSB
 
 endchoice
diff --git a/arch/mips/pic32/Kconfig b/arch/mips/pic32/Kconfig
index e284e89..7acbb50 100644
--- a/arch/mips/pic32/Kconfig
+++ b/arch/mips/pic32/Kconfig
@@ -39,12 +39,12 @@ choice
 	  Select the devicetree.
 
 config DTB_PIC32_NONE
-       bool "None"
+	bool "None"
 
 config DTB_PIC32_MZDA_SK
-       bool "PIC32MZDA Starter Kit"
-       depends on PIC32MZDA
-       select BUILTIN_DTB
+	bool "PIC32MZDA Starter Kit"
+	depends on PIC32MZDA
+	select BUILTIN_DTB
 
 endchoice
 
-- 
1.9.1

