Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9BE214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJZJJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:09:52 -0400
Received: from mout.perfora.net ([74.208.4.196]:38085 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfJZJJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:09:51 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.67.182]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mna9J-1hfdWD3j4H-00jWpj; Sat, 26 Oct 2019 11:04:21 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v2 2/5] dt-bindings: arm: fsl: add nxp based toradex apalis/colibri binding docu
Date:   Sat, 26 Oct 2019 11:04:00 +0200
Message-Id: <20191026090403.3057-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191026090403.3057-1-marcel@ziswiler.com>
References: <20191026090403.3057-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SnhVHRVvbDZqq57bt8ycn0RqZcXnZPwkFSn123IVncODo7yNFDn
 qt0vx1vlOB25lGok0cA11QDYKYIBSRZPmp+uDSGCPaPR9JHNp3fAZGSgoAN07B9WWEBbrDP
 Yq6tk2ASGCcm8KttiKkj7MeHU+QtzDfhQZPfSolnEfUibJGRgeffzIVcq7rjQUkdxXmWEsa
 qf41yRlidrQd5I9IUmpCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JP8W5Bkf7gE=:Br9CLWaDopBnyirVCMa7E2
 dV22OqZQckCSsAxU8E4JNog0x5emZ5kIYr0wWcuAYdleNXDfN+IOwbyl5ihSz6KEBegdrjt1W
 jkc3UDHotEzSEgZKnTBJNJcYyyEyW0X5z5kjzSG/7neJst474OwPPcwVxznzqmJS6TTKoWWuy
 XvFQQ3ZJaRdCY5XdBTK8DGn9j8NyLp86zJ1OAfNpjUR5WwZYqowWOuydSEDZ0dKLvCiuABMcs
 fE43TSFIdO/ih+v3Dm3bHVoc+5Nli719yHVCTp7PwUzZIDcbkZNjZoTPFL+wPEvgE/dGqMTUv
 UHUdBXOEl025uVd9iYsxN5ztacvd/2/qUZGOa0sgKz3nrVtdSvscrXV0cRWlqPRzLOXa3Jbi3
 BArdPRxZ5VnuR17MpTrAnUneRQ4/exmiN7rE4qA0BJTkfuKCTGlMIrnLXHbHJ420V5A1i90r4
 IRCqQFXmBtawgb9JmDM3R/yQotE2rXtFfycCr0g7P/Vt4eLfjmun+OtotLNV4ox6+IPPQhmhE
 kLXnAiUM4hQzE565NpJFtVKTT6VyGypENgOQFHUtpAR6mKD/s8Tf/q02lcLRyL5VP4gjftXRJ
 caOPAQsG0WdhD96ftjF3/SaXNPUCid/im8pXktqtEqKAtO9cLtJLDaI8HVRHdyLY8O8P2ox6T
 nqTH6Q5ELYBD//NUp/W/xqtfUzj/og+Uo3yFhWyVEkGOorY+Teh4Szv47zeJd6ErLoJc7yfC5
 zgljZ2YYju8n/L53h6jYtwtW4uptIzQ/Mt/LSfH5qKZ74kQOAvoQunDJump53GF/SQgEcMbXb
 nTz33BPaldWHv1K2mLhSqH+E7XlNOUY1rNLcTpIdmWJ1RrV1EJXdqGDiUBUEPSZvgObB+pHsy
 Joy+n1okAF6waSUEh0bOYNmSoIoG6ZGbyJUVoNTgg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Document the following NXP SoC based Toradex Apalis and Colibri module
and carrier board devicetree bindings already supported:
- toradex,apalis_imx6q            # Apalis iMX6 Module
- toradex,apalis_imx6q-eval       # Apalis iMX6 Module on Apalisi
				    Evaluation Board
- toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
- toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1

- toradex,colibri_imx6dl          # Colibri iMX6 Module
- toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri
				    Evaluation Board V3

