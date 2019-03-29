Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEE320811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JSzU3388"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfC2SNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:13:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45766 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfC2SNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:13:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDF8J094107;
        Fri, 29 Mar 2019 13:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553883195;
        bh=L17Cb1fDtelrIXbBPXz4CRwLeJizoVah/z2YYeqNE3k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JSzU3388ZiOOuMfZ6mZNNBTia1w2L3GQDBcQ3Eko39BtS/Fg/YUpZrt+rEMN+WSuX
         RZdXkrv3vFvsRro7H3Cxrdz63jnfSAtHtvtPJo1HL8lEq11DKx3fLMyufySEwVT3iM
         tu30UX/XJwpa5pcIU/pyT1gv+QtZITpGpXRMHe1s=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TIDFMm093120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 13:13:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 13:13:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 13:13:15 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDFfN040396;
        Fri, 29 Mar 2019 13:13:15 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TIDEU04851;
        Fri, 29 Mar 2019 13:13:14 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/4] ARM: dts: imx: Use new CODEC reset pin name
Date:   Fri, 29 Mar 2019 13:13:11 -0500
Message-ID: <20190329181313.21009-2-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329181313.21009-1-afd@ti.com>
References: <20190329181313.21009-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", the driver now accepts this name, use it here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 9cb9a7439121..aee9221f0f29 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -311,7 +311,7 @@
 	tlv320aic3105: codec@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
 		/* Regulators */
-- 
2.21.0

