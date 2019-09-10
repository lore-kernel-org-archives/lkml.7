Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83186C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596BB20863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbfIJNhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 09:37:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:40813 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfIJNhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 09:37:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 06:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="189345404"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2019 06:37:52 -0700
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        olof@lixom.net, mripard@kernel.org, bjorn.andersson@linaro.org,
        arnd@arndb.de, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] arm64: defconfig: enable rsu driver
Date:   Tue, 10 Sep 2019 08:49:46 -0500
Message-Id: <1568123386-530-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Enable Intel Stratix10 Remote System Update (RSU) driver

The Intel Remote System Update (RSU) driver provides a way for customers
to update the boot configuration of a Intel Stratix 10 SoC device with
significantly reduced risk of corrupting the bitstream storage and
bricking the system.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8c7b664..7325115 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -90,6 +90,7 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
+CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
-- 
2.7.4

