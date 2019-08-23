Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09114C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7D6233FD
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbfHWKIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:08:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37206 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHWKH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:07:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB66F200724;
        Fri, 23 Aug 2019 12:07:55 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4C6A120070F;
        Fri, 23 Aug 2019 12:07:51 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1AC654031D;
        Fri, 23 Aug 2019 18:07:45 +0800 (SGT)
From:   Biwen Li <biwen.li@nxp.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: [3/3] rtc/fsl: support flextimer for SoC LS1021A (ARM32)
Date:   Fri, 23 Aug 2019 17:57:40 +0800
Message-Id: <20190823095740.12280-3-biwen.li@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190823095740.12280-1-biwen.li@nxp.com>
References: <20190823095740.12280-1-biwen.li@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support flextimer for SoC LS1021A (ARM32)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 319bec4bef05..58d8b5f7cfc5 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1324,7 +1324,7 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_FSL_FTM_ALARM
 	tristate "Freescale FlexTimer alarm timer"
-	depends on ARCH_LAYERSCAPE
+	depends on ARCH_LAYERSCAPE || SOC_LS1021A
 	select FSL_RCPM
 	default y
 	help
-- 
2.17.1

