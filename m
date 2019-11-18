Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C26D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ldFG0MXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKRLQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:16:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRLQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:16:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAIBG2Qi087504;
        Mon, 18 Nov 2019 05:16:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574075762;
        bh=AJvnVF1CcG+/gURcJHJhczdZXGZag1iFxD+yTRdx1ZY=;
        h=From:To:CC:Subject:Date;
        b=ldFG0MXIw3w5DNnhOG7Qs4x1UgFodOZX9Pd6Xp+3DTSEc9LCWdXmO5LJKC/EPhUkq
         LuqPJMHY703pBjeWQQFyP3HZ3sHj5BdD4XnqsBcDVNoqlXATK55Wv/gkyHaBsrP8Vn
         s2X/v4m11oGHyNUd7Wl9wjyjGfrzYgdsgxBSGQSU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAIBG1hu028365;
        Mon, 18 Nov 2019 05:16:01 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 05:16:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 05:16:01 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAIBFw3a035927;
        Mon, 18 Nov 2019 05:15:59 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <tony@atomide.com>,
        <bcousson@baylibre.com>, <faiz_abbas@ti.com>,
        <robertcnelson@gmail.com>
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Update pinmux name to ddr_3_3v
Date:   Mon, 18 Nov 2019 16:46:54 +0530
Message-ID: <20191118111654.9843-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

am57xx-beagle-x15 revb1 and revc have 3.3V connected to the eMMC I/O
lines. Update the pinmux name to reflect this.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts | 2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index 7b113b52c3fb..39d1c4ff5749 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -24,7 +24,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_3_3v_rev11 &mmc2_iodelay_ddr_3_3v_rev11_conf>;
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
index 30c500b15b21..4187a9729f96 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
@@ -24,7 +24,7 @@
 };
 
 &mmc2 {
-	pinctrl-names = "default", "hs", "ddr_1_8v";
+	pinctrl-names = "default", "hs", "ddr_3_3v";
 	pinctrl-0 = <&mmc2_pins_default>;
 	pinctrl-1 = <&mmc2_pins_hs>;
 	pinctrl-2 = <&mmc2_pins_ddr_rev20>;
-- 
2.19.2

