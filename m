Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEFFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D820843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfHNI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:29:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41616 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfHNI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:29:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FEC1200346;
        Wed, 14 Aug 2019 10:29:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 136CA200345;
        Wed, 14 Aug 2019 10:29:15 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3ED1F20633;
        Wed, 14 Aug 2019 10:29:14 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com, viorel.suman@nxp.com, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: Introduce compatible string for imx8qm
Date:   Wed, 14 Aug 2019 11:29:11 +0300
Message-Id: <20190814082911.665-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814082911.665-1-daniel.baluta@nxp.com>
References: <20190814082911.665-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register map for i.MX8QM is similar with i.MX6 series. Integration
of SAI IP into i.MX8QM SOC features a FIFO size of 64 X 32 bits samples.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index e61c0dc1fc0b..0dc83cc4a236 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -9,7 +9,8 @@ Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
 			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai" or "fsl,imx8mq-sai".
+			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai" or
+			  "fsl,imx8qm-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.17.1

