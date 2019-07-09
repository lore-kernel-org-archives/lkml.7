Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE08C606D7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C0B216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="rvUwayDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGIHes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:48 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61844 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGIHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656768; x=1565248768;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xqMLgEWD4pnHmhIMK3kiX0AvERv5gfUwO2HMQR7B+8o=;
        b=rvUwayDSg6Zqlc1ItCNk9SLvLYdFlgaQbjmLO/HMQhIJSlTY+TXwRQHNSmmyQASW
        RcCe9lOilMweF+2rnLFZ5z+yNiHnEUw8aIy9B6SNoyh6qStiCQDR3A00Lb8L0v5y
        qGb8NDoZJQW5xzmXlkhAU4FqwX8jTYeQjcuc856QUp4=;
X-AuditID: c39127d2-17dff70000001aee-01-5d244000f909
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 98.B0.06894.000442D5; Tue,  9 Jul 2019 09:19:28 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192779-309705 ;
          Tue, 9 Jul 2019 09:19:27 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 02/10] ARM: dts: imx6ul: segin: Add boot media to dts filename
Date:   Tue, 9 Jul 2019 09:19:19 +0200
Message-Id: <1562656767-273566-3-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize complete at 09.07.2019 09:19:28
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRoCBS5fBQSXW4OsSLov5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8aMrhcs
        Bdf4Kj7c38jYwHiYp4uRk0NCwERiwrPZbF2MXBxCAjsYJXZdWsEM4VxglHh+6SkbSBWbgJHE
        gmmNTCC2iECkxLvtv9lBipgF9jBKTLt+nREkISzgJ7FrcyM7iM0ioCKx5+MvZhCbV8BDYlPH
        HVaIdXISN891gsU5BTwljl6EqBECqrm8YBoLyFAJgUYmiSM/9zJCNAhJnF58lnkCI98CRoZV
        jEK5mcnZqUWZ2XoFGZUlqcl6KambGIGhenii+qUdjH1zPA4xMnEwHmKU4GBWEuHd564cK8Sb
        klhZlVqUH19UmpNafIhRmoNFSZx3A29JmJBAemJJanZqakFqEUyWiYNTqoFxytujW8I4/1y2
        79Wt35d5u2L1hF3mEvLHvlQfCuipeZl2KF7zUKlBdkiMz+3Sb8cPehwRaDJWaRI9Yi0p2un4
        Z1Et07p78X9MdHnaNso8Mmu9aWCwXODRLC0pu9xQxYkS10rdIzMjz12IDM9/JvnSae2Tw3/j
        vznknfFMvf7z3jYOpjV2V5YosRRnJBpqMRcVJwIACi+2tUMCAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now a PHYTEC phyCORE-i.MX 6UL with eMMC instead of NAND flash
available. The dts filename needs to reflect that to differentiate both.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/Makefile                                           | 2 +-
 ...l-phytec-segin-ff-rdk.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-phytec-segin-ff-rdk.dts => imx6ul-phytec-segin-ff-rdk-nand.dts} (85%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e1924b06f3cb..668b57c8cc57 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,7 +573,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-pico-pi.dtb \
-	imx6ul-phytec-segin-ff-rdk.dtb \
+	imx6ul-phytec-segin-ff-rdk-nand.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
similarity index 85%
rename from arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
rename to arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index 1e59183a2f7c..dc06029c5701 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -10,8 +10,9 @@
 #include "imx6ul-phytec-segin-peb-eval-01.dtsi"
 
 / {
-	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured";
-	compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
+	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured with NAND";
+	compatible = "phytec,imx6ul-pbacd10-nand", "phytec,imx6ul-pbacd10",
+		     "phytec,imx6ul-pcl063", "fsl,imx6ul";
 };
 
 &adc1 {
-- 
2.7.4

