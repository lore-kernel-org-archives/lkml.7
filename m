Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D79C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC192084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bm8j6c1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfCYOYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:24:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCYOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:24:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2PEOXqq023380;
        Mon, 25 Mar 2019 09:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553523873;
        bh=+IaYHILKE2eJ8ALiMnRLwvk4Pibnmz5NTbCbmzqjgH0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bm8j6c1GPnovOn0RGAp24Qx6Ikqyv3egCWe/RnCiWUMQxGm8o+jsCjkVEOugkxkPr
         wZcooa/P3Dsr4ZfzuH8RS08oO1kv8IQAITO7MpYMVJplAVzu9xlRyTMuNG4nMuBDa+
         WDTCkBGODOwmpIPmDjHtzAgwnLFHFh+PCb7SxXpA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2PEOX9Y023281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Mar 2019 09:24:33 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 25
 Mar 2019 09:24:33 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Mon, 25 Mar 2019 09:24:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2PEOXYs022486;
        Mon, 25 Mar 2019 09:24:33 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/5] dt-bindings: mfd: Update the ramp up/down property
Date:   Mon, 25 Mar 2019 09:23:59 -0500
Message-ID: <20190325142403.30447-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190325142403.30447-1-dmurphy@ti.com>
References: <20190325142403.30447-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the ramp-up/down property and add the property description
to the binding.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/mfd/ti-lmu.txt        | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index 980394d701a7..d9d529de6dc1 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -25,6 +25,12 @@ Required properties:
 
 Optional property:
   - enable-gpios: A GPIO specifier for hardware enable pin.
+  - ramp-up-ms: Current ramping from one brightness level to
+		the a higher brightness level.
+		Range from 2048 us - 117.44 s
+  - ramp-down-ms: Current ramping from one brightness level to
+		  the a lower brightness level.
+		  Range from 2048 us - 117.44 s
 
 Required node:
   - backlight: All LMU devices have backlight child nodes.
@@ -90,7 +96,7 @@ lm3631@29 {
 
 		lcd_bl {
 			led-sources = <0 1>;
-			ramp-up-msec = <300>;
+			ramp-up-ms = <300>;
 		};
 	};
 };
@@ -152,15 +158,15 @@ lm3633@36 {
 		main {
 			label = "main_lcd";
 			led-sources = <1 2>;
-			ramp-up-msec = <500>;
-			ramp-down-msec = <500>;
+			ramp-up-ms = <500>;
+			ramp-down-ms = <500>;
 		};
 
 		front {
 			label = "front_lcd";
 			led-sources = <0>;
-			ramp-up-msec = <1000>;
-			ramp-down-msec = <0>;
+			ramp-up-ms = <1000>;
+			ramp-down-ms = <0>;
 		};
 	};
 
@@ -212,8 +218,8 @@ lm3697@36 {
 
 		lcd {
 			led-sources = <0 1 2>;
-			ramp-up-msec = <200>;
-			ramp-down-msec = <200>;
+			ramp-up-ms = <200>;
+			ramp-down-ms = <200>;
 		};
 	};
 
-- 
2.19.0

