Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB6C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F65A2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306397;
	bh=wzYCZfJ/OBs2FZPR/b3ZOr0+bvljs7kYVUGM40zxFhw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=amr4lRZ6qOmnqCXN7WVg3JG2NibWRXD2U7yyrjkNy4DR68zvNiaPn+tQZQa7qVSLl
	 2/LFbqLbGobQAZsUqDszGeNcvwHZsrX6Wr5VOKpt+OBgL+zmYsH7+Q05HBSldmoG6j
	 DUWul3Dxz5rE/59xfay6fLrV4rJZ3uUqDGGPY+Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKUDT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKUDTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:19:55 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5609F20721;
        Thu, 21 Nov 2019 03:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306394;
        bh=wzYCZfJ/OBs2FZPR/b3ZOr0+bvljs7kYVUGM40zxFhw=;
        h=From:To:Cc:Subject:Date:From;
        b=J++5Z/ze24PaSYJhFXl6Z1QBcxgHpn5Tre8hvHLNjLzw/gz8mVvzqmWeSoHeh10ru
         qOaSuGioG+qx3WB0V4WuLuupT/sbZZs8VOsJpt23etiDsvc0GZjHjzWcEB65Yjsb9q
         ZammvUN4aG7DWmL3LyQ1pNykZ/0M1/cW5+8S1I8w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:19:51 +0100
Message-Id: <1574306391-10337-1-git-send-email-krzk@kernel.org>
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
 drivers/perf/Kconfig | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 09ae8a970880..b35314bec985 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -54,13 +54,13 @@ config ARM_PMU_ACPI
 	def_bool y
 
 config ARM_SMMU_V3_PMU
-	 tristate "ARM SMMUv3 Performance Monitors Extension"
-	 depends on ARM64 && ACPI && ARM_SMMU_V3
-	   help
-	   Provides support for the ARM SMMUv3 Performance Monitor Counter
-	   Groups (PMCG), which provide monitoring of transactions passing
-	   through the SMMU and allow the resulting information to be filtered
-	   based on the Stream ID of the corresponding master.
+	tristate "ARM SMMUv3 Performance Monitors Extension"
+	depends on ARM64 && ACPI && ARM_SMMU_V3
+	  help
+	  Provides support for the ARM SMMUv3 Performance Monitor Counter
+	  Groups (PMCG), which provide monitoring of transactions passing
+	  through the SMMU and allow the resulting information to be filtered
+	  based on the Stream ID of the corresponding master.
 
 config ARM_DSU_PMU
 	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
@@ -80,11 +80,11 @@ config FSL_IMX8_DDR_PMU
 	  events.
 
 config HISI_PMU
-       bool "HiSilicon SoC PMU"
-       depends on ARM64 && ACPI
-       help
-         Support for HiSilicon SoC uncore performance monitoring
-         unit (PMU), such as: L3C, HHA and DDRC.
+	bool "HiSilicon SoC PMU"
+	depends on ARM64 && ACPI
+	help
+	  Support for HiSilicon SoC uncore performance monitoring
+	  unit (PMU), such as: L3C, HHA and DDRC.
 
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
@@ -115,11 +115,11 @@ config THUNDERX2_PMU
 	   in the DDR4 Memory Controller (DMC).
 
 config XGENE_PMU
-        depends on ARCH_XGENE
-        bool "APM X-Gene SoC PMU"
-        default n
-        help
-          Say y if you want to use APM X-Gene SoC performance monitors.
+	depends on ARCH_XGENE
+	bool "APM X-Gene SoC PMU"
+	default n
+	help
+	  Say y if you want to use APM X-Gene SoC performance monitors.
 
 config ARM_SPE_PMU
 	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
-- 
2.7.4

