Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B00C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DDC20989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JRf64rzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfDEO3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:29:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35916 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfDEO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:29:04 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35ESx4s017735;
        Fri, 5 Apr 2019 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554474539;
        bh=6eVDAnS/2+3xqohXvSibJXxGj4O077fv/lz6wFUD+zU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JRf64rzUVp2jgNiQxuVDquXx4qJ1xOj/B3GlQ4TFKPYnv/eMjVFo68mLqSfdrEcr2
         DhubxmgecBsrCY4kQa9MsrrJe9MJ7MvLI8kOdV4x4O9nZyE1IakSnAyVFYTjzkJex1
         VXnj5jZYMht5x+jOlCwT8He+Vvy12TqkUyCOMNhM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35ESxEV038969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:28:59 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:28:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:28:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35ESxic118450;
        Fri, 5 Apr 2019 09:28:59 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/6] dt-bindings: mfd: LMU: Add ti,brightness-resolution
Date:   Fri, 5 Apr 2019 09:28:51 -0500
Message-ID: <20190405142855.3969-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405142855.3969-1-dmurphy@ti.com>
References: <20190405142855.3969-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ti,brightness-resolution to the TI LMU binding to define
whether the device uses 8-bit brightness or 11-bit brightness.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - New patch.  Add brightness resolution to ti-lmu.txt.  See patch comments
for context. - https://lore.kernel.org/patchwork/patch/1054501/

 Documentation/devicetree/bindings/mfd/ti-lmu.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index adae96c79d39..5881929d5f7a 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -31,6 +31,16 @@ Optional property:
   - ramp-down-ms: Current ramping from one brightness level to
 		  the a lower brightness level.
 		  Range from 2048 us - 117.44 s
+  - ti,brightness-resolution - This determines whether to use 8 bit brightness
+			       mode or 11 bit brightness mode.  If this value is
+			       not set the device is defaulted to the preferred
+			       8bit brightness mode per 7.3.4.1 of the data
+			       sheet.  This setting can either be in the parent
+			       node or as part of the LED child nodes.  This
+			       is determined by the part itself if the strings
+			       have a common brightness register or individual
+			       brightness registers.
+			       The values are 255 (8bit) or 2047 (11bit).
 
 Required node:
   - backlight: All LMU devices have backlight child nodes.
@@ -217,6 +227,7 @@ lm3697@36 {
 		compatible = "ti,lm3697-backlight";
 
 		lcd {
+			ti,brightness-resolution = <255>;
 			led-sources = <0 1 2>;
 			ramp-up-ms = <200>;
 			ramp-down-ms = <200>;
-- 
2.19.0

