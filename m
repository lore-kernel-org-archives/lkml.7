Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35769C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0195D20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nficS7dT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfC2SN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:13:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41770 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfC2SNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:13:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDHm6033945;
        Fri, 29 Mar 2019 13:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553883197;
        bh=gUE1sRoRE+d0aUS7tVP9CbD2RA/M/m5eHx0s3lREE5Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nficS7dTsRpzA+TOeAoyj66bs1kLAMvsAjntbJ31M50FR6ytWWEhKnwqG0nHSVhRE
         FBPJH2yNv+rSNKtTtsWnjfFWUPpQDzCm9QQBfB8rbSHWcak+dZmZs+7V+yjgKq9PF+
         kCpx4qwMlIolXYX7aZzfZW9w8OMcfVqNPSik9fBU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TIDHpv123663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 13:13:17 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 13:13:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 13:13:16 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDGdk034813;
        Fri, 29 Mar 2019 13:13:16 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TIDGU04859;
        Fri, 29 Mar 2019 13:13:16 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 4/4] ARM: dts: omap2420-n810: Use new CODEC reset pin name
Date:   Fri, 29 Mar 2019 13:13:13 -0500
Message-ID: <20190329181313.21009-4-afd@ti.com>
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
 arch/arm/boot/dts/omap2420-n810.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n810.dts b/arch/arm/boot/dts/omap2420-n810.dts
index 96b9913ecc1f..09c1dbc0bb69 100644
--- a/arch/arm/boot/dts/omap2420-n810.dts
+++ b/arch/arm/boot/dts/omap2420-n810.dts
@@ -48,7 +48,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&aic33_pins>;
 
-		gpio-reset = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
+		reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>; /* gpio118 */
 
 		ai3x-gpio-func = <
 			10 /* AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK */
-- 
2.21.0

