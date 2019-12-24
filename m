Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83256C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E07206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 01:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLXBAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 20:00:30 -0500
Received: from lists.gateworks.com ([108.161.130.12]:56093 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 20:00:30 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1ijYng-0007xM-10; Tue, 24 Dec 2019 01:15:52 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v4 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
Date:   Mon, 23 Dec 2019 17:00:16 -0800
Message-Id: <20191224010020.15969-2-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20191224010020.15969-1-rjones@gateworks.com>
References: <20191224010020.15969-1-rjones@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible enum entries for Gateworks Ventana boards.

Signed-off-by: Robert Jones <rjones@gateworks.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f79683a..a02e980 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -126,6 +126,7 @@ properties:
               - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
               - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
               - variscite,dt6customboard
+              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
           - const: fsl,imx6q
 
       - description: i.MX6QP based Boards
@@ -152,6 +153,7 @@ properties:
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
+              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
           - const: fsl,imx6dl
 
       - description: i.MX6SL based Boards
-- 
2.9.2

