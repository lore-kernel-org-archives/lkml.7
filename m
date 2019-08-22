Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0AC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4583621848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566453777;
	bh=s5Qwnruo1Obm/UgGKOuiLFuyxuT50eeJafK3ydS0kLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wRmzCgUJOP/MTuL0D0lGaD6XtrpJl/7kDtCF9Amf82QNOc2/1nDWOE/fOnC8qE8P/
	 bXzYjHAX+mlm/NBEbXLZjxwM5ZFs/liL8FIsozcn3dCPojpRGJNn/BqwVjNWHnG8Pp
	 frBiIeH99nlt5+qhkVGXm+ORSJ7mn/QjYKPN8Rvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfHVGC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbfHVGCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:02:55 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7956B233A2;
        Thu, 22 Aug 2019 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566453774;
        bh=s5Qwnruo1Obm/UgGKOuiLFuyxuT50eeJafK3ydS0kLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv1EXf7GNShiWAoKHVSRufR4r8GMjrh7DcVXpVY9oLGKzt8eVKsuQEMtoEjKUYG4d
         wSUD1TeckIXuTZTm6PObMjoJG+YCP5dt4b7TQ0KydEXkwhh3f8+Im1At/DCbkLV4D+
         nllO/9BDx5sutMUZ4she2cdmOqnOA8wy+9jtXWcw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
Date:   Thu, 22 Aug 2019 08:02:37 +0200
Message-Id: <20190822060238.3887-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822060238.3887-1-krzk@kernel.org>
References: <20190822060238.3887-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v6:
1. Split entries to pass the dtbs_check.

Changes since v5:
New patch
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..1f440817fc03 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -161,6 +161,20 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
+          - const: fsl,imx6ul
+
+      - description: Kontron N6310 S Board
+        items:
+          - const: kontron,imx6ul-n6310-s
+          - const: kontron,imx6ul-n6310-som
+          - const: fsl,imx6ul
+
+      - description: Kontron N6310 S 43 Board
+        items:
+          - const: kontron,imx6ul-n6310-s-43
+          - const: kontron,imx6ul-n6310-s
+          - const: kontron,imx6ul-n6310-som
           - const: fsl,imx6ul
 
       - description: i.MX6ULL based Boards
-- 
2.17.1

