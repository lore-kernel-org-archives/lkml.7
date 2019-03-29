Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89A220811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eM9VAJKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfC2SNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:13:30 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37858 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfC2SNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:13:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDGfY043760;
        Fri, 29 Mar 2019 13:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553883196;
        bh=IPagX7PA9CQADR+5yF9tF3KZHSBQYB5z7PmK4hppsM8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eM9VAJKX7TFiRBS1DmVQbTDotdZnhCqTXUCuF0Jlw1s86GwfWTDWRggROIIVfeUjp
         FcASJWz9r4KKY9jVmj8vRdt6V8QztCKapF06eeMYEB3ejzZy1JvJ95pHaPuW+cCF92
         iK0rXmltbtI0rVlCkt6feE2YOXuMQFcI6/YYwWzU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TIDGgj071912
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 13:13:16 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 13:13:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 13:13:16 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDGRx050590;
        Fri, 29 Mar 2019 13:13:16 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TIDFU04855;
        Fri, 29 Mar 2019 13:13:15 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/4] ARM: dts: imx6qdl: Use new CODEC reset pin name
Date:   Fri, 29 Mar 2019 13:13:12 -0500
Message-ID: <20190329181313.21009-3-afd@ti.com>
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
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
index 8752a4961c47..c41cac502bac 100644
--- a/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-var-dart.dtsi
@@ -183,7 +183,7 @@
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&reg_3p3v>;
 		ai3x-ocmv = <0>;
-		gpio-reset = <&gpio5 5 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
 	};
 };
 
-- 
2.21.0

