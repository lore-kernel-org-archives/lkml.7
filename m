Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AB722528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257239;
	bh=ifOgNdh00ND7dXzC5K+1c6kBHslLHjw9L3ly0yLdQmg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yr1A8zRso1g7OcVo9OeQay+hKQhmgmkxb+wCW3VkWg63PdaOFU1PRx5BkItQzmt5U
	 sD7tKK+6IpJKzw8TAxp7SW5BRCpXZ4B/3oAJn8Vbu7LHWZnqjG4ErE4pstGeLRMC0g
	 4zFLb9uuUk0FiwxZELJsLWYMAiHMY+AukYduO7Yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfKTNki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728864AbfKTNkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:36 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E452252C;
        Wed, 20 Nov 2019 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257235;
        bh=ifOgNdh00ND7dXzC5K+1c6kBHslLHjw9L3ly0yLdQmg=;
        h=From:To:Cc:Subject:Date:From;
        b=TcGMUrX086pvI471jULBm4JS4y2Lhy3ULi/tFNxSQY0G0X3ASsS2Gqr/Yqhfnuwvz
         xNW1kn1yHA3Q71uBgVgGxRfcaT2tFgt9IM7HbI39z/HUC4SpxPsoHGca/4H7wEhM2Q
         K9Hd9h0uq6Pd2OR3glycTpOxwABDxJgPfccjgk9Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:30 +0800
Message-Id: <20191120134031.14447-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/perf/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 09ae8a970880..288c1b3589e7 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -83,8 +83,8 @@ config HISI_PMU
        bool "HiSilicon SoC PMU"
        depends on ARM64 && ACPI
        help
-         Support for HiSilicon SoC uncore performance monitoring
-         unit (PMU), such as: L3C, HHA and DDRC.
+	 Support for HiSilicon SoC uncore performance monitoring
+	 unit (PMU), such as: L3C, HHA and DDRC.
 
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
2.17.1

