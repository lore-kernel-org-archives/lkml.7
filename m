Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52611C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31220218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfJCLMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:12:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbfJCLMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:12:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3E251597;
        Thu,  3 Oct 2019 04:12:18 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3C843F706;
        Thu,  3 Oct 2019 04:12:17 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/4] docs/arm64: elf_hwcaps: sort the HWCAP{,2} documentation by ascending value
Date:   Thu,  3 Oct 2019 12:12:09 +0100
Message-Id: <20191003111211.483-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191003111211.483-1-julien.grall@arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the hardware capabilities documented in elf_hwcap.rst are
ordered following the definition in the header
arch/arm64/include/uapi/asm/hwcap.h but others seems to be documented
in random order.

To make easier to match against the definition in the header, they are
now sorted in the same order as they are defined in header. I.e.,
HWCAP first by ascending value, and then HWCAP2 in the similar fashion.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 Documentation/arm64/elf_hwcaps.rst | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 91f79529c58c..9ee7f8ff1fae 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -119,10 +119,6 @@ HWCAP_LRCPC
 HWCAP_DCPOP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0001.
 
-HWCAP2_DCPODP
-
-    Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
-
 HWCAP_SHA3
     Functionality implied by ID_AA64ISAR0_EL1.SHA3 == 0b0001.
 
@@ -141,30 +137,6 @@ HWCAP_SHA512
 HWCAP_SVE
     Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001.
 
-HWCAP2_SVE2
-
-    Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
-
-HWCAP2_SVEAES
-
-    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
-
-HWCAP2_SVEPMULL
-
-    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
-
-HWCAP2_SVEBITPERM
-
-    Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
-
-HWCAP2_SVESHA3
-
-    Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
-
-HWCAP2_SVESM4
-
-    Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
-
 HWCAP_ASIMDFHM
    Functionality implied by ID_AA64ISAR0_EL1.FHM == 0b0001.
 
@@ -180,10 +152,6 @@ HWCAP_ILRCPC
 HWCAP_FLAGM
     Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0001.
 
-HWCAP2_FLAGM2
-
-    Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
-
 HWCAP_SSBS
     Functionality implied by ID_AA64PFR1_EL1.SSBS == 0b0010.
 
@@ -197,6 +165,38 @@ HWCAP_PACG
     ID_AA64ISAR1_EL1.GPI == 0b0001, as described by
     Documentation/arm64/pointer-authentication.rst.
 
+HWCAP2_DCPODP
+
+    Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
+
+HWCAP2_SVE2
+
+    Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
+
+HWCAP2_SVEAES
+
+    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
+
+HWCAP2_SVEPMULL
+
+    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
+
+HWCAP2_SVEBITPERM
+
+    Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
+
+HWCAP2_SVESHA3
+
+    Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
+
+HWCAP2_SVESM4
+
+    Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
+
+HWCAP2_FLAGM2
+
+    Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
+
 HWCAP2_FRINT
 
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
-- 
2.11.0

