Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC345C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825852075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="L09tPyP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgAIAa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:30:26 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42994 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAIAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578529821; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OBs2+5xBBRwxPGVM64B4F5IewNAsuf5FC72iXa54J8g=;
        b=L09tPyP8O+UNNRSClBFMMzQNWFgC/cm51ULuUWPtYhCYsj3K1gDEKhVt0ibVa0OTeDxnFB
        JIfl6boyIGhrKkKTBAQWCp52JkWMtZ2Mcq4NdxTum97Dj0H1fYOIkViM9MMfH7k9i7iB3j
        drighYiU65A71p1x4lINCYil8HFLvZ4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] dt-bindings: panel-simple: Add compatible for Sharp LS020B1DD01D
Date:   Wed,  8 Jan 2020 21:30:00 -0300
Message-Id: <20200109003000.119516-2-paul@crapouillou.net>
In-Reply-To: <20200109003000.119516-1-paul@crapouillou.net>
References: <20200109003000.119516-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for the Sharp LS020B1DD01D 2" HQVGA TFT LCD
panel, and remove the old sharp,ls020b1dd01d.txt documentation which is
now obsolete.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 .../bindings/display/panel/panel-simple.yaml         |  2 ++
 .../bindings/display/panel/sharp,ls020b1dd01d.txt    | 12 ------------
 2 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index c1a77d9105a2..f1fba1db382a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -35,6 +35,8 @@ properties:
       - ampire,am800480r3tmqwa1h
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
+        # Sharp LS020B1DD01D 2.0" HQVGA TFT LCD panel
+      - sharp,ls020b1dd01d
 
   backlight: true
   enable-gpios: true
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
deleted file mode 100644
index e45edbc565a3..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,ls020b1dd01d.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Sharp 2.0" (240x160 pixels) 16-bit TFT LCD panel
-
-Required properties:
-- compatible: should be "sharp,ls020b1dd01d"
-- power-supply: as specified in the base binding
-
-Optional properties:
-- backlight: as specified in the base binding
-- enable-gpios: as specified in the base binding
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-- 
2.24.1

