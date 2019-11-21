Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA15920B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306479;
	bh=b/fKcA2BZOQWpmYNOg0NJrK27935nnvcp0qmnXI4aK8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZUddyzU6Or6xuLbzFjtn//RiNJSj8cXctSp0yZCGduM7HWVwcagwyibP3wtfFoWl1
	 EhitInirri7YUNmCHk/djaK81IUHXuC0oMa/H9/Sm3kJ5ZoEHRaH7mja7lkkFLPUa0
	 l7DRylrmMPsuVN6HeCJkb5ZS+iiPYlM14XmS1dJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKUDVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfKUDVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:15 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29EB208C3;
        Thu, 21 Nov 2019 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306474;
        bh=b/fKcA2BZOQWpmYNOg0NJrK27935nnvcp0qmnXI4aK8=;
        h=From:To:Cc:Subject:Date:From;
        b=dwyNk24yy25liGBM1jHRAIosUmK+Hp8WJYbbjD+iNplKCQhTvBZCjj5P9paTBgBJN
         HgU14FOwrKLvO5i8SS/SdXSOMOpM1NR8YO2rdaxZvZG9q3ZvPRdE7JyeF8qzVNfDQw
         oRVLfKB9A3KJC3t4sQcRrS1MIj2S+EjmQ1BBEWv8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2] x86: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:21:09 +0100
Message-Id: <1574306470-10305-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 arch/x86/Kconfig     | 68 ++++++++++++++++++++++++++--------------------------
 arch/x86/xen/Kconfig |  8 +++----
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3fc6daff2109..1466c1b029e7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -442,8 +442,8 @@ config X86_MPPARSE
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
 config GOLDFISH
-       def_bool y
-       depends on X86_GOLDFISH
+	def_bool y
+	depends on X86_GOLDFISH
 
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
@@ -564,9 +564,9 @@ config X86_UV
 # Please maintain the alphabetic order if and when there are additions
 
 config X86_GOLDFISH
-       bool "Goldfish (Virtual Platform)"
-       depends on X86_EXTENDED_PLATFORM
-       ---help---
+	bool "Goldfish (Virtual Platform)"
+	depends on X86_EXTENDED_PLATFORM
+	---help---
 	 Enable support for the Goldfish virtual platform used primarily
 	 for Android development. Unless you are building for the Android
 	 Goldfish emulator say N here.
@@ -809,9 +809,9 @@ config KVM_GUEST
 	  timing infrastructure such as time of day, and system time
 
 config ARCH_CPUIDLE_HALTPOLL
-        def_bool n
-        prompt "Disable host haltpoll when loading haltpoll driver"
-        help
+	def_bool n
+	prompt "Disable host haltpoll when loading haltpoll driver"
+	help
 	  If virtualized under KVM, disable host haltpoll.
 
 config PVH
@@ -890,16 +890,16 @@ config HPET_EMULATE_RTC
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
+	 APB timer is the replacement for 8254, HPET on X86 MID platforms.
+	 The APBT provides a stable time base on SMP
+	 systems, unlike the TSC, but it is more expensive to access,
+	 as it is off-chip. APB timers are always running regardless of CPU
+	 C states, they are used as per CPU clockevent device when possible.
 
 # Mark as expert because too many people got it wrong.
 # The code disables itself when not needed.
@@ -1038,8 +1038,8 @@ config SCHED_MC_PRIO
 	  If unsure say Y here.
 
 config UP_LATE_INIT
-       def_bool y
-       depends on !SMP && X86_LOCAL_APIC
+	def_bool y
+	depends on !SMP && X86_LOCAL_APIC
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
@@ -1188,8 +1188,8 @@ config X86_LEGACY_VM86
 	  If unsure, say N here.
 
 config VM86
-       bool
-       default X86_LEGACY_VM86
+	bool
+	default X86_LEGACY_VM86
 
 config X86_16BIT
 	bool "Enable support for 16-bit segments" if EXPERT
@@ -1210,10 +1210,10 @@ config X86_ESPFIX64
 	depends on X86_16BIT && X86_64
 
 config X86_VSYSCALL_EMULATION
-       bool "Enable vsyscall emulation" if EXPERT
-       default y
-       depends on X86_64
-       ---help---
+	bool "Enable vsyscall emulation" if EXPERT
+	default y
+	depends on X86_64
+	---help---
 	 This enables emulation of the legacy vsyscall page.  Disabling
 	 it is roughly equivalent to booting with vsyscall=none, except
 	 that it will also disable the helpful warning if a program
@@ -1651,9 +1651,9 @@ config ARCH_PROC_KCORE_TEXT
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
@@ -1994,11 +1994,11 @@ config EFI
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
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index ba5a41828e9d..1aded63a95cb 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -62,10 +62,10 @@ config XEN_512GB
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
2.7.4

