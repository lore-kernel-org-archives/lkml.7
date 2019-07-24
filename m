Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB4C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9D12199C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="StlJr2+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfGXHti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:49:38 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:49592 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfGXHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1563954573; x=1566546573;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GkR5GGl5v3m2lg+nnRP8KreJpKlg7Nz9sjmaDxmgFO4=;
        b=StlJr2+TpY9igB8ZZ2fZU2f6knrn/HeyQZ/Y3eKOyTdYB0d9vHsGIR1AeD/lkv3X
        f2FuJIx8o5OE6DnH9oOaz0Iw3ahLjKfG2ZcF20+neuMdDuGKd1h0UC1MKUh0+GxN
        3WC0fvhiy7B5CGtL38MmIdYInFonG41rk+Gd5R0xG6k=;
X-AuditID: c39127d2-17dff70000001aee-b4-5d380d8df363
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5C.CA.06894.D8D083D5; Wed, 24 Jul 2019 09:49:33 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019072409493347-408984 ;
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
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL devicetree bindings
Date:   Wed, 24 Jul 2019 09:49:32 +0200
Message-Id: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2019 09:49:33,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 24.07.2019 09:49:33,
        Serialize complete at 24.07.2019 09:49:33
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsWyRoCBS7eX1yLW4M4ePYvmDluL+UfOsVo8
        vOpvsenxNVaLrl8rmS0u75rDZnG3pZPVYun1i0wWrXuPsFv83b6JxeLFFnEHbo8189Yweuyc
        dZfdY9OqTjaPO9f2sHlsXlLvsfHdDiaP/r8GHp83yQVwRHHZpKTmZJalFunbJXBlXPmQXbCW
        p2LxrnvsDYyNnF2MnBwSAiYSz3Z/Y+ti5OIQEtjBKLH78SVGCOcio8TR/6vYQKrYBIwkFkxr
        ZAKxRQQ0JKZ0PWYHKWIWmMos0fhnKStIQlggXOLC/kcsIDaLgKrE+zsLmbsYOTh4BTwktqwu
        gtgmJ3HzXCczSK+EQCOTRPvH0+wQCSGJ04vPMk9g5FnAyLCKUSg3Mzk7tSgzW68go7IkNVkv
        JXUTIzDoDk9Uv7SDsW+OxyFGJg7GQ4wSHMxKIryBDWaxQrwpiZVVqUX58UWlOanFhxilOViU
        xHk38JaECQmkJ5akZqemFqQWwWSZODilGhi1Y4rPGNvz5Z0WdWQ5ZZchOnt/3YeDa5M0VrTM
        O5k9hVsgaHpf1Wa933Zv7B1txXP3zWGumhJqZSLgFHw702DnIbNTkyZMl/rYUuDyeduuqutH
        5Fdd1zotWyTB0/vJQ0hq7c51l6M1FJn4kt7cc96hfaq+XfKwADtLKofYp1/W/srWrFm/KpRY
        ijMSDbWYi4oTAWh320YoAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
phyBOARD-Segin.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..40f007859092 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -161,12 +161,20 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - phytec,imx6ul-pbacd10     # PHYTEC phyBOARD-Segin with i.MX6 UL
+              - phytec,imx6ul-pbacd10-emmc  # PHYTEC phyBOARD-Segin eMMC Kit
+              - phytec,imx6ul-pbacd10-nand  # PHYTEC phyBOARD-Segin NAND Kit
+              - phytec,imx6ul-pcl063      # PHYTEC phyCORE-i.MX 6UL
           - const: fsl,imx6ul
 
       - description: i.MX6ULL based Boards
         items:
           - enum:
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
+              - phytec,imx6ull-pbacd10    # PHYTEC phyBOARD-Segin with i.MX6 ULL
+              - phytec,imx6ull-pbacd10-emmc # PHYTEC phyBOARD-Segin eMMC Kit
+              - phytec,imx6ull-pbacd10-nand # PHYTEC phyBOARD-Segin NAND Kit
+              - phytec,imx6ull-pcl063     # PHYTEC phyCORE-i.MX 6ULL
           - const: fsl,imx6ull
 
       - description: i.MX6ULZ based Boards
-- 
2.7.4

