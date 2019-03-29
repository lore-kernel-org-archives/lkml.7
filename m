Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32271C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01350218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dkVoGZso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfC2Rxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:53:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35808 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbfC2Rxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:53:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2THrcPR038161;
        Fri, 29 Mar 2019 12:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553882018;
        bh=KNqY/eu5wOVa793bxaG/niybjc8PMLelGn0VJgdpu+0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dkVoGZsosz/YfSLMliS8hi3Z0PB7Uj2KHvRG2//gW0ohLjZGFcPwd3PQSO3U20eB3
         45JSeHvY8mlRFzb8w5ZfS0zdQ6WSKD9xxTlC0bAu9aj0q0zrcALYTgLa46x0taxQY7
         0iMA62p1LT+RLtFBprY/HyfgOS4aMLIBGb2mddHc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2THrcXl119143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 12:53:38 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 12:53:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 12:53:38 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2THrceI013252;
        Fri, 29 Mar 2019 12:53:38 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2THrbU25916;
        Fri, 29 Mar 2019 12:53:37 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/5] ARM: dts: am43xx-epos-evm: Add matrix keypad as wakeup source
Date:   Fri, 29 Mar 2019 12:53:34 -0500
Message-ID: <20190329175336.19824-3-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark matrix-keypad as a wakeup source.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 606b848d809f..9b8b132b04e1 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -80,6 +80,7 @@
 		pinctrl-names = "default", "sleep";
 		pinctrl-0 = <&matrix_keypad_default>;
 		pinctrl-1 = <&matrix_keypad_sleep>;
+		wakeup-source;
 
 		row-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH		/* Bank0, pin12 */
 			     &gpio0 13 GPIO_ACTIVE_HIGH		/* Bank0, pin13 */
-- 
2.21.0

