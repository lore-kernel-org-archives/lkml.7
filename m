Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EFFC76190
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E3A20578
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 11:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfG0L3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 07:29:35 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59832 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfG0L3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:29:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 08761FB03;
        Sat, 27 Jul 2019 13:29:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Mjeha8KiY-P; Sat, 27 Jul 2019 13:29:31 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D550146B09; Sat, 27 Jul 2019 13:29:30 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: imx: i.MX8MN: Use space instead of tab
Date:   Sat, 27 Jul 2019 13:29:30 +0200
Message-Id: <35f999387bca037731dd963a5901909d6e6d0a17.1564226824.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes 'make dt_binding_check'

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
Seen on next-20190726

 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
index 454c5b44b2ee..622f3658bd9f 100644
--- a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
@@ -71,7 +71,7 @@ examples:
         compatible = "fixed-clock";
         #clock-cells = <0>;
         clock-frequency = <32768>;
-	clock-output-names = "osc_32k";
+        clock-output-names = "osc_32k";
     };
 
     osc_24m: clock-osc-24m {
-- 
2.20.1