- toradex,colibri-imx6ull-eval            # Colibri iMX6ULL Module on
					    Colibri Evaluation Board
- toradex,colibri-imx6ull-wifi-eval       # Colibri iMX6ULL Wi-Fi /
					    Bluetooth Module on Colibri
					    Evaluation Board

- toradex,colibri-imx7s           # Colibri iMX7 Solo Module
- toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on
				    Colibri Evaluation Board V3

- toradex,colibri-imx7d                   # Colibri iMX7 Dual Module
- toradex,colibri-imx7d-emmc              # Colibri iMX7 Dual 1GB (eMMC)
					    Module
- toradex,colibri-imx7d-emmc-eval-v3      # Colibri iMX7 Dual 1GB (eMMC)
                                            Module on Colibri Evaluation
					    Board V3
- toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on
					    Colibri Evaluation Board V3
- toradex,vf500-colibri_vf50              # Colibri VF50 Module
- toradex,vf500-colibri_vf50-on-eval      # Colibri VF50 Module on
					    Colibri Evaluation Board
- toradex,vf610-colibri_vf61              # Colibri VF61 Module
- toradex,vf610-colibri_vf61-on-eval      # Colibri VF61 Module on
					    Colibri Evaluation Board

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: New patch.

 Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 41db01d77c23..96b05484527e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -121,6 +121,10 @@ properties:
               - fsl,imx6q-sabresd
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
+              - toradex,apalis_imx6q            # Apalis iMX6 Module
+              - toradex,apalis_imx6q-eval       # Apalis iMX6 Module on Apalis Evaluation Board
+              - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
+              - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
           - const: fsl,imx6q
 
       - description: i.MX6QP based Boards
@@ -142,6 +146,8 @@ properties:
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
+              - toradex,colibri_imx6dl          # Colibri iMX6 Module
+              - toradex,colibri_imx6dl-eval-v3  # Colibri iMX6 Module on Colibri Evaluation Board V3
               - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
@@ -194,6 +200,8 @@ properties:
               - armadeus,imx6ull-opos6ul    # OPOS6UL (i.MX6ULL) SoM
               - armadeus,imx6ull-opos6uldev # OPOS6UL (i.MX6ULL) SoM on OPOS6ULDev board
               - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
+              - toradex,colibri-imx6ull-eval            # Colibri iMX6ULL Module on Colibri Evaluation Board
+              - toradex,colibri-imx6ull-wifi-eval       # Colibri iMX6ULL Wi-Fi / Bluetooth Module on Colibri Evaluation Board
           - const: fsl,imx6ull
 
       - description: i.MX6ULZ based Boards
@@ -206,6 +214,8 @@ properties:
       - description: i.MX7S based Boards
         items:
           - enum:
+              - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
+              - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on Colibri Evaluation Board V3
               - tq,imx7s-mba7             # i.MX7S TQ MBa7 with TQMa7S SoM
           - const: fsl,imx7s
 
@@ -214,6 +224,10 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
+              - toradex,colibri-imx7d                   # Colibri iMX7 Dual Module
+              - toradex,colibri-imx7d-emmc              # Colibri iMX7 Dual 1GB (eMMC) Module
+              - toradex,colibri-imx7d-emmc-eval-v3      # Colibri iMX7 Dual 1GB (eMMC) Module on Colibri Evaluation Board V3
+              - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on Colibri Evaluation Board V3
               - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
@@ -280,6 +294,10 @@ properties:
               - fsl,vf600
               - fsl,vf610
               - fsl,vf610m4
+              - toradex,vf500-colibri_vf50              # Colibri VF50 Module
+              - toradex,vf500-colibri_vf50-on-eval      # Colibri VF50 Module on Colibri Evaluation Board
+              - toradex,vf610-colibri_vf61              # Colibri VF61 Module
+              - toradex,vf610-colibri_vf61-on-eval      # Colibri VF61 Module on Colibri Evaluation Board
 
       - description: ZII's VF610 based Boards
         items:
-- 
2.21.0

