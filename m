Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2AEC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0020896
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfDGThe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:37:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36064 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDGThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:37:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so4719516qtn.3;
        Sun, 07 Apr 2019 12:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=lKa0kTuBJCCDoi0EkAcWbABrq8cjB/DTAn2Y5DTAvcw=;
        b=rxEIa5OhcIgZ1fGDuiVr+YSolB429WX0cZf47fE27uW8cZURgGsJrosqAVoK/qnJkL
         yJj6DZJ5mJjenUPCqzcc9TwKsm3z0eie1SeVVrimpZYVpXAKNXuqYwCalvw1AMwv8+VC
         CrJQwy1oQxCzaCVTNmoaNcB4/esUW9E9yba3t4tEvBMWG9NNLc4vGo5jyRqmboHIWTEO
         OmzAh2X4RsKS/el2qQ6VQELhPBDZIwqtuIoOJMPe6bXlv6seSSgIyytxlQIhOhx3Rba4
         D1VZFihi0STGRl2WsZfMzCw+lG+TsOvXm4GMeVf6NKd/3zoktiittCsjZxKEFaSJBQSy
         bGiw==
X-Gm-Message-State: APjAAAVgdWQXx3fOR7R9T3qc/V2itiJQECY3eG4xHsoetxFyUCjXWpAe
        Irizr1j0xFTrJYiTfujtBJo=
X-Google-Smtp-Source: APXvYqwAJpPv8ZutXqddz0OT8B73TPF22dx0SMCCmKrKKnL9dbdTFcKkO4GDTge6aqwrF3VAA/WjCg==
X-Received: by 2002:ac8:1846:: with SMTP id n6mr20534865qtk.262.1554665852521;
        Sun, 07 Apr 2019 12:37:32 -0700 (PDT)
Received: from localhost.localdomain ([177.194.204.148])
        by smtp.gmail.com with ESMTPSA id n41sm18709087qtf.63.2019.04.07.12.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 12:37:31 -0700 (PDT)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 07 Apr 2019 16:37:24 -0300
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Vok=C3=A1=C4=8D=20Michal?= <Michal.Vokac@ysoft.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add support for imx6ul-pico-dwarf
Date:   Sun,  7 Apr 2019 16:37:22 -0300
Message-Id: <20190407193723.3351-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Add support for TechNexion's imx6ul-pico-dwarf board.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 3c7ad36ebd35..944687df45b8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -123,6 +123,7 @@ properties:
         items:
           - enum:
               - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
+              - technexion,imx6ul-pico-dwarf # i.MX6 UltraLite Pico Dwarf Board
           - const: fsl,imx6ul
 
       - description: i.MX6ULL based Boards
-- 
2.21.0

