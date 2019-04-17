Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA2C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EED206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfDQJK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:10:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35802 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfDQJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:10:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so7047679ede.2;
        Wed, 17 Apr 2019 02:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0+7xcGZRqelDPiwS5L87j2WAw5tvLmwypWHfn/qw6pY=;
        b=VwJQTEXB+TvkgSNVuVwdcJiRZmNuBN8IGH/8soy3p2JeZY6Jn47OCKV3jxesqH8njK
         x5jC/xMQN0oHFKp2bPRJo5HI/pfTbYaSjwKGJDBtp2RIunTm5awajp4W2hGq+6KRpOEj
         NUD2cQUPgkksXj29zJOYDW/qdN2fcmY+alscpo83JLTsrojmv8jDbA/dtcU4eGPLJPPl
         MOxRTOI2nsdICfw/Nvc7StiTvJ4R2JQCcNYy9Vykx2ZLWSuqoMeP55+oTHTRLuS9RO5N
         2X2duT+ImKAzUXyCNTeRWvRSRjOa4qvdlDOON4EtkZ7HZBzWc7zLfSrqYwUZYTUnI7N9
         HWLg==
X-Gm-Message-State: APjAAAUaYC0zVjVXMbElI2buDCgNe1O73dQ/vt+DP8az4HkvqC/ja58i
        1JiQ8tUOR6+XgKoxTc4vok6lvI7G
X-Google-Smtp-Source: APXvYqxJSDUIkIvhP0v8MZL6rT0Q8h5S1vZ3moJ+OUiZp/Xpjdg7i5blIqN17Nx4pfhwF7KxzbLztA==
X-Received: by 2002:a50:ac76:: with SMTP id w51mr15663921edc.13.1555492224793;
        Wed, 17 Apr 2019 02:10:24 -0700 (PDT)
Received: from localhost ([46.140.72.82])
        by smtp.gmail.com with ESMTPSA id g91sm1008162ede.41.2019.04.17.02.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 02:10:24 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@toradex.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-imx@nxp.com
Cc:     jonathanh@nvidia.com, thierry.reding@gmail.com, festevam@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, marcel@ziswiler.com,
        marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: [PATCH v3 2/2] ARM: dts: tegra124-apalis: convert to SPDX license tags
Date:   Wed, 17 Apr 2019 11:10:22 +0200
Message-Id: <20190417091022.14167-2-igor.opaniuk@toradex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417091022.14167-1-igor.opaniuk@toradex.com>
References: <20190417091022.14167-1-igor.opaniuk@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license
identifiers in Colibri/Apalis DTS files.

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

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
index ca2c3a557895..57d82f54cb44 100644
--- a/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-emc.dtsi
@@ -1,42 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR GPL
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

