Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A53C3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0906424653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151308;
	bh=Y7L88PCTUdeR29N/KZb0qXw8Sim4EahW7H2Nh1Q54qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QotP5uSxAYjICu9xs+t/Tn2Bd1K7INf1qtrgvdi2yilZdJ/Z1WGrZIdqXWrMvKph0
	 K2U0c+QSTtj5O+XCAq8/C1V+gSCTMdO5FYHCj28cWM5jTO84jPjocor1Ou8KIWYYbg
	 zZOSJ274+ShLjY7FlcXTaSR8p+i8KCisqhj6j66w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgADPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgADPVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:21:46 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC8D2464E;
        Sat,  4 Jan 2020 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151305;
        bh=Y7L88PCTUdeR29N/KZb0qXw8Sim4EahW7H2Nh1Q54qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=df4GISARj1IPmd74Ka2Y0gJovuqv1YPjFUbPDMoGbRVrTZPESYqMSNUICPVE/5V4m
         fYddVW0ZVE5imK6jc+V8RlJahRCRWbfwXV8twb1nm8zMr07AvFsJd4ICRSyzsR4XXq
         3iRzwo49M9TdG+vf4VUhXPK3wmYTJGkUIdSoCk6c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 02/20] arm64: dts: exynos: Rename Samsung and Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:20:49 +0100
Message-Id: <20200104152107.11407-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
and "Exynos" names.

"SAMSUNG" and "EXYNOS" are not abbreviations but regular trademarked
names.  Therefore they should be written with lowercase letters starting
with capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts        | 2 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 4 ++--
 arch/arm64/boot/dts/exynos/exynos7.dtsi               | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 6f90b0e62cba..250fc01de78d 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG Exynos5433 TM2 board device tree source
+ * Samsung Exynos5433 TM2 board device tree source
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index dda5d2746a74..fdd0796b29d4 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG Exynos5433 TM2 board device tree source
+ * Samsung Exynos5433 TM2 board device tree source
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
index 1e207ce8b97b..089fc7a1af67 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG Exynos5433 TM2E board device tree source
+ * Samsung Exynos5433 TM2E board device tree source
  *
  * Copyright (c) 2016 Samsung Electronics Co., Ltd.
  *
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 080e0f56e108..7af288fa9475 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG Exynos7 Espresso board device tree source
+ * Samsung Exynos7 Espresso board device tree source
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -13,7 +13,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
+	model = "Samsung Exynos7 Espresso board based on Exynos7";
 	compatible = "samsung,exynos7-espresso", "samsung,exynos7";
 
 	aliases {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 3a00ef0a17ff..5558045637ac 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS7 SoC device tree source
+ * Samsung Exynos7 SoC device tree source
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
-- 
2.17.1

