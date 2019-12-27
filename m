Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886EFC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BC5208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfL0GDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:03:23 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51606 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfL0GDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:03:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DDFE62009E1;
        Fri, 27 Dec 2019 07:03:17 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E28C42009E4;
        Fri, 27 Dec 2019 07:03:07 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B23B7402D8;
        Fri, 27 Dec 2019 14:02:55 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, l.stach@pengutronix.de, angus@akkea.ca,
        cosmin.stoica@nxp.com, gary.bisson@boundarydevices.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Date:   Fri, 27 Dec 2019 13:59:45 +0800
Message-Id: <1577426385-31273-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577426385-31273-1-git-send-email-Anson.Huang@nxp.com>
References: <1577426385-31273-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board binding for i.MX8MP EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6f241a3..2d1721f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -283,6 +283,12 @@ properties:
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
 
+      - description: i.MX8MP based Boards
+        items:
+          - enum:
+              - fsl,imx8mp-evk            # i.MX8MP EVK Board
+          - const: fsl,imx8mp
+
       - description: i.MX8MQ based Boards
         items:
           - enum:
-- 
2.7.4

