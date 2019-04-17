Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17756C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90D82173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfDQNaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:30:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43365 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQNaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:30:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id j20so10774106edq.10;
        Wed, 17 Apr 2019 06:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vay1Xcn3qQLP8JZ9CpAgKgmvh83bqOteFhv69Rgc3sQ=;
        b=EIVv90V3X3mvfOw/sMuhfvzaYjdDLFB3X903is3EH6bOT+mZ9JwkxXOqgw5imiwrIQ
         Tz+Je+rEKNrVDEZkhFSRVEW5/T2O9PXALMCmytSfG8AyBEsIFLMKnY8uGxf8ndPdnTLE
         76E0sYt+LiprWo2QR2OZbyjAbTyAVaMPNAXIFyJ4+/NroAC+R5LZIy54ZZ35MULN417M
         dtUIMJCS34hpMwhTaSSHA1hoHpCDD6eJVStKftpAMEkYy8Kq20qOcj6Xq98Pp5jl0U1C
         QseX2/Tn0OMK3uLsg8Y3HxnEymFoTqVHYTndnq9a6/gjQsjhv+0REGm/tiSYxU+2flN0
         Vg7w==
X-Gm-Message-State: APjAAAXL/HyFIMbjBsYfzJrzEBh7c8rfCPW+aXvwBTUNHJMNCoApAh+u
        LfR4lpT88Njx7JYXweNhyg3HNbHQ
X-Google-Smtp-Source: APXvYqxbmk/qbOPiFj76DQte2Aq4QGzVJE7wbesCl+pLx14Hq17SS9ACZTSS5DPfeTySpjkRlXpNxA==
X-Received: by 2002:a17:906:4892:: with SMTP id v18mr45587920ejq.81.1555507819576;
        Wed, 17 Apr 2019 06:30:19 -0700 (PDT)
Received: from localhost ([46.140.72.82])
        by smtp.gmail.com with ESMTPSA id y41sm2432688edd.96.2019.04.17.06.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 06:30:18 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@toradex.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-imx@nxp.com
Cc:     marc.w.gonzalez@free.fr, jonathanh@nvidia.com,
        thierry.reding@gmail.com, festevam@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, marcel@ziswiler.com,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: [PATCH v4 2/2] ARM: dts: tegra124-apalis: convert to SPDX license tags
Date:   Wed, 17 Apr 2019 15:30:15 +0200
Message-Id: <20190417133015.6168-2-igor.opaniuk@toradex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417133015.6168-1-igor.opaniuk@toradex.com>
References: <20190417133015.6168-1-igor.opaniuk@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license
identifiers in Colibri/Apalis DTS files.

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---
v4:
- Fix typo in the SPDX tag, noticed by Marc (probably was introduced when
  manually removing unneeded brackets)

v3:
- Add Marcel's Acked-by tag
- Remove un-needed parentheses in SPDX line
- Replace MIT with GPL-2.0 in tegra124-apalis-emc.dtsi

v2:
- Address Stefan's comment: replace GPL-2.0+ instead GPL-2.0

 arch/arm/boot/dts/tegra124-apalis-emc.dtsi | 39 ++-------------------
 arch/arm/boot/dts/tegra124-apalis-eval.dts | 40 ++--------------------
 arch/arm/boot/dts/tegra124-apalis.dtsi     | 40 ++--------------------
 3 files changed, 6 insertions(+), 113 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
index ca2c3a557895..d18eaf4a4a3a 100644
--- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
@@ -1,42 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2019 Toradex AG
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 / {
diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index eaee10ef6512..ceb3f6388c7d 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Copyright 2016-2018 Toradex AG
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2016-2019 Toradex AG
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index 13c93cd507d8..fdc8a4c5aab6 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1,42 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Copyright 2016-2018 Toradex AG
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2016-2019 Toradex AG
  */
 
 #include "tegra124.dtsi"
-- 
2.17.1

