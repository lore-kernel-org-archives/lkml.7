Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CADC04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38E2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIMaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:30:06 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:50032 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:30:06 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 25BB425AD6F;
        Thu,  9 May 2019 22:30:04 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 2A0B89403F2; Thu,  9 May 2019 14:30:02 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Cao Van Dong <cv-dong@jinso.co.jp>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH repost] dt-bindings: timer: renesas, cmt: Document r8a779{5|65|90} CMT support
Date:   Thu,  9 May 2019 14:29:49 +0200
Message-Id: <20190509122949.23256-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cao Van Dong <cv-dong@jinso.co.jp>

Document SoC specific bindings for R-Car H3/M3-N/E3 SoCs.

Signed-off-by: Cao Van Dong <cv-dong@jinso.co.jp>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index c0594450e9ef..c5220bcd852b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -42,12 +42,18 @@ Required Properties:
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
     - "renesas,r8a7794-cmt1" for the 48-bit CMT1 device included in r8a7794.
+    - "renesas,r8a7795-cmt0" for the 32-bit CMT0 device included in r8a7795.
+    - "renesas,r8a7795-cmt1" for the 48-bit CMT1 device included in r8a7795.
     - "renesas,r8a7796-cmt0" for the 32-bit CMT0 device included in r8a7796.
     - "renesas,r8a7796-cmt1" for the 48-bit CMT1 device included in r8a7796.
+    - "renesas,r8a77965-cmt0" for the 32-bit CMT0 device included in r8a77965.
+    - "renesas,r8a77965-cmt1" for the 48-bit CMT1 device included in r8a77965.
     - "renesas,r8a77970-cmt0" for the 32-bit CMT0 device included in r8a77970.
     - "renesas,r8a77970-cmt1" for the 48-bit CMT1 device included in r8a77970.
     - "renesas,r8a77980-cmt0" for the 32-bit CMT0 device included in r8a77980.
     - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
+    - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
+    - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
 
     - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
 		and RZ/G1.
-- 
2.11.0

