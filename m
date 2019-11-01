Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8685CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F14217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKAU47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:56:59 -0400
Received: from palmtree.beeroclock.net ([178.79.160.154]:44672 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfKAU46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:56:58 -0400
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id 88A6C1F76B;
        Fri,  1 Nov 2019 20:56:56 +0000 (UTC)
From:   Karl Palsson <karlp@tweak.net.au>
To:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Karl Palsson <karlp@tweak.net.au>
Subject: [PATCH 2/2] dt-bindings: arm: sunxi: add FriendlyARM NanoPi Duo2
Date:   Fri,  1 Nov 2019 20:55:36 +0000
Message-Id: <20191101205535.7896-2-karlp@tweak.net.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101205535.7896-1-karlp@tweak.net.au>
References: <20191101205535.7896-1-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds bindings for the newly added NanoPi Duo2 board.

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 000a00d12d6a..152c0499b0a3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -211,6 +211,11 @@ properties:
           - const: friendlyarm,nanopi-a64
           - const: allwinner,sun50i-a64
 
+      - description: FriendlyARM NanoPi Duo2
+        items:
+          - const: friendlyarm,nanopi-duo2
+          - const: allwinner,sun8i-h3
+
       - description: FriendlyARM NanoPi M1
         items:
           - const: friendlyarm,nanopi-m1
-- 
2.20.1

