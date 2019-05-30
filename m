Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ABC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B39725876
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfE3Emj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:42:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41378 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfE3DMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DD86720122C;
        Thu, 30 May 2019 05:12:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB0BA2005A3;
        Thu, 30 May 2019 05:12:08 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 166D94029F;
        Thu, 30 May 2019 11:12:01 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] dt-bindings: imx: Correct pinfunc head file path for i.MX8MM
Date:   Thu, 30 May 2019 11:13:57 +0800
Message-Id: <20190530031357.17484-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The i.MX8MM pinfunc head file is located in DT folder, correct it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
index 524a16f..e4e01c0 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.txt
@@ -12,7 +12,7 @@ Required properties in sub-nodes:
 - fsl,pins: each entry consists of 6 integers and represents the mux and config
   setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
   input_val> are specified using a PIN_FUNC_ID macro, which can be found in
-  <dt-bindings/pinctrl/imx8mm-pinfunc.h>. The last integer CONFIG is
+  <arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h>. The last integer CONFIG is
   the pad setting value like pull-up on this pin.  Please refer to i.MX8M Mini
   Reference Manual for detailed CONFIG settings.
 
-- 
2.7.4

