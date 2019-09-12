Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA43C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E512085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfILC5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:57:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52872 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfILC5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:57:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50B241A09A1;
        Thu, 12 Sep 2019 04:57:34 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5A3B1A0617;
        Thu, 12 Sep 2019 04:57:29 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A3CAB402AE;
        Thu, 12 Sep 2019 10:57:23 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] ARM: dts: imx7d: Add opp-suspend property
Date:   Thu, 12 Sep 2019 10:56:32 +0800
Message-Id: <1568256992-31707-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
References: <1568256992-31707-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "opp-suspend" property for i.MX7D to make sure system
suspend with max available opp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 0083272..2792767 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -44,6 +44,7 @@
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <150000>;
 			opp-supported-hw = <0xd>, <0xf>;
+			opp-suspend;
 		};
 
 		opp-996000000 {
@@ -51,6 +52,7 @@
 			opp-microvolt = <1100000>;
 			clock-latency-ns = <150000>;
 			opp-supported-hw = <0xc>, <0xf>;
+			opp-suspend;
 		};
 
 		opp-1200000000 {
@@ -58,6 +60,7 @@
 			opp-microvolt = <1225000>;
 			clock-latency-ns = <150000>;
 			opp-supported-hw = <0x8>, <0xf>;
+			opp-suspend;
 		};
 	};
 
-- 
2.7.4

