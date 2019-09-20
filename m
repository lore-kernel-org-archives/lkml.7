Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48949C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200CC207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 11:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="ncTnMbGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438317AbfITLw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 07:52:29 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:48852 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438304AbfITLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1568980347; x=1571572347;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YxMQ+eWkjel7628f0sdJqwnYptMi1NZAQO88k99cXso=;
        b=ncTnMbGGOeJDABR1sLq7Ukl05sb4SfJTZVToofa7swFn7urSUOP2lkIvfqAAgBa6
        t4Zns8VBXrvnUsx9DKc3qUnWOhTArhGOX9MNGBvIpr+cwbDJut2EqYAyFqFWZZFy
        J4vvX+lxrB4sc6h61ePi93/rqhxdh1/GXQZXivYx7/c=;
X-AuditID: c39127d2-e1bff70000001af2-9b-5d84bd7a3e07
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 03.19.06898.A7DB48D5; Fri, 20 Sep 2019 13:52:26 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019092013522608-76271 ;
          Fri, 20 Sep 2019 13:52:26 +0200 
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
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL devicetree bindings
Date:   Fri, 20 Sep 2019 13:52:25 +0200
Message-Id: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 20.09.2019 13:52:26,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 20.09.2019 13:52:26,
        Serialize complete at 20.09.2019 13:52:26
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWyRoCBS7dqb0uswbUH6hbNHbYW84+cY7V4
        eNXfYtPja6wWXb9WMltc3jWHzeJuSyerxdLrF5ksWvceYbf4u30Ti8WLLeIO3B5r5q1h9Ng5
        6y67x6ZVnWwed67tYfPYvKTeY+O7HUwe/X8NPD5vkgvgiOKySUnNySxLLdK3S+DK2Pz/PFPB
        Jb6KO3PXsTYwXuTqYuTkkBAwkVj9tJOti5GLQ0hgB6PE4l9boZxzjBIXXjazglSxCRhJLJjW
        yARiiwhoSEzpeswOUsQsMJVZovHPUqAiDg5hgSiJc/2FIDUsAqoSPUfXs4HYvAIeEnueP2CB
        2CYncfNcJzNIr4RAI5PEik3bmCESQhKnF59lnsDIs4CRYRWjUG5mcnZqUWa2XkFGZUlqsl5K
        6iZGYNgdnqh+aQdj3xyPQ4xMHIyHGCU4mJVEeOeYNsUK8aYkVlalFuXHF5XmpBYfYpTmYFES
        593AWxImJJCeWJKanZpakFoEk2Xi4JRqYJT6pS/w7OUHrs92P12nOe8SCOraKvBxO7/HxUtn
        5kXa2Pk+nH/70Y9P2nd2iTf/O/yBOyVO3c6PdZZxpfbyeoGGf1XfJx7enxI997RitjzH/K0/
        TwQmvTXg7OU6d6hU1zdixb+vbOrcgituaRv3vm2Yz347xUu9prE76GZjvteRyZbyz6UNJiix
        FGckGmoxFxUnAgAVo78vKQIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
phyBOARD-Segin.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
Changes in v2:
 - Use seperate description for each board instead of squashing them into
   the standard board.
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1b4b4e6573b5..c926ff6eac67 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -164,6 +164,15 @@ properties:
               - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
           - const: fsl,imx6ul
 
+      - description: i.MX6UL PHYTEC phyBOARD-Segin
+        items:
+          - enum:
+              - phytec,imx6ul-pbacd10-emmc
+              - phytec,imx6ul-pbacd10-nand
+          - const: phytec,imx6ul-pbacd10  # PHYTEC phyBOARD-Segin with i.MX6 UL
+          - const: phytec,imx6ul-pcl063   # PHYTEC phyCORE-i.MX 6UL
+          - const: fsl,imx6ul
+
       - description: Kontron N6310 S Board
         items:
           - const: kontron,imx6ul-n6310-s
@@ -183,6 +192,15 @@ properties:
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
           - const: fsl,imx6ull
 
+      - description: i.MX6ULL PHYTEC phyBOARD-Segin
+        items:
+          - enum:
+              - phytec,imx6ull-pbacd10-emmc
+              - phytec,imx6ull-pbacd10-nand
+          - const: phytec,imx6ull-pbacd10 # PHYTEC phyBOARD-Segin with i.MX6 ULL
+          - const: phytec,imx6ull-pcl063  # PHYTEC phyCORE-i.MX 6ULL
+          - const: fsl,imx6ull
+
       - description: i.MX6ULZ based Boards
         items:
           - enum:
-- 
2.7.4

