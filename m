Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4688C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D22D214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCMOU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:20:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52696 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCMOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:20:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id f65so2245014wma.2;
        Wed, 13 Mar 2019 07:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=RzB59qgV2YUVM0X625xxjyqZUQ4252nA0RceHe2lxvQ=;
        b=Uxo3B1eOMJd2xc8+rm4JnHr+ziIedeM3sS3xlzK/4EUEowEN8OVbMg0vVTzxsv8boh
         7sSPbsA3QP0VOgmsfUDp29w8HU4z2t/AsgBm7vGCj7D/PQHSrQqRWQVdwupCqgR5mtn2
         fSN0yLih42Vva59cZ4rI0zYqQPiTeuAS8DP3hbVsYFqmN1TXURLghO9MLczsl0go7pOG
         GNAGS9Nz+1LB0/J9xCTb+SlfiVw1fQ5sd+Bwe9zgppN/BM8VyK9K5l59gDrLrJmWySea
         ufjDjExAo/H70tFG0nafFijlLl32t4eGJHKoiK42Kw7pTSutxbrujlCmWk+ei9fi/Hkd
         sR/Q==
X-Gm-Message-State: APjAAAVDyq3TPzHXnSMa9HCHG9AAiA+pW7wmdFgrZYp8ADTuFDDs+zNs
        1E9nTKV0/f3sbksl0rYl9og=
X-Google-Smtp-Source: APXvYqx4eVLrIseMtqPPTN/emCjQpU1+197sZUW1w/f4GcMgevPg8TADkD2BlMRxiITgNI1yYiDd/A==
X-Received: by 2002:a1c:9ed5:: with SMTP id h204mr1331267wme.35.1552486853626;
        Wed, 13 Mar 2019 07:20:53 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id v20sm6933598wmj.2.2019.03.13.07.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:20:52 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, kernel@pengutronix.de, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christina Quast <cquast@hanoverdisplays.com>
Subject: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
Date:   Wed, 13 Mar 2019 15:20:40 +0100
Message-Id: <20190313142040.26694-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
Reply-To: VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
the documentation.

Changes since v2:
* Changed patch title to 'dt-bindings: pinctrl: imx7d:'

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
index 6666277c3acb..8ac1d0851a0f 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
@@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
 PAD_CTL_SRE_SLOW                (1 << 2)
 PAD_CTL_SRE_FAST                (0 << 2)
 PAD_CTL_DSE_X1                  (0 << 0)
-PAD_CTL_DSE_X2                  (1 << 0)
-PAD_CTL_DSE_X3                  (2 << 0)
-PAD_CTL_DSE_X4                  (3 << 0)
+PAD_CTL_DSE_X4                  (1 << 0)
+PAD_CTL_DSE_X2                  (2 << 0)
+PAD_CTL_DSE_X6                  (3 << 0)
 
 Examples:
 While iomuxc-lpsr is intended to be used by dedicated peripherals to take
-- 
2.20.1

