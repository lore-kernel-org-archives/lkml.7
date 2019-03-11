Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfCKN1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:25 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:38979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqrsF-1ghjWx1yeP-00mp9W for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 052/114] arch: x86: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:04 +0100
Message-Id: <1552310346-7629-53-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:zX+BlNS5+/iFVJnA1X3ogVIA5Dzw/46LgSaIm5Z02VGx7YX0tKL
 oCwmR+hcrlEn1Hd8uhVOVpysrBndn84c7vmVcr6cIv5G9cyfJM98UCRXQQwUY2S9JuHWQNV
 OdWrBrqUKu4tbfmESJlB2q0cr98wbawuloyQZs0SdgdXRIpiCJmht4geCey/koyIa3YG+8E
 if1T2948HTyG5ueuV/E5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:24S72Vw/9pM=:64AL8OHoUvIiCxZ95+GEu0
 zX60iQVrlzMEYW7zaHA5mPT6Iqimzoo+ik9py0vunt+RX5MVk4wArX+04ATaHVQsPBZ3X4RTW
 hC3DIlf8kTAiOnhlcYfgwJgqHOM+JgCfb7byPhzuYRD2xLH+bFvg/VD6Imc9spO3Ew7+3EDaR
 R/AJDp2wbvRtEVUqlIkdiVOzBDxsAd8EOBLNQfJZuSxPLXdFQQGzUkjoQnKqCvKOQvWitRbGr
 VqFwIysW+nedaoZz43uuZNUzxygyYf0xc9zKdmOk5W9NK0tYxb0K3Ix35xo72E7M5eUEiJt2Y
 Qip4RbAs7fw3UB6eNBP3cXvFJNpmFQR/5TUJ8wq1mZ6yi7aJLJu+8+Rhwj5mqEB2BoJyc3QCt
 bpr96Xf0ChDg6u2ggnnUJMCE0dQ4cu71rBQ8HdRsYxE+kofKLNHIC1lXogXiSpHKHFM0CV2Mz
 4X1aiG/219C1xuOPLtMpGfNUZXM7KVxJH3KoePka87HFIff3dQKLVAVZ2RFEkTO+/m/eo9lwo
 hudGQpn0y9ZI6yYeO1qmSzPga/Oevd7U+fetDBojg3/uf36FDam7Vz9elOOllpD1klBESq2zG
 PnCerLI8SSX200xEFUJLu/gt0r3YRWD5qx4VPO77I9ZjyNCA9D8/3igj5sSOeJJqQhWTyftKv
 A//V5wWr7T372+3dATtL4l5Gjmz+NIBVa2XWSq3Ks28u3DiMUKvQcTVpvOJ+tFThLNyPcATGZ
 4DSahlLWqCnxXlXCOuQtA9tdT9WWVQWqlr9cYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/x86/Kconfig     | 140 +++++++++++++++++++++++++--------------------------
 arch/x86/kvm/Kconfig |   4 +-
 arch/x86/xen/Kconfig |   8 +--
 3 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3c..3689662 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -432,8 +432,8 @@ config X86_MPPARSE
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
 config GOLDFISH
-       def_bool y
-       depends on X86_GOLDFISH
+	def_bool y
+	depends on X86_GOLDFISH
 
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
@@ -554,12 +554,12 @@ config X86_UV
 # Please maintain the alphabetic order if and when there are additions
 
 config X86_GOLDFISH
-       bool "Goldfish (Virtual Platform)"
-       depends on X86_EXTENDED_PLATFORM
-       ---help---
-	 Enable support for the Goldfish virtual platform used primarily
-	 for Android development. Unless you are building for the Android
-	 Goldfish emulator say N here.
+	bool "Goldfish (Virtual Platform)"
+	depends on X86_EXTENDED_PLATFORM
+	---help---
+	  Enable support for the Goldfish virtual platform used primarily
+	  for Android development. Unless you are building for the Android
+	  Goldfish emulator say N here.
 
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
@@ -870,16 +870,16 @@ config HPET_EMULATE_RTC
 	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
 config APB_TIMER
