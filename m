Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C680C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C2C21707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="MsJaBN8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGIHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:50 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61846 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656768; x=1565248768;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q9+l9nZByzaX+KgMAAJlCsUEhKypi72xbb0pMY2tm+Y=;
        b=MsJaBN8gs1mRjMqse84PL87RHPwX/5bZdX7IsIx4ZCckcG1Onh9nBhNUQW5XZfqm
        OmwZBDa2zEQ4qARJTF3dMM7uM2DuzM6U+eu0vgR8jkWiGa68wGVTGStWe/cyBZ3X
        ASmZV5oa7lSgJcJsX+6pVEw58BXpZEleeUHAdaR09zg=;
X-AuditID: c39127d2-193ff70000001aee-00-5d243fff74f1
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D7.B0.06894.FFF342D5; Tue,  9 Jul 2019 09:19:27 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192756-309704 ;
          Tue, 9 Jul 2019 09:19:27 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 01/10] ARM: dts: imx6ul: phyboard-segin: Rename dts to PHYTEC name scheme
Date:   Tue, 9 Jul 2019 09:19:18 +0200
Message-Id: <1562656767-273566-2-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:27,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:27,
        Serialize complete at 09.07.2019 09:19:27
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWyRoCBS/e/vUqswcpH1hbzj5xjtXh41d9i
        1dSdLBabHl9jtej6tZLZ4vKuOWwWS69fZLJ4cLGLxaJ17xF2i7/bN7FYvNgi7sDtsWbeGkaP
        HXeXMHrsnHWX3WPTqk42j81L6j02vtvB5NH/18Dj8ya5AI4oLpuU1JzMstQifbsEroz1M66z
        FXySrzjzdg1rA+N/6S5GTg4JAROJZ29fs3cxcnEICexglDix5BIzhHOBUWJK5ywmkCo2ASOJ
        BdMawWwRgUiJd9t/g3UwC+xhlJh2/TojSEIYKHH50Dt2EJtFQEVi0sITzCA2r4CHxNSbr9kh
        1slJ3DzXCRbnFPCUOHrxF5gtBFRzecE0FpChEgKNTBLtVw+wQjQISZxefJZ5AiPfAkaGVYxC
        uZnJ2alFmdl6BRmVJanJeimpmxiBoXp4ovqlHYx9czwOMTJxMB5ilOBgVhLh3eeuHCvEm5JY
        WZValB9fVJqTWnyIUZqDRUmcdwNvSZiQQHpiSWp2ampBahFMlomDU6qBMeHaDm3LsLOm99Xy
        W0y9nC7em+7T1SrcfL30reMr5mVHotZpzFPLkNVOzjJ4+Pzl8/sbKhOuanCdaEnePF1W3dDx
        TGBtq5NsgOqv5PN3Z0/nPC1tm2Fdu2zGV567C1a9DlzidlW26Fl9u1V4fnBKvvnMCZFcnItq
        tp065PTgxxQL/qn8u3+mKrEUZyQaajEXFScCAE6N57BDAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the same name scheme for the phyBOARD-Segin and the phyCORE-i.MX
6UL as is used for the PHYTEC phyBOARD-Mira and phyCORE-i.MX 6.

This is only a cosmetic change and there is no functional change
intended.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/Makefile                                        | 2 +-
 .../{imx6ul-phytec-pcl063.dtsi => imx6ul-phytec-phycore-som.dtsi} | 2 +-
 ...tec-phyboard-segin-full.dts => imx6ul-phytec-segin-ff-rdk.dts} | 8 ++++----
 ...ytec-peb-eval-01.dtsi => imx6ul-phytec-segin-peb-eval-01.dtsi} | 0
 ...imx6ul-phytec-phyboard-segin.dtsi => imx6ul-phytec-segin.dtsi} | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-phytec-pcl063.dtsi => imx6ul-phytec-phycore-som.dtsi} (98%)
 rename arch/arm/boot/dts/{imx6ul-phytec-phyboard-segin-full.dts => imx6ul-phytec-segin-ff-rdk.dts} (84%)
 rename arch/arm/boot/dts/{imx6ul-phytec-peb-eval-01.dtsi => imx6ul-phytec-segin-peb-eval-01.dtsi} (100%)
 rename arch/arm/boot/dts/{imx6ul-phytec-phyboard-segin.dtsi => imx6ul-phytec-segin.dtsi} (99%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dab2914fa293..e1924b06f3cb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -573,7 +573,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
 	imx6ul-pico-pi.dtb \
-	imx6ul-phytec-phyboard-segin-full.dtb \
+	imx6ul-phytec-segin-ff-rdk.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
similarity index 98%
rename from arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
rename to arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index fc2997449b49..bff13d0eb064 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -10,7 +10,7 @@
 #include "imx6ul.dtsi"
 
 / {
-	model = "Phytec phyCORE i.MX6 UltraLite";
+	model = "PHYTEC phyCORE-i.MX6 UltraLite";
 	compatible = "phytec,imx6ul-pcl063", "fsl,imx6ul";
 
 	chosen {
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
similarity index 84%
rename from arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
rename to arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
index b6a1407a9d44..1e59183a2f7c 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk.dts
@@ -5,12 +5,12 @@
  */
 
 /dts-v1/;
-#include "imx6ul-phytec-pcl063.dtsi"
-#include "imx6ul-phytec-phyboard-segin.dtsi"
-#include "imx6ul-phytec-peb-eval-01.dtsi"
+#include "imx6ul-phytec-phycore-som.dtsi"
+#include "imx6ul-phytec-segin.dtsi"
+#include "imx6ul-phytec-segin-peb-eval-01.dtsi"
 
 / {
-	model = "Phytec phyBOARD-Segin i.MX6 UltraLite Full Featured";
+	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite Full Featured";
 	compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi
rename to arch/arm/boot/dts/imx6ul-phytec-segin-peb-eval-01.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
similarity index 99%
rename from arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
rename to arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
index 7bf439a77d2c..78425c3290a1 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -5,7 +5,7 @@
  */
 
 / {
-	model = "Phytec phyBOARD-Segin i.MX6 UltraLite";
+	model = "PHYTEC phyBOARD-Segin i.MX6 UltraLite";
 	compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063", "fsl,imx6ul";
 
 	aliases {
-- 
2.7.4

