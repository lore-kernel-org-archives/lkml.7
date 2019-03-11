Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DD52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfCKN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:28:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbfCKNTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:34 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mg6mG-1gZG1K1sic-00hcUn for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 036/114] arch: amd64: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:48 +0100
Message-Id: <1552310346-7629-37-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:aIka6Oue/rIm5Lf8Zfz2LaJiMMFpgggcfdzs+8XlJfi/StmQpJM
 Fi5srHyov7abqzannYeR5kJ6C9gvRTCA6BCuFCvH2XRiF3ph71a/klkeBaKEaH9AnlCPwzd
 eA50qSlB0whHKxzhoGFN23adu8Oky3IYfXgO0lHN0Weo125Vv5f27FrYToNgJMO0FPNtndU
 bmkvcwFsYBXlN4mhBF2qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/1BjP6aYM8=:grCDGzFjuyCdFJ5bcZKKv9
 OKnQ7O4D69OI3khuOs7jqPz1FIbfSU1xneadXHGlb5j7HiKWrcjBR1KM+yXC+Tm103Voif3M5
 k/gzXL0SeieAKQkoVf4WzrI0utF/h/pUXHeD3x+QXpjorSoiH9Ul1TwTHm6bg52MXHcNBY6cP
 f02o/FSzVivpiDR+k7s7oxRIkXOI3pD4QACDvRGSxECtlHp7cjNtMJKT6tfq08n6wB4rS9Kfw
 zHH9JyK1n7SpU1QkA0CGjFBUZQ2gjdtRPC+qJqEJAhvgcecjuGhHTGu0ZizvaLVIXdW/89eYM
 fdQnGfvXjGVhhrXoYjgGTvN2Fc5Nlu5Jabz/G2fHLRrZg01E8OPOwfBO/0HoplY5rVrLfDcV8
 l3/nuNIvqiUnnG/LVpEitwY22biCC8mvwDPv+Or6m5ZYBOtse4oPNLYSivCN7udQ44zL3FPQJ
 QQRx8w1wybUr4rG2jxbirNip709fXweV7Rpr2lfYOrpNyp7dKmGFYgdTLNEqIOsUx+wy7dvA6
 +nAanz1vLHXcgxVWm8XnFNjaTrNna6i2NB+M3asQ6qw/e/nrycL1oFC9Vf1UQmNh4h73NT1kI
 oi4yhHzkW883HldVP0oKQHMvlTS95JJYp4wj7Oa1X5r0yYNdAUBpz3Ar+qapJmXAEmG4OiZsJ
 Sjd6Ni63Vqqpe6XaFS/HormOC5RsYKi7XXTwiTBcmgXPGZlbuENycye1UZEOrb4XFAZHUPKKP
 GvNuntOj4qMIBJyoVpyofTC+s/8JaNppnzYzaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arm64/Kconfig     | 58 +++++++++++++++++++++++++-------------------------
 arch/arm64/kvm/Kconfig |  2 +-
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 117b254..e04923c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,31 +196,31 @@ config ARM64_CONT_SHIFT
 	default 4
 
 config ARCH_MMAP_RND_BITS_MIN
-       default 14 if ARM64_64K_PAGES
-       default 16 if ARM64_16K_PAGES
-       default 18
+	default 14 if ARM64_64K_PAGES
+	default 16 if ARM64_16K_PAGES
+	default 18
 
 # max bits determined by the following formula:
 #  VA_BITS - PAGE_SHIFT - 3
 config ARCH_MMAP_RND_BITS_MAX
-       default 19 if ARM64_VA_BITS=36
-       default 24 if ARM64_VA_BITS=39
-       default 27 if ARM64_VA_BITS=42
-       default 30 if ARM64_VA_BITS=47
-       default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
-       default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
-       default 33 if ARM64_VA_BITS=48
-       default 14 if ARM64_64K_PAGES
-       default 16 if ARM64_16K_PAGES
-       default 18
+	default 19 if ARM64_VA_BITS=36
+	default 24 if ARM64_VA_BITS=39
+	default 27 if ARM64_VA_BITS=42
+	default 30 if ARM64_VA_BITS=47
+	default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
+	default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
+	default 33 if ARM64_VA_BITS=48
+	default 14 if ARM64_64K_PAGES
+	default 16 if ARM64_16K_PAGES
+	default 18
 
 config ARCH_MMAP_RND_COMPAT_BITS_MIN
-       default 7 if ARM64_64K_PAGES
-       default 9 if ARM64_16K_PAGES
-       default 11
+	default 7 if ARM64_64K_PAGES
+	default 9 if ARM64_16K_PAGES
+	default 11
 
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
-       default 16
+	default 16
 
 config NO_IOPORT_MAP
 	def_bool y if !PCI
@@ -253,7 +253,7 @@ config GENERIC_HWEIGHT
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
@@ -790,9 +790,9 @@ config ARM64_PA_BITS
 	default 52 if ARM64_PA_BITS_52
 
 config CPU_BIG_ENDIAN
-       bool "Build big-endian kernel"
-       help
-         Say Y if you plan on running a kernel in big-endian mode.
+	bool "Build big-endian kernel"
+	help
+	  Say Y if you plan on running a kernel in big-endian mode.
 
 config SCHED_MC
 	bool "Multi-core scheduler support"
@@ -1178,15 +1178,15 @@ config ARM64_PAN
 	bool "Enable support for Privileged Access Never (PAN)"
 	default y
 	help
-	 Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
-	 prevents the kernel or hypervisor from accessing user-space (EL0)
-	 memory directly.
+	  Privileged Access Never (PAN; part of the ARMv8.1 Extensions)
+	  prevents the kernel or hypervisor from accessing user-space (EL0)
+	  memory directly.
 
-	 Choosing this option will cause any unprotected (not using
-	 copy_to_user et al) memory access to fail with a permission fault.
+	  Choosing this option will cause any unprotected (not using
+	  copy_to_user et al) memory access to fail with a permission fault.
 
-	 The feature is detected at runtime, and will remain as a 'nop'
-	 instruction if the cpu does not implement the feature.
+	  The feature is detected at runtime, and will remain as a 'nop'
+	  instruction if the cpu does not implement the feature.
 
 config ARM64_LSE_ATOMICS
 	bool "Atomic instructions"
@@ -1459,7 +1459,7 @@ config EFI
 	help
 	  This option provides support for runtime services provided
 	  by UEFI firmware (such as non-volatile variables, realtime
-          clock, and platform reset). A UEFI stub is also provided to
+	  clock, and platform reset). A UEFI stub is also provided to
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a3f8562..164e463 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -59,7 +59,7 @@ config KVM_ARM_PMU
 	  virtual machines.
 
 config KVM_INDIRECT_VECTORS
-       def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
+	def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
 
 source "drivers/vhost/Kconfig"
 
-- 
1.9.1

