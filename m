Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD16C4360D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9FE21928
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DU6vwmH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfIHUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 16:37:21 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:33324 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfIHUhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 16:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kpo4GcGSp/p9xK4M107Cs6yDAMCz9KA0m/IM/ACOm4E=; b=DU6vwmH4jkv/uSyC72u75opOru
        tJiAe0zAqAhQf8OWs+pSXGzo6uHU3Ab+7u5Byz3emvyTlLRzJuasaqMGR+n/1e6R0V/r6fL69nCRd
        TdEg4gpjSwZR97wFCRmmK5S6+FYXuE2J8xM3wGCEM0/TNagoJCLVOXbKseWO14fHBaAc=;
Received: from p200300ccff4729001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff47:2900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i73vq-0000wT-5M; Sun, 08 Sep 2019 22:37:10 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1i73vp-0007rT-Sv; Sun, 08 Sep 2019 22:37:09 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] dt-bindings: backlight: lm3630a: add enable_gpios
Date:   Sun,  8 Sep 2019 22:37:04 +0200
Message-Id: <20190908203704.30147-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908203704.30147-1-andreas@kemnade.info>
References: <20190908203704.30147-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add enable-gpios to describe HWEN pin

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index dc129d9a329e..a9656d72b668 100644
--- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -29,6 +29,10 @@ properties:
   '#size-cells':
     const: 0
 
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.20.1

