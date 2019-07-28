Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54086C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392732075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 19:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfG1TYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 15:24:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38924 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfG1TYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:24:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6507C1A123D;
        Sun, 28 Jul 2019 21:24:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 57B071A1232;
        Sun, 28 Jul 2019 21:24:49 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8E9CB2060A;
        Sun, 28 Jul 2019 21:24:48 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     broonie@kernel.org
Cc:     l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, viorel.suman@nxp.com,
        timur@kernel.org, shengjiu.wang@nxp.com, angus@akkea.ca,
        tiwai@suse.com, nicoleotsuka@gmail.com, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 4/7] ASoC: dt-bindings: Document dl-mask property
Date:   Sun, 28 Jul 2019 22:24:26 +0300
Message-Id: <20190728192429.1514-5-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728192429.1514-1-daniel.baluta@nxp.com>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI supports up to 8 data lines. This property let the user
configure how many data lines should be used per transfer
direction (Tx/Rx).

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 2e726b983845..2b38036a4883 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -49,6 +49,13 @@ Optional properties:
 
   - big-endian		: Boolean property, required if all the SAI
 			  registers are big-endian rather than little-endian.
+  - fsl,dl-mask		: list of two integers (bitmask, first for RX, second
+			  for TX) representing enabled datalines. Bit 0
+			  represents first data line, bit 1 represents second
+			  data line and so on. Data line is enabled if
+			  corresponding bit is set to 1. By default, if property
+			  not present, only dataline 0 is enabled for both
+			  directions.
 
 Optional properties (for mx6ul):
 
-- 
2.17.1

