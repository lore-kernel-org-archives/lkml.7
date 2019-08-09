Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C887DC32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52D62171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 11:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406526AbfHILDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 07:03:37 -0400
Received: from foss.arm.com ([217.140.110.172]:45624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406445AbfHILDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 07:03:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6EE15AB;
        Fri,  9 Aug 2019 04:03:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8CD73F575;
        Fri,  9 Aug 2019 04:03:33 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 8/8] ARM: imx_v6_v7_defconfig: Enable the PSCI CPUidle driver
Date:   Fri,  9 Aug 2019 12:03:14 +0100
Message-Id: <7c275b0733141e09a7c783efabad1ef45dcfe58c.1565348376.git.lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565348376.git.lorenzo.pieralisi@arm.com>
References: <20190722153745.32446-1-lorenzo.pieralisi@arm.com> <cover.1565348376.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PSCI CPUidle driver to replace the functionality
previously provided by the generic ARM CPUidle driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index a53b29251ed4..4174fd1b79e7 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -60,6 +60,7 @@ CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
+CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_DEBUG=y
-- 
2.21.0