-       def_bool y if X86_INTEL_MID
-       prompt "Intel MID APB Timer Support" if X86_INTEL_MID
-       select DW_APB_TIMER
-       depends on X86_INTEL_MID && SFI
-       help
-         APB timer is the replacement for 8254, HPET on X86 MID platforms.
-         The APBT provides a stable time base on SMP
-         systems, unlike the TSC, but it is more expensive to access,
-         as it is off-chip. APB timers are always running regardless of CPU
-         C states, they are used as per CPU clockevent device when possible.
+	def_bool y if X86_INTEL_MID
+	prompt "Intel MID APB Timer Support" if X86_INTEL_MID
+	select DW_APB_TIMER
+	depends on X86_INTEL_MID && SFI
+	help
+	  APB timer is the replacement for 8254, HPET on X86 MID platforms.
+	  The APBT provides a stable time base on SMP
+	  systems, unlike the TSC, but it is more expensive to access,
+	  as it is off-chip. APB timers are always running regardless of CPU
+	  C states, they are used as per CPU clockevent device when possible.
 
 # Mark as expert because too many people got it wrong.
 # The code disables itself when not needed.
@@ -1048,8 +1048,8 @@ config SCHED_MC_PRIO
 	  If unsure say Y here.
 
 config UP_LATE_INIT
-       def_bool y
-       depends on !SMP && X86_LOCAL_APIC
+	def_bool y
+	depends on !SMP && X86_LOCAL_APIC
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
@@ -1133,16 +1133,16 @@ config X86_MCE_INTEL
 	prompt "Intel MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC
 	---help---
-	   Additional support for intel specific MCE features such as
-	   the thermal monitor.
+	  Additional support for intel specific MCE features such as
+	  the thermal monitor.
 
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
 	---help---
-	   Additional support for AMD specific MCE features such as
-	   the DRAM Error Threshold.
+	  Additional support for AMD specific MCE features such as
+	  the DRAM Error Threshold.
 
 config X86_ANCIENT_MCE
 	bool "Support for old Pentium 5 / WinChip machine checks"
@@ -1198,8 +1198,8 @@ config X86_LEGACY_VM86
 	  If unsure, say N here.
 
 config VM86
-       bool
-       default X86_LEGACY_VM86
+	bool
+	default X86_LEGACY_VM86
 
 config X86_16BIT
 	bool "Enable support for 16-bit segments" if EXPERT
@@ -1220,22 +1220,22 @@ config X86_ESPFIX64
 	depends on X86_16BIT && X86_64
 
 config X86_VSYSCALL_EMULATION
-       bool "Enable vsyscall emulation" if EXPERT
-       default y
-       depends on X86_64
-       ---help---
-	 This enables emulation of the legacy vsyscall page.  Disabling
-	 it is roughly equivalent to booting with vsyscall=none, except
-	 that it will also disable the helpful warning if a program
-	 tries to use a vsyscall.  With this option set to N, offending
-	 programs will just segfault, citing addresses of the form
-	 0xffffffffff600?00.
-
-	 This option is required by many programs built before 2013, and
-	 care should be used even with newer programs if set to N.
-
-	 Disabling this option saves about 7K of kernel size and
-	 possibly 4K of additional runtime pagetable memory.
+	bool "Enable vsyscall emulation" if EXPERT
+	default y
+	depends on X86_64
+	---help---
+	  This enables emulation of the legacy vsyscall page.  Disabling
+	  it is roughly equivalent to booting with vsyscall=none, except
+	  that it will also disable the helpful warning if a program
+	  tries to use a vsyscall.  With this option set to N, offending
+	  programs will just segfault, citing addresses of the form
+	  0xffffffffff600?00.
+
+	  This option is required by many programs built before 2013, and
+	  care should be used even with newer programs if set to N.
+
+	  Disabling this option saves about 7K of kernel size and
+	  possibly 4K of additional runtime pagetable memory.
 
 config TOSHIBA
 	tristate "Toshiba Laptop support"
@@ -1640,9 +1640,9 @@ config ARCH_PROC_KCORE_TEXT
 	depends on X86_64 && PROC_KCORE
 
 config ILLEGAL_POINTER_VALUE
