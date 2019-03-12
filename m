Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBEEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF2E214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCLPc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:32:57 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40100 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLPc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:32:56 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 11:32:55 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id D3FA515FCC4;
        Tue, 12 Mar 2019 15:26:15 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 10/14] dt-bindings: arm: sunxi: add compatible string for V3/S3/S3L SoCs
Date:   Tue, 12 Mar 2019 23:22:52 +0800
Message-Id: <20190312152256.35574-11-icenowy@aosc.io>
In-Reply-To: <20190312152256.35574-1-icenowy@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner V3/V3s/S3L and SoChip S3 SoCs share the same die, but with
different package (V3 is BGA, without co-packaged DRAM, V3s is QFP,
with co-packaged DDR2, S3 is BGA, with co-packaged DDR3, S3L is BGA
pin-compatible with S3, but with co-packaged DDR2).

Add compatible strings for Allwinner V3/S3L and SoChip S3 SoCs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index 9254cbe7d516..6de8edba5d2b 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -15,9 +15,12 @@ using one of the following compatible strings:
   allwinner,sun8i-h2-plus
   allwinner,sun8i-h3
   allwinner,sun8i-r40
+  allwinner,sun8i-s3l
   allwinner,sun8i-t3
+  allwinner,sun8i-v3
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
   allwinner,suniv-f1c100s
   nextthing,gr8
+  sochip,s3
-- 
2.18.1

