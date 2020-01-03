Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31EC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D92222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578089167;
	bh=33FSSyCClAVDwBoEMgqsTHAhDrtOV5N4bwQ2g+qNkCY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xbxE0p2vPBlVXfeqOrnzS46FZd09kxAhhP/qk9rWpUHsqdTZly81c7mu9DBDGClvc
	 gu7ZgwkYoZKFWWdQ5SPX1eNzRsBxJzAJ1xrSXh1fukI38M7FfxKxGFu5It1YnuFOoo
	 GWglkEc0As3OPwbQ6qEyudD3Cg+mwIRZ7Iws/jZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgACWGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgACWGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:06:05 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A425206F0;
        Fri,  3 Jan 2020 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578089165;
        bh=33FSSyCClAVDwBoEMgqsTHAhDrtOV5N4bwQ2g+qNkCY=;
        h=From:To:Cc:Subject:Date:From;
        b=eyKl5vuccAYZFPs5lsytKY4Fz8jvmou/O2NWHMz4KnXzIL+7ze2SNuEnwkg7s7baf
         xNmr8BHD9fjB6L6aoAiU24hdLDs4UygriDvLAx/+0/MtyQzpOV1fJBTsK4tgYbyWwQ
         h5QaoTFqgjJmVYFzSrby6DxFhC/QaEDIlCbSuA0I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] soc: imx: Enable compile testing of IMX_SCU_SOC
Date:   Fri,  3 Jan 2020 23:05:57 +0100
Message-Id: <20200103220557.24812-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IMX_SCU_SOC can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 8aaebf13e2e6..0281ef9a1800 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -10,7 +10,7 @@ config IMX_GPCV2_PM_DOMAINS
 
 config IMX_SCU_SOC
 	bool "i.MX System Controller Unit SoC info support"
-	depends on IMX_SCU
+	depends on IMX_SCU || COMPILE_TEST
 	select SOC_BUS
 	help
 	  If you say yes here you get support for the NXP i.MX System
-- 
2.17.1

