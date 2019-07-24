Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81612190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="Mugaxw5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfGXHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:49:40 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:49594 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1563954574; x=1566546574;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EqQWA7dLtCGI8kCRV8d94HFWhGW2KPLYNClP0pwmpPY=;
        b=Mugaxw5xkyEXDda8a7GPEveEXMpOl9ZZFt5S3xlVD7BNp/r5iQ4CUE11WGvWknp3
        lVzR8ATHvYRpZYPir8Kc6se1LO/falAaulCn9cMri5dtW2KcAWCDkGeM6QU2N6iE
        vjkiiU7+iv+pOu7UncgHqfPDADoiCto/Tz6tqjdqnAk=;
X-AuditID: c39127d2-193ff70000001aee-b5-5d380d8dab5e
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1D.CA.06894.D8D083D5; Wed, 24 Jul 2019 09:49:33 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019072409493350-408985 ;
          Wed, 24 Jul 2019 09:49:33 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-imx@nxp.com, Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 devicetree bindings
Date:   Wed, 24 Jul 2019 09:49:33 +0200
Message-Id: <1563954573-370205-2-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
References: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2019 09:49:33,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2019 09:49:33,
        Serialize complete at 24.07.2019 09:49:33
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWyRoCBS7eX1yLW4P11a4vmDluL+UfOsVo8
        vOpvsenxNVaLrl8rmS0u75rDZnG3pZPVYun1i0wWrXuPsFv83b6JxeLFFnEHbo8189Yweuyc
        dZfdY9OqTjaPO9f2sHlsXlLvsfHdDiaP/r8GHp83yQVwRHHZpKTmZJalFunbJXBlPDrpWjBb
        rOLc92aWBsY9/F2MnBwSAiYSRw5vYO1i5OIQEtjBKDGl4wwjhHORUaL9XxMzSBWbgJHEgmmN
        TCC2iICGxJSux+wgRcwCU5klGv8sZQVJCAsESKz9tJEdxGYRUJU4vOAVI4jNK+AhcezwVkaI
        dXISN891gg3lFPCUWLpvMRuILQRUs/jYZyaQoRICjUwS7R9Ps0M0CEmcXnyWeQIj3wJGhlWM
        QrmZydmpRZnZegUZlSWpyXopqZsYgWF6eKL6pR2MfXM8DjEycTAeYpTgYFYS4Q1sMIsV4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzruBtyRMSCA9sSQ1OzW1ILUIJsvEwSnVwFg/64NylO1Oxhsl
        kpcc1+lIum7v/3VvzfIPxnFXMu86Wqa8P1nO6FHevHH3xLSq129yK75fOlRQ1TbD7Kftl6yF
        PFvO6Plcc53y/8i/Mw3pdSK5P2quzty4yL284ON9dubGqZeWGrw8uG69+HWlexarXD8q/1/8
        2+NYT8q5bdn3PT/tPrJr/74CJZbijERDLeai4kQAGH3RWkECAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for i.MX6 based phyCORE-i.MX6, phyBOARD-Mira and
phyFLEX-i.MX6.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 40f007859092..00a037cf5c86 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -112,6 +112,13 @@ properties:
               - fsl,imx6q-sabreauto
               - fsl,imx6q-sabrelite
               - fsl,imx6q-sabresd
+              - phytec,imx6qdl-pcm058     # PHYTEC phyCORE-i.MX6
+              - phytec,imx6q-pbab01       # PHYTEC phyFLEX carrier board
+              - phytec,imx6q-pbab01-nand  # PHYTEC phyFLEX eval Kit
+              - phytec,imx6q-pbac06       # PHYTEC phyBOARD-Mira with i.MX6 Quad
+              - phytec,imx6q-pbac06-emmc  # PHYTEC phyBOARD-Mira eMMC RDK
+              - phytec,imx6q-pbac06-nand  # PHYTEC phyBOARD-Mira NAND RDK
+              - phytec,imx6q-pfla02       # PHYTEC phyFLEX-i.MX6 Quad
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
           - const: fsl,imx6q
@@ -121,6 +128,9 @@ properties:
           - enum:
               - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
               - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
+              - phytec,imx6qdl-pcm058     # PHYTEC phyCORE-i.MX6
+              - phytec,imx6qp-pbac06      # PHYTEC phyBOARD-Mira with i.MX6 QuadPlus
+              - phytec,imx6qp-pbac06-nand # PHYTEC phyBOARD-Mira NAND RDK
           - const: fsl,imx6qp
 
       - description: i.MX6DL based Boards
@@ -131,6 +141,13 @@ properties:
               - emtrion,emcon-mx6-avari   # emCON-MX6S or emCON-MX6DL SoM on Avari Base
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
+              - phytec,imx6qdl-pcm058     # PHYTEC phyCORE-i.MX6
+              - phytec,imx6dl-pbab01      # PHYTEC phyFLEX carrier board
+              - phytec,imx6dl-pbab01-nand # PHYTEC phyFLEX eval Kit
+              - phytec,imx6dl-pbac06      # PHYTEC phyBOARD-Mira with i.MX6 DL
+              - phytec,imx6dl-pbac06-emmc # PHYTEC phyBOARD-Mira eMMC RDK
+              - phytec,imx6dl-pbac06-nand # PHYTEC phyBOARD-Mira NAND RDK
+              - phytec,imx6dl-pfla02      # PHYTEC phyFLEX-i.MX6 DL
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
-- 
2.7.4

