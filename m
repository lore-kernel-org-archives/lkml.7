Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAA9208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306468;
	bh=fwlpMajiWDAf3vBnnuBrL+s1Cn+tsLMw1vyP9IajspA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dcZLc4Rn5KgzNqKXsiebRHdmO+DHPbtLDaCFlSQlQ33UwGWOTmSYdf3SLwYffnKcD
	 EE7fVNfSvn0bdnznowxuMmNMp4hiQkDXx6nXG3F0YUuR0iVqqAxbO77zpVY0upiCmN
	 +677qpClfeJC+zoyMhT+7MEX2Oq1p0tRl3rCfXXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKUDVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKUDVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:21:05 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33DF20B7C;
        Thu, 21 Nov 2019 03:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306465;
        bh=fwlpMajiWDAf3vBnnuBrL+s1Cn+tsLMw1vyP9IajspA=;
        h=From:To:Cc:Subject:Date:From;
        b=ERy4uiiEOU9ECuxAVGXidWH+RnFh1E5LjcGvMpGG4nqEPPZ3+SiOJIUesaoHLhizX
         KHPCMRDLkEnwElwsoVy4ufuuJzCzk76rkq/zDzhaxtIET39qhxuoEG3JcPx/Dd5ygc
         eA8qRg+fN2dj1ZMuCwGb8EF+PAQqSOuIMtq2LGDc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:21:01 +0100
Message-Id: <1574306461-7646-1-git-send-email-krzk@kernel.org>
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
 arch/powerpc/Kconfig.debug             | 18 +++++++++---------
 arch/powerpc/platforms/Kconfig.cputype | 10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index c59920920ddc..4e1d39847462 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -122,8 +122,8 @@ config XMON_DEFAULT_RO_MODE
 	depends on XMON
 	default y
 	help
-          Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
-          'xmon=ro' override this default.
+	  Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
+	  'xmon=ro' override this default.
 
 config DEBUGGER
 	bool
@@ -222,7 +222,7 @@ config PPC_EARLY_DEBUG_44x
 	help
 	  Select this to enable early debugging for IBM 44x chips via the
 	  inbuilt serial port.  If you enable this, ensure you set
-          PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
+	  PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
 
 config PPC_EARLY_DEBUG_40x
 	bool "Early serial debugging for IBM/AMCC 40x CPUs"
@@ -325,7 +325,7 @@ config PPC_EARLY_DEBUG_44x_PHYSLOW
 	default "0x40000200"
 	help
 	  You probably want 0x40000200 for ebony boards and
-          0x40000300 for taishan
+	  0x40000300 for taishan
 
 config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	hex "EPRN of early debug UART physical address"
@@ -359,9 +359,9 @@ config FAIL_IOMMU
 	  If you are unsure, say N.
 
 config PPC_PTDUMP
-        bool "Export kernel pagetable layout to userspace via debugfs"
-        depends on DEBUG_KERNEL && DEBUG_FS
-        help
+	bool "Export kernel pagetable layout to userspace via debugfs"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
 	  This option exports the state of the kernel pagetables to a
 	  debugfs file. This is only useful for kernel developers who are
 	  working in architecture specific areas of the kernel - probably
@@ -390,8 +390,8 @@ config PPC_DEBUG_WX
 
 config PPC_FAST_ENDIAN_SWITCH
 	bool "Deprecated fast endian-switch syscall"
-        depends on DEBUG_KERNEL && PPC_BOOK3S_64
-        help
+	depends on DEBUG_KERNEL && PPC_BOOK3S_64
+	help
 	  If you're unsure what this is, say N.
 
 config KASAN_SHADOW_OFFSET
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 303752f97c19..8d7f9c3dc771 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -415,13 +415,13 @@ config PPC_MM_SLICES
 	bool
 
 config PPC_HAVE_PMU_SUPPORT
-       bool
+	bool
 
 config PPC_PERF_CTRS
-       def_bool y
-       depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
-       help
-         This enables the powerpc-specific perf_event back-end.
+	def_bool y
+	depends on PERF_EVENTS && PPC_HAVE_PMU_SUPPORT
+	help
+	 This enables the powerpc-specific perf_event back-end.
 
 config FORCE_SMP
 	# Allow platforms to force SMP=y by selecting this
-- 
2.7.4

