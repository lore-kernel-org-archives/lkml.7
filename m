Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC9C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A18D222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfJENKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 09:10:07 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:36622 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfJENKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 09:10:07 -0400
Received: from ipservice-092-217-086-168.092.217.pools.vodafone-ip.de ([92.217.86.168] helo=reykholt.kaiser.cx)
        by viti.kaiser.cx with esmtpa (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1iGjos-0003SB-7e; Sat, 05 Oct 2019 15:09:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexander Shiyan <shc_work@mail.ru>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/2] dt-bindings: display: imx: fix native-mode setting
Date:   Sat,  5 Oct 2019 15:09:20 +0200
Message-Id: <20191005130921.12874-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191005130921.12874-1-martin@kaiser.cx>
References: <20190918193853.25689-1-martin@kaiser.cx>
 <20191005130921.12874-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the native-mode setting inside the display-timing node. Outside of
display-timing, it is ignored.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v2
 move parts of the commit message into the cover letter

 Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
index e5a8b363d829..f4df9e83bcd2 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
@@ -38,10 +38,10 @@ Example:
 
 	display0: display0 {
 		model = "Primeview-PD050VL1";
-		native-mode = <&timing_disp0>;
 		bits-per-pixel = <16>;
 		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
 		display-timings {
+			native-mode = <&timing_disp0>;
 			timing_disp0: 640x480 {
 				hactive = <640>;
 				vactive = <480>;
-- 
2.11.0

