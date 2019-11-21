Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF11AC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23EB214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306429;
	bh=ICtU3L2SGCxL5d13ilpqPvEB+MBDUd3UY3pWS7CJXr8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fhnG0M0BLCainEGaCh+NglQRBLJCkCOluV7zCwXZJv554IT+77leeJDVtyz9QhjU0
	 B4sW3SDJm+fof6vqmUG7ARzZf+aUmioXB5r/TU+Jk8oNptOLmqKsrldqcPPDAILWgr
	 apqG+OET7aCGcFYylBitZctoqaUI55zCVKNsbtPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfKUDU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfKUDUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:25 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B19208CC;
        Thu, 21 Nov 2019 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306424;
        bh=ICtU3L2SGCxL5d13ilpqPvEB+MBDUd3UY3pWS7CJXr8=;
        h=From:To:Cc:Subject:Date:From;
        b=Qfh0BrqgN2Sy9wxcIiZHCkTPtNpWZNn7gC6G3huJi7Rk/QV/pi+qc4faZ1ocDVp8C
         A8vqTqeBi8mhKLq8xB0nWzTcg6ULzkWJImhdDHyT9GrXu5vNPaaVfoOveJmnvrDgCS
         WUKeWg1tY95otr4qGw7m2TNN+/9lZ6k5V73nAXT0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH v2] arm64: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:20 +0100
Message-Id: <1574306420-23985-1-git-send-email-krzk@kernel.org>
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
 arch/arm64/Kconfig     | 42 +++++++++++++++++++++---------------------
 arch/arm64/kvm/Kconfig |  2 +-
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4d6d8d6b6c4..d31bf024830f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -209,31 +209,31 @@ config ARM64_CONT_SHIFT
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
@@ -263,7 +263,7 @@ config GENERIC_HWEIGHT
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
@@ -886,8 +886,8 @@ choice
 	  that is selected here.
 
 config CPU_BIG_ENDIAN
-       bool "Build big-endian kernel"
-       help
+	bool "Build big-endian kernel"
+	help
 	  Say Y if you plan on running a kernel with a big-endian userspace.
 
 config CPU_LITTLE_ENDIAN
@@ -1670,7 +1670,7 @@ config EFI
 	help
 	  This option provides support for runtime services provided
 	  by UEFI firmware (such as non-volatile variables, realtime
-          clock, and platform reset). A UEFI stub is also provided to
+	  clock, and platform reset). A UEFI stub is also provided to
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a475c68cbfec..1b10785bc75a 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -62,7 +62,7 @@ config KVM_ARM_PMU
 	  virtual machines.
 
 config KVM_INDIRECT_VECTORS
-       def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
+	def_bool KVM && (HARDEN_BRANCH_PREDICTOR || HARDEN_EL2_VECTORS)
 
 source "drivers/vhost/Kconfig"
 
-- 
2.7.4

