Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CA5C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB062799A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="WcIvSSlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfFCBFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:05:11 -0400
Received: from onstation.org ([52.200.56.107]:57750 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfFCBFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:05:07 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 28C293E917;
        Mon,  3 Jun 2019 01:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1559523906;
        bh=f5ufiraj1tVlQYSRkabyq0re0Yb8FrTeaMF6chCEqeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WcIvSSlmboU/L5lvCKn6rtjeztsqP8arSNxATzuL54sVPjo5oME5Lcm1ui2a0brdW
         2nxEUDH3H4pFjQcP+VrESWySa0ENV4LpgBMFDscXIsHdRp2PHQSqaU2PQiS7R4vb8e
         pui51mH6Z4wlP/bWbcPha0dgthbIXr1YnlKih/ZY=
From:   Brian Masney <masneyb@onstation.org>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linus.walleij@linaro.org, frank.rowand@sony.com,
        miquel.raynal@bootlin.com, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: qcom_defconfig: add support for USB networking
Date:   Sun,  2 Jun 2019 21:04:55 -0400
Message-Id: <20190603010455.17060-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603010455.17060-1-masneyb@onstation.org>
References: <20190603010455.17060-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for USB networking as a module to qcom_defconfig since its
a useful feature to have for development purposes.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
This is to be applied on top of the display patch series:
https://lore.kernel.org/lkml/20190531094619.31704-1-masneyb@onstation.org/

 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 4f02636f832e..f26103eae564 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -186,6 +186,7 @@ CONFIG_USB_CONFIGFS_NCM=y
 CONFIG_USB_CONFIGFS_ECM=y
 CONFIG_USB_CONFIGFS_F_FS=y
 CONFIG_USB_ULPI_BUS=y
+CONFIG_USB_ETH=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
-- 
2.20.1

