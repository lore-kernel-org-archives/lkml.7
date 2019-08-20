Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB898C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D422CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566315335;
	bh=O5BJM36vV0I5T579jUJLWV9wMi+teCTJ4h8AkHVrK/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MwIEEPUyFVI3HWJ5PUKWY6PrZo4hxX2GGOYMibXw+zjolKA5TnWWKYpr/V71O5xoR
	 9fO86p2cacBq3VNdE3UcXXad+PlkH604kgYS91csky6GQUNYAiOzYtGrQV2s/8nwzn
	 78CCVflcPIku7aEQxIULZPTsQKMAxRq7H43rNwNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfHTPfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729956AbfHTPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:35:32 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B425205C9;
        Tue, 20 Aug 2019 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566315331;
        bh=O5BJM36vV0I5T579jUJLWV9wMi+teCTJ4h8AkHVrK/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRNbjOygskgqdM9MCsLJPCgiV0cXhXO2R+G9sEn/jBWhoops4lucba3+JiFowTGn6
         fDG7rY1247jpG4EGIUI7TiOUBKxZNrFtLcyKoeXzpO21B3dSzOZVYW568294GwiZnF
         4u/UqpdCmmstYhskTQnM0o7vtWDMmgmRORvpT14M=
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
Subject: [PATCH v6 3/4] dt-bindings: arm: fsl: Add Kontron i.MX6UL N6310 compatibles
Date:   Tue, 20 Aug 2019 17:35:17 +0200
Message-Id: <1566315318-30320-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566315318-30320-1-git-send-email-krzk@kernel.org>
References: <1566315318-30320-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibles for Kontron i.MX6UL N6310 SoM and boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v5:
New patch
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7294ac36f4c0..d07b3c06d7cf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -161,6 +161,9 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - kontron,imx6ul-n6310-som  # Kontron N6310 SOM
+              - kontron,imx6ul-n6310-s    # Kontron N6310 S Board
+              - kontron,imx6ul-n6310-s-43 # Kontron N6310 S 43 Board
           - const: fsl,imx6ul
 
       - description: i.MX6ULL based Boards
-- 
2.7.4

