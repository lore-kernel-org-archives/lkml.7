Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52352C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FA820896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbfFKOTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:19:42 -0400
Received: from hermes.aosc.io ([199.195.250.187]:33445 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388808AbfFKOTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:19:41 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 8FCE78229F;
        Tue, 11 Jun 2019 14:12:36 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 09/11] dt-bindings: vendor-prefixes: add Sipeed
Date:   Tue, 11 Jun 2019 22:09:38 +0800
Message-Id: <20190611140940.14357-10-icenowy@aosc.io>
In-Reply-To: <20190611140940.14357-1-icenowy@aosc.io>
References: <20190611140940.14357-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shenzhen Sipeed Technology Co., Ltd. is a company focused on development
kits, which also contains rebranded Lichee Pi series.

Add its vendor prefix binding.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2c8a8b195c07..c0cd22e5672a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -791,6 +791,8 @@ patternProperties:
     description: Silicon Mitus, Inc.
   "^simtek,.*":
     description: Cypress Semiconductor Corporation (Simtek Corporation)
+  "^sipeed,.*":
+    description: Shenzhen Sipeed Technology Co., Ltd.
   "^sirf,.*":
     description: SiRF Technology, Inc.
   "^sis,.*":
-- 
2.21.0

