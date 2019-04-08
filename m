Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DAAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC6E20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742701;
	bh=WUhXHJXtBBOOHJfV9e27Xl89wCf7Toeord7PvhzbQOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KT5R5pHxj6Z0EA0oE6rThBVQtSTqSTGJDWyof7UugzKDcfcOk9eYI5MebSvRDohGE
	 IOwSYpiaLlK5db9T6KgK4TpqFxrxn5zecPUAFDfOaHnd8KyxJ7MyHreARQ0yb6OhZW
	 tZmeMGAOECGg+kh3Sy7lu+mvDGYBixyATYilFyLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfDHQ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:20 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43714 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfDHQ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:49 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id A192E5F87D; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 2/6] dt-bindings: media: sun6i-csi: Add compatible string for A83T variant
Date:   Tue,  9 Apr 2019 00:57:40 +0800
Message-Id: <20190408165744.11672-3-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408165744.11672-1-wens@kernel.org>
References: <20190408165744.11672-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The A83T SoC has a camera sensor interface (known as CSI in Allwinner
lingo), which is similar to the one found on the A64 and H3. The only
difference seems to be that support of MIPI CSI through a connected
MIPI CSI-2 bridge.

Add a compatible string for this variant.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/media/sun6i-csi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
index 0dd540bb03db..a2e3e56f0257 100644
--- a/Documentation/devicetree/bindings/media/sun6i-csi.txt
+++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
@@ -6,6 +6,7 @@ Allwinner V3s SoC features a CSI module(CSI1) with parallel interface.
 Required properties:
   - compatible: value must be one of:
     * "allwinner,sun6i-a31-csi"
+    * "allwinner,sun8i-a83t-csi"
     * "allwinner,sun8i-h3-csi"
     * "allwinner,sun8i-v3s-csi"
     * "allwinner,sun50i-a64-csi"
-- 
2.20.1

