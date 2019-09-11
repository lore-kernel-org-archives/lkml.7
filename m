Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF57C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3FB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="GDJ6+n3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfIKRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:21:35 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:45584 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfIKRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjjUCqREd24BL7yzqZIG7ugFF4ygEUT5uM43q+3udrs=; b=GDJ6+n3GGRLWyDKAcc3TbP18HA
        LKjqSUnPBuuMSA2td6QiBl6mkODnsW8Zbo3tQHJ3B7BUaFLJHDwG8zLBKMpdvSMXPsrUTb7o7pquF
        1zrgvhvwVDPLL+PeQCi19KfIc9fm8lMQYgWIXEpFRcXZdL2kHySdWZS2oA6G2QSr0nj0=;
Received: from p200300ccff0b59001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:5900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i86J4-0006kb-1A; Wed, 11 Sep 2019 19:21:26 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1i86J3-0003M2-Oi; Wed, 11 Sep 2019 19:21:25 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        dmurphy@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Date:   Wed, 11 Sep 2019 19:21:05 +0200
Message-Id: <20190911172106.12843-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911172106.12843-1-andreas@kemnade.info>
References: <20190911172106.12843-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add enable-gpios to describe HWEN pin

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
changes in v2: added example
changes in v3: added Acked-by
 .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
index dc129d9a329e..1fa83feffe16 100644
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
@@ -92,6 +96,7 @@ examples:
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
+        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 
         led-controller@38 {
                 compatible = "ti,lm3630a";
-- 
2.20.1

