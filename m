Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D29DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096D52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Y0Bqi4xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfC0A1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:34 -0400
Received: from vps.xff.cz ([195.181.215.36]:53770 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfC0A1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645935; bh=E8uWpOFzEjJM8nhIfTxupeHnnF3WRKAcFA/nvriz9Xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0Bqi4xfon/fAYsTeu7GTYJ6214T+D4w+fnTGBUzsF4PJAblbHYbxnrvBQmgHlqB+
         W3oKmfGhTjDwZZQDpm3csUHwlvK9YudY7fLAoiL5X+PJnRSD2+BV03wTdL0NChoKZm
         d97ebePFYlGVLORkV9mBhcFpXf/4yxO6fKjKvx00=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 4/7] ARM: dts: sun8i: a83t: Add UART2 PB pins
Date:   Wed, 27 Mar 2019 01:18:40 +0100
Message-Id: <20190327001843.2420-5-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Add pin definitions for UART2 PB pins. These are used on TBS-A711
tablet.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index e5c39eef1c29..921cfb30ab46 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -768,6 +768,11 @@
 				pins = "PG8", "PG9";
 				function = "uart1";
 			};
+
+			uart2_pb_pins: uart2-pb-pins {
+				pins = "PB0", "PB1";
+				function = "uart2";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.21.0

