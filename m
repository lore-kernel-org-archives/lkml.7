Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB3AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75322222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mrT2mpYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfKSORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:17:50 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:49804 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfKSORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574173064; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=GwQs/I34Gsxl3SkZJ9TndJzpKGHdtrRU8KhsXh5z6T4=;
        b=mrT2mpYFDmFwKTDD8Mwz02JbRJsC+rlA44Wx0jWx/ZCxD8LzKabuLh4MZBcahZ6u36KNDr
        4D8N75NLGhtHVfWL5A5y1HSHCs5e9xDnwNA5dc3fPzVd9ik5qVydB7ZlnN2fHX0NDF8rOJ
        fs9NcFPmUx1lWMwqSdeTyViKojNa8Lc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] dt-bindings: display/ingenic: Add compatible string for JZ4770
Date:   Tue, 19 Nov 2019 15:17:31 +0100
Message-Id: <20191119141736.74607-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the LCD controller found in the JZ4770 SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/display/ingenic,lcd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/ingenic,lcd.txt b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
index 7b536c8c6dde..01e3261defb6 100644
--- a/Documentation/devicetree/bindings/display/ingenic,lcd.txt
+++ b/Documentation/devicetree/bindings/display/ingenic,lcd.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: one of:
   * ingenic,jz4740-lcd
   * ingenic,jz4725b-lcd
+  * ingenic,jz4770-lcd
 - reg: LCD registers location and length
 - clocks: LCD pixclock and device clock specifiers.
 	   The device clock is only required on the JZ4740.
-- 
2.24.0

