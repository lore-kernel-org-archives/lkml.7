Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BADC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BED21851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbfEXPcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:32:10 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:12020 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389887AbfEXPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:32:08 -0400
X-IronPort-AV: E=Sophos;i="5.60,507,1549897200"; 
   d="scan'208";a="16673469"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 May 2019 00:32:07 +0900
Received: from renesas-VirtualBox.ree.adwin.renesas.com (unknown [10.226.37.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 35A71400A927;
        Sat, 25 May 2019 00:32:05 +0900 (JST)
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: clock: renesas,r9a06g032-sysctrl: Document power Domains
Date:   Fri, 24 May 2019 16:31:43 +0100
Message-Id: <1558711904-27278-2-git-send-email-gareth.williams.jx@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com>
References: <1558711904-27278-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is gaining power domain support, so add the new property
to the DT binding and update the examples.

Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
index d60b997..6c706cd 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.txt
@@ -13,6 +13,7 @@ Required Properties:
 	- external (optional) RGMII_REFCLK
   - clock-names: Must be:
         clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+  - #power-domain-cells : Must be 0
 
 Examples
 --------
@@ -27,6 +28,7 @@ Examples
 		clocks = <&ext_mclk>, <&ext_rtc_clk>,
 				<&ext_jtag_clk>, <&ext_rgmii_ref>;
 		clock-names = "mclk", "rtc", "jtag", "rgmii_ref_ext";
+		#power-domain-cells = <0>;
 	};
 
   - Other nodes can use the clocks provided by SYSCTRL as in:
@@ -40,4 +42,5 @@ Examples
 		reg-io-width = <4>;
 		clocks = <&sysctrl R9A06G032_CLK_UART0>;
 		clock-names = "baudclk";
+		power-domains = <&sysctrl>;
 	};
-- 
2.7.4

