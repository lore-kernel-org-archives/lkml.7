Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B6FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5852B2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDJBAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:00:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47027 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDJBAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:00:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so900150qts.13;
        Tue, 09 Apr 2019 18:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=yLGcc+u98VuKczPPhfSnrlkdE/sOqLgztdm+Z5rTmbc=;
        b=NQs28qeKuRK1yMv+87SMdrwZtoS3b3rxWHNWrQrhbHDM6Qvz32rO+Jrn1P6kPHTGqM
         tG8gsCzsVl27lLWjdTfg0LhsTjRZ3Pr5++0ogvrOJ95vxfRbpN13eoE2/Mx20L1ov2SM
         eAXHKjbpJX8QX7EaBxXmDMU+j8oxere8biA/zIwNtv80aL6jkThjKDCrmodowGOlLDfJ
         uiBwaPWLLwSlFHorcgQFcUmuL8K55f4z9pT9/4EsNuJrTL21ugvwRP2XZp35IXFCJQLb
         plJKpB01H6/fT7hDAZBrE2RboajCnfR3VA4xHUR0kvTP8yAVinbzyG5KYdspU6OZcvMD
         By+w==
X-Gm-Message-State: APjAAAWFbwmb/6+pTPy2CZa0Zns2EOXJbKPQVK87U9QtoLHgbDzmd355
        KEqsDXySHeu7NK1sMMbohacSGvi5+u8=
X-Google-Smtp-Source: APXvYqzwGdmCMeg5uWkEUbKXU4pbzAR9SUxNXGPfMticlok3Tg0kBdMKOrRDghxUf520XPU/p6ap4g==
X-Received: by 2002:ac8:3782:: with SMTP id d2mr32497932qtc.170.1554858021328;
        Tue, 09 Apr 2019 18:00:21 -0700 (PDT)
Received: from localhost.localdomain ([177.194.197.186])
        by smtp.gmail.com with ESMTPSA id p27sm19864517qte.25.2019.04.09.18.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 18:00:20 -0700 (PDT)
Received: by localhost.localdomain (sSMTP sendmail emulation); Tue, 09 Apr 2019 22:00:14 -0300
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add support for imx6ul-pico-nymph
Date:   Tue,  9 Apr 2019 22:00:12 -0300
Message-Id: <20190410010013.17259-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for TechNexion's imx6ul-pico-nymph board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 944687df45b8..f19ca45a9333 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -124,6 +124,7 @@ properties:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
               - technexion,imx6ul-pico-dwarf # i.MX6 UltraLite Pico Dwarf Board
+              - technexion,imx6ul-pico-nymph # i.MX6 UltraLite Pico Nymph Board
           - const: fsl,imx6ul
 
       - description: i.MX6ULL based Boards
-- 
2.21.0