-       hex
-       default 0 if X86_32
-       default 0xdead000000000000 if X86_64
+	hex
+	default 0 if X86_32
+	default 0xdead000000000000 if X86_64
 
 config X86_PMEM_LEGACY_DEVICE
 	bool
@@ -1938,11 +1938,11 @@ config EFI
 	  platforms.
 
 config EFI_STUB
-       bool "EFI stub support"
-       depends on EFI && !X86_USE_3DNOW
-       select RELOCATABLE
-       ---help---
-          This kernel feature allows a bzImage to be loaded directly
+	bool "EFI stub support"
+	depends on EFI && !X86_USE_3DNOW
+	select RELOCATABLE
+	---help---
+	  This kernel feature allows a bzImage to be loaded directly
 	  by EFI firmware without the use of a bootloader.
 
 	  See Documentation/efi-stub.txt for more information.
@@ -1951,15 +1951,15 @@ config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
 	---help---
-	   Enabling this feature allows a 64-bit kernel to be booted
-	   on a 32-bit firmware, provided that your CPU supports 64-bit
-	   mode.
+	  Enabling this feature allows a 64-bit kernel to be booted
+	  on a 32-bit firmware, provided that your CPU supports 64-bit
+	  mode.
 
-	   Note that it is not possible to boot a mixed-mode enabled
-	   kernel via the EFI boot stub - a bootloader that supports
-	   the EFI handover protocol must be used.
+	  Note that it is not possible to boot a mixed-mode enabled
+	  kernel via the EFI boot stub - a bootloader that supports
+	  the EFI handover protocol must be used.
 
-	   If unsure, say N.
+	  If unsure, say N.
 
 config SECCOMP
 	def_bool y
@@ -2190,16 +2190,16 @@ config RANDOMIZE_MEMORY
 	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	---help---
-	   Randomizes the base virtual address of kernel memory sections
-	   (physical memory mapping, vmalloc & vmemmap). This security feature
-	   makes exploits relying on predictable memory locations less reliable.
+	  Randomizes the base virtual address of kernel memory sections
+	  (physical memory mapping, vmalloc & vmemmap). This security feature
+	  makes exploits relying on predictable memory locations less reliable.
 
-	   The order of allocations remains unchanged. Entropy is generated in
-	   the same way as RANDOMIZE_BASE. Current implementation in the optimal
-	   configuration have in average 30,000 different possible virtual
-	   addresses for each memory section.
+	  The order of allocations remains unchanged. Entropy is generated in
+	  the same way as RANDOMIZE_BASE. Current implementation in the optimal
+	  configuration have in average 30,000 different possible virtual
+	  addresses for each memory section.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
@@ -2209,12 +2209,12 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	range 0x1 0x40 if MEMORY_HOTPLUG
 	range 0x0 0x40
 	---help---
-	   Define the padding in terabytes added to the existing physical
-	   memory size during kernel memory randomization. It is useful
-	   for memory hotplug support but reduces the entropy available for
-	   address randomization.
+	  Define the padding in terabytes added to the existing physical
+	  memory size during kernel memory randomization. It is useful
+	  for memory hotplug support but reduces the entropy available for
+	  address randomization.
 
-	   If unsure, leave at the default value.
+	  If unsure, leave at the default value.
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 72fa955..1405422 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -93,8 +93,8 @@ config KVM_MMU_AUDIT
 	bool "Audit KVM MMU"
 	depends on KVM && TRACEPOINTS
 	---help---
-	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
-	 auditing of KVM MMU events at runtime.
+	  This option adds a R/W kVM module parameter 'mmu_audit', which allows
+	  auditing of KVM MMU events at runtime.
 
 # OK, it's a little counter-intuitive to do this, but it puts it neatly under
 # the virtualization menu.
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index e07abef..a4c717a 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -61,10 +61,10 @@ config XEN_512GB
 	  boot parameter "xen_512gb_limit".
 
 config XEN_SAVE_RESTORE
-       bool
-       depends on XEN
-       select HIBERNATE_CALLBACKS
-       default y
+	bool
+	depends on XEN
+	select HIBERNATE_CALLBACKS
+	default y
 
 config XEN_DEBUG_FS
 	bool "Enable Xen debug and tuning parameters in debugfs"
-- 
1.9.1

