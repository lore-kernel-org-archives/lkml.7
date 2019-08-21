Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B0CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4135F233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566398330;
	bh=kWS1IJNtZwpR6Tu1rPoZ6ol1cRQDzAO9uYXRVmzqlQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UOWEOh6rlb/XemuEquseDhV+wIboSPwcDoF7V9d4fIPXKQLZQUSV4OVDQrt+FQUIV
	 kuUAXLG2DsOxyhv8LMHTMM441EVPPcqWtR4sOySfkjuGKmeYUARBaqErAAZLoD7800
	 cevPXOPxAvJkQr3ROb6HLUt4TIzcz8NoLeAkcg0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfHUOit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbfHUOiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:38:46 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A01F233A0;
        Wed, 21 Aug 2019 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566398325;
        bh=kWS1IJNtZwpR6Tu1rPoZ6ol1cRQDzAO9uYXRVmzqlQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Scm4h2kZA2DV7qqzZeUzEy6U5YK50q64Cs4lszRV8MqbZOL2O/gIDU39DwmzHyCB9
         Ethfk7PgtPyQorD65o+TcL9f2oK47Dv0dg+uDlphMgLSgfST3eRUnRA1IEBsEVAdvg
         wkMg/LJBzPyvNFKZ8qW6udd6Wcxd4TaGg/4eCOHE=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH RESEND v2 4/6] dt-bindings: watchdog: sun4i: Add the watchdog clock
Date:   Wed, 21 Aug 2019 16:38:33 +0200
Message-Id: <20190821143835.7294-4-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821143835.7294-1-mripard@kernel.org>
References: <20190821143835.7294-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner watchdog has a clock that has been described in some DT, but
not all of them.

The binding is also completely missing that description. Let's add that
property to be consistent.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - New patch
---
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
index 31c95c404619..3a54f58683a0 100644
--- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
@@ -31,12 +31,16 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   interrupts:
     maxItems: 1
 
 required:
   - compatible
   - reg
+  - clocks
   - interrupts
 
 unevaluatedProperties: false
@@ -47,6 +51,7 @@ examples:
         compatible = "allwinner,sun4i-a10-wdt";
         reg = <0x01c20c90 0x10>;
         interrupts = <24>;
+        clocks = <&osc24M>;
         timeout-sec = <10>;
     };
 
-- 
2.21.0

