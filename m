Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7011EFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D67D21848
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbfKGCQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:16:32 -0500
Received: from inva020.nxp.com ([92.121.34.13]:60400 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfKGCQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:16:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D93AC1A0244;
        Thu,  7 Nov 2019 03:16:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBE841A00C2;
        Thu,  7 Nov 2019 03:16:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 12ED2402B1;
        Thu,  7 Nov 2019 10:16:17 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] ARM: dts: imx7d-sdb-reva: Add revision in board compatible string
Date:   Thu,  7 Nov 2019 10:14:52 +0800
Message-Id: <1573092893-10612-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7D SDB Rev-A board should use its own board compatible
string instead of default i.MX7D SDB board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb-reva.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb-reva.dts b/arch/arm/boot/dts/imx7d-sdb-reva.dts
index 7ce9d8c..cabdaa6 100644
--- a/arch/arm/boot/dts/imx7d-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx7d-sdb-reva.dts
@@ -7,6 +7,9 @@
 #include "imx7d-sdb.dts"
 
 / {
+	model = "Freescale i.MX7 SabreSD RevA Board";
+	compatible = "fsl,imx7d-sdb-reva", "fsl,imx7d";
+
 	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
 		pinctrl-0 = <&pinctrl_usb_otg2_vbus_reg_reva>;
 		gpio = <&gpio4 7 GPIO_ACTIVE_HIGH>;
-- 
2.7.4

