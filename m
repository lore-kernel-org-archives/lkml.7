Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D896CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7D5206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfJZJJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:09:59 -0400
Received: from mout.perfora.net ([74.208.4.197]:51449 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfJZJJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:09:58 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.67.182]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MtOvi-1i8XKM3ubG-00uuii; Sat, 26 Oct 2019 11:04:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 5/5] dt-bindings: arm: fsl: add nxp based toradex colibri-imx8x binding docu
Date:   Sat, 26 Oct 2019 11:04:03 +0200
Message-Id: <20191026090403.3057-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191026090403.3057-1-marcel@ziswiler.com>
References: <20191026090403.3057-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bX9HNyHJ2OSAyFglxRaJspgI6OSjyBfQQSuD0XdDtTI4TWnKc24
 wlzYNPkMS633MF86DtW9rj9tP4xAxPTc2ve3WaAXG1K3JAEgu6lcyLPo6NdVxOVSA7Q8Kyu
 KgzB8RrdN4G6ORRgFeH/woWMlqRMcbQ4zPZrAfo42b0v8aS23luT2LIYab/94jMyQdoAcl5
 /RQSYZCRQcG6Yb1hUftNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:30zXfR9Ln78=:noGF7yu1eaQn3Tc+PASm/3
 +SGwvl6tjFtIL8WNVYrFqXFonn8nGrKNlaUYShuUNISb7Be6uGuJRTn2moY22dhFg+vOX8ZmH
 2DK5OSA3SlXuzoi4WCjm/nSBTfd8TSAPkiP0VBkqmflnUPg72JGnOjbZTN2uY6ZhQ+FsPe/Am
 YozUHGVEYmo5kYukHpZWfr/UlTHyDIVaPYiyaVpj5GuVa+sgSYGDeqAi3gQjWvOF38rfqQEcA
 MpI7cGh1XgTu9X512d2fQC4h8QTfPYr/f4jUkQk3ficL/Fa1fPKqr9CoOc3FtBr1y6V4nNRx6
 IROEXn414X8wvyuZuF13HLj0YouZfGbaCCA4+W/LwS5hrBrjwYZLNC1ksZ/VvXLfBDxZZMba7
 5EcBXc3SWEInGf67Fl+XOsFRV3b06m69QJzrkTUutvX1zzD/VwiaTRAuruUkbd7/Jf8JvggJt
 89VIOuTtWetJtsyslxXbIS7NZ9L3VSyE8eqdL6gLD+RevXtLycsXCB7hWB5I/FjHz3aGLu1XV
 tqALcRNCnQ4D0uS5WhD4E3eAeiEHb0XGPOkBOVMkoPnKs4niBxkCt5BurkQgB0Bxof5SKrosO
 +XXh1qjoV3ODhEA/t7quqdtBggxWsEnpzeRrKkq67Qjb0qtNUob470IucrTf8gmfpKGn+x8pu
 YFtoywUmGvCIFiRh4lTpoq//j7ua05HnxujFx/jQpxNRE/6uioRXQ0aFstPBAvBMn9i8KHxEA
 MLME8OHc9a0ON3TD32iuJAzdjCsHNxvirNHzt/htt5n4sm08TjlOXLZAL2a+t85zSjloLXvUD
 UB/MbAOSVCR+YRGf3zEyLnSXEVaadTaJaoWKNSb2snqou75ULdrf4PrXhiziNLBG2DVj2RuOx
 8KP5gN6Ta3+dxaT2WU0Ad7d9SDBkmKhoCeKqFNu9U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Document the NXP SoC based Toradex Colibri iMX8X module and carrier
board devicetree bindings previously added.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Document board compatibles in a separate patch as suggested by Shawn.

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 96b05484527e..c835a6fba1bf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -277,6 +277,8 @@ properties:
           - enum:
               - einfochips,imx8qxp-ai_ml  # i.MX8QXP AI_ML Board
               - fsl,imx8qxp-mek           # i.MX8QXP MEK Board
+              - toradex,colibri-imx8x         # Colibri iMX8X Module
+              - toradex,colibri-imx8x-eval-v3 # Colibri iMX8X Module on Colibri Evaluation Board V3
           - const: fsl,imx8qxp
 
       - description:
-- 
2.21.0

