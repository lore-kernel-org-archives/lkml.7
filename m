Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33355C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8E721994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564184671;
	bh=yWxWBz+n/FglaRlNQjOLwl4G1oo9xmWPi4dnFejpz3E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i40hKlWrOD5tE1fZkjwmpC6ySKB72iocgW3mxGRI2WC7SxVpb4fUTSnqMJCfHpPBL
	 I815QUPH7dmmtP2VJYYP8wKIUtwm3JEue4atcGMKGmBmOpNJ2yZLY9i7d0CAMjM47p
	 SiT3epSsFyutjCIvyaYd/02kjeITZYoZRZI+DOmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfGZXo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:44:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42784 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfGZXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:44:29 -0400
Received: by mail-io1-f68.google.com with SMTP id e20so77791053iob.9;
        Fri, 26 Jul 2019 16:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=isOGfonjSVlz/20It2ApZb+DJMa7oypnD9utkEMLW8A=;
        b=U+fSrliFl0j2dfnW9kp8Z/JDaN4mSf21VK3ykFsSd4I7wcGjzCMAjxDqKKgHcT0x44
         YjgZtMGlrhFgZxjUvehj4cpHOEc9BOoyV+X8VP1wAD3YNUoXCjz9UxIF4955K9INHk2M
         V/jLWiTikS9sewRLJts2GarJZAGf4npi9G5YouV/rV1xduktvs6p4TGkN4nUKeJid2U5
         JQfh005t1SUCjWqBq1bvKwd8NEiPBvKArZirZhRQY0/oqfY/g8nUInnsCMCCd60tLZlQ
         qov7aLtVQRTtiZv+cgBlJuhAyL+mrhg8jGvOA6ny1CW/qjRxDbfVIK3H3Ohaev85hs1I
         AYDw==
X-Gm-Message-State: APjAAAUkdmmFPghkmk/ktPXOKVPsLm52uqSpxCnK+t1v7lIFhx/KK9XH
        xUoF3yge+THNwZ1Ji7I2rcpbR2Q=
X-Google-Smtp-Source: APXvYqxqOigAeDJ+2leQBiW4TqZw24zT+ar5DyGuvO6nrp/2jiBfdDy6PdfQH670DHIRG7tvxuUNjA==
X-Received: by 2002:a05:6638:149:: with SMTP id y9mr100565982jao.76.1564184667858;
        Fri, 26 Jul 2019 16:44:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id e84sm65576304iof.39.2019.07.26.16.44.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 16:44:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Fix more $id value mismatches filenames
Date:   Fri, 26 Jul 2019 17:44:26 -0600
Message-Id: <20190726234426.16267-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path in the schema '$id' values are wrong. Fix them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/renesas.yaml              | 2 +-
 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml   | 2 +-
 Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml        | 2 +-
 .../firmware/intel,ixp4xx-network-processing-engine.yaml        | 2 +-
 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml    | 2 +-
 Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml    | 2 +-
 .../bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml   | 2 +-
 ...x-queue-manager.yaml => intel,ixp4xx-ahb-queue-manager.yaml} | 2 +-
 .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml      | 2 +-
 .../devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml  | 2 +-
 Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/devicetree/bindings/misc/{intel,ixp4xx-queue-manager.yaml => intel,ixp4xx-ahb-queue-manager.yaml} (95%)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/arm/renesas.yaml
index 08c923f8c257..28eb458f761a 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/arm/renesas.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/shmobile.yaml#
+$id: http://devicetree.org/schemas/arm/renesas.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
index aae53fc3cb1e..2bd519d2e855 100644
--- a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
+++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
+$id: http://devicetree.org/schemas/arm/socionext/milbeaut.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Milbeaut platforms device tree bindings
diff --git a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
index 4326d2cfa15d..a8765ba29476 100644
--- a/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/ti,davinci.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/ti/davinci.yaml#
+$id: http://devicetree.org/schemas/arm/ti/ti,davinci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments DaVinci Platforms Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
index 8cb136c376fb..4f0db8ee226a 100644
--- a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
+++ b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/firmware/intel-ixp4xx-network-processing-engine.yaml#"
+$id: "http://devicetree.org/schemas/firmware/intel,ixp4xx-network-processing-engine.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Intel IXP4xx Network Processing Engine
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
index 7ba167e2e1ea..c602b6fe1c0c 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl345.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
index a7fafb9bf5c6..e7daffec88d3 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl372.yaml#
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl372.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
index bae10e261fa9..507c141ea760 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ixp4xx-interrupt.yaml
@@ -2,7 +2,7 @@
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/interrupt/intel-ixp4xx-interrupt.yaml#"
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ixp4xx-interrupt.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Intel IXP4xx XScale Networking Processors Interrupt Controller
diff --git a/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml b/Documentation/devicetree/bindings/misc/intel,ixp4xx-ahb-queue-manager.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
rename to Documentation/devicetree/bindings/misc/intel,ixp4xx-ahb-queue-manager.yaml
index d2313b1d9405..0ea21a6f70b4 100644
--- a/Documentation/devicetree/bindings/misc/intel,ixp4xx-queue-manager.yaml
+++ b/Documentation/devicetree/bindings/misc/intel,ixp4xx-ahb-queue-manager.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/misc/intel-ixp4xx-ahb-queue-manager.yaml#"
+$id: "http://devicetree.org/schemas/misc/intel,ixp4xx-ahb-queue-manager.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Intel IXP4xx AHB Queue Manager
diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index d4084c149768..3fb0714e761e 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-gmac.yaml#
+$id: http://devicetree.org/schemas/net/allwinner,sun8i-a83t-emac.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner A83t EMAC Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index 250f9d5aabdf..fa46670de299 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/display/allwinner,sun6i-a31-mipi-dphy.yaml#
+$id: http://devicetree.org/schemas/phy/allwinner,sun6i-a31-mipi-dphy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner A31 MIPI D-PHY Controller Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
index a36a0746c056..2807225db902 100644
--- a/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/intel,ixp4xx-timer.yaml
@@ -2,7 +2,7 @@
 # Copyright 2018 Linaro Ltd.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/timer/intel-ixp4xx-timer.yaml#"
+$id: "http://devicetree.org/schemas/timer/intel,ixp4xx-timer.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Intel IXP4xx XScale Networking Processors Timers
-- 
2.20.1

