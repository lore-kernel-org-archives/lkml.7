Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C620828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfLJSB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:01:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41547 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfLJSB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:01:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iejpT-0007Na-K6; Tue, 10 Dec 2019 19:01:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23F3D1C290C;
        Tue, 10 Dec 2019 19:01:47 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:01:46 -0000
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Fix Kconfig indentation
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1574306470-10305-1-git-send-email-krzk@kernel.org>
References: <1574306470-10305-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Message-ID: <157600090696.30329.14792453915019294290.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b03b016fe54edd1b527d749e139b2fc9407ac414
Gitweb:        https://git.kernel.org/tip/b03b016fe54edd1b527d749e139b2fc9407ac414
Author:        Krzysztof Kozlowski <krzk@kernel.org>
AuthorDate:    Thu, 21 Nov 2019 04:21:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 10 Dec 2019 18:43:21 +01:00

x86/Kconfig: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:

$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/1574306470-10305-1-git-send-email-krzk@kernel.org
---
 arch/x86/Kconfig     | 68 +++++++++++++++++++++----------------------
 arch/x86/xen/Kconfig |  8 ++---
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..d7bbed5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -439,8 +439,8 @@ config X86_MPPARSE
 	  (esp with 64bit cpus) with acpi support, MADT and DSDT will override it
 
 config GOLDFISH
-       def_bool y
-       depends on X86_GOLDFISH
+	def_bool y
+	depends on X86_GOLDFISH
 
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
@@ -561,9 +561,9 @@ config X86_UV
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
@@ -806,9 +806,9 @@ config KVM_GUEST
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
@@ -887,16 +887,16 @@ config HPET_EMULATE_RTC
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
@@ -1035,8 +1035,8 @@ config SCHED_MC_PRIO
 	  If unsure say Y here.
 
 config UP_LATE_INIT
-       def_bool y
-       depends on !SMP && X86_LOCAL_APIC
+	def_bool y
+	depends on !SMP && X86_LOCAL_APIC
 
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
@@ -1185,8 +1185,8 @@ config X86_LEGACY_VM86
 	  If unsure, say N here.
 
 config VM86
-       bool
-       default X86_LEGACY_VM86
+	bool
+	default X86_LEGACY_VM86
 
 config X86_16BIT
 	bool "Enable support for 16-bit segments" if EXPERT
@@ -1207,10 +1207,10 @@ config X86_ESPFIX64
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
@@ -1648,9 +1648,9 @@ config ARCH_PROC_KCORE_TEXT
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
@@ -1991,11 +1991,11 @@ config EFI
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
index ba5a418..1aded63 100644
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
