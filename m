Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3214FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D7E2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 13:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfHYNuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 09:50:50 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38615 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfHYNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 09:50:47 -0400
X-Originating-IP: 87.18.63.98
Received: from uno.homenet.telecomitalia.it (unknown [87.18.63.98])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C3146C0007;
        Sun, 25 Aug 2019 13:50:42 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli@fpond.eu, airlied@linux.ie, daniel@ffwll.ch
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] arm64: dts: renesas: r8a7796: Add CMM units
Date:   Sun, 25 Aug 2019 15:51:43 +0200
Message-Id: <20190825135154.11488-4-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825135154.11488-1-jacopo+renesas@jmondi.org>
References: <20190825135154.11488-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CMM units to Renesas R-Car M3-W device tree and reference them from
the Display Unit they are connected to.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 3dc9d73f589a..8d78e1f98a23 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2613,6 +2613,30 @@
 			renesas,fcp = <&fcpvi0>;
 		};
 
+		cmm0: cmm@fea40000 {
+			compatible = "renesas,cmm-r8a7796";
+			reg = <0 0xfea40000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 711>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 711>;
+		};
+
+		cmm1: cmm@fea50000 {
+			compatible = "renesas,cmm-r8a7796";
+			reg = <0 0xfea50000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 710>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 710>;
+		};
+
+		cmm2: cmm@fea60000 {
+			compatible = "renesas,cmm-r8a7796";
+			reg = <0 0xfea60000 0 0x1000>;
+			clocks = <&cpg CPG_MOD 709>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 709>;
+		};
+
 		csi20: csi2@fea80000 {
 			compatible = "renesas,r8a7796-csi2";
 			reg = <0 0xfea80000 0 0x10000>;
@@ -2766,6 +2790,7 @@
 			status = "disabled";
 
 			vsps = <&vspd0 &vspd1 &vspd2>;
+			cmms = <&cmm0 &cmm1 &cmm2>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.22.0

