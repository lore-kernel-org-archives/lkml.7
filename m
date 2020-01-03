Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B5820866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071521;
	bh=oHfzo/HLcd7ztLldtrLgjwS2veYiZ28vrLG8OXZd81w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7v1ThYR0+B9lxlrjPszUAW/aMkhoTjdmP8b38DG0A3PT+XGqALoHf2ooATAXrjfr
	 U8iZSZpePb8lhVoxVLjCwzWEp19jsZfroDjWe13L036dNPf1C4PqrYNJJg2A+GUvJO
	 tShLycHmZlRUCmkkLL6tbBCKwFAMT3S+q9zhaQc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgACRL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:11:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgACRL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:11:57 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEB2222C4;
        Fri,  3 Jan 2020 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071515;
        bh=oHfzo/HLcd7ztLldtrLgjwS2veYiZ28vrLG8OXZd81w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJ9Op1zA+9pJQNZkUkInlCEshQY/V6WoQ9+9MEs8jml3Fhh/K5nomk4G76m9gSmho
         n17ofdnP5LB91FHwJHw6UL7QzMjKxBGhj1huMFGLue+ICj54cjlSgH1t4jRJfua8Oa
         IySeD80y/GRYiH+25XQAFySwjL9L18/KYOhX4aJs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 02/19] ARM: dts: samsung: Rename Samsung and Exynos to lowercase
Date:   Fri,  3 Jan 2020 18:11:14 +0100
Message-Id: <20200103171131.9900-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos5250-arndale.dts      | 2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts     | 4 ++--
 arch/arm/boot/dts/exynos5250.dtsi             | 8 ++++----
 arch/arm/boot/dts/exynos5260-xyref5260.dts    | 4 ++--
 arch/arm/boot/dts/exynos5260.dtsi             | 2 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts     | 4 ++--
 arch/arm/boot/dts/exynos5410.dtsi             | 6 +++---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 2 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi        | 2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts     | 4 ++--
 arch/arm/boot/dts/exynos5420.dtsi             | 6 +++---
 arch/arm/boot/dts/exynos5422-cpus.dtsi        | 2 +-
 arch/arm/boot/dts/exynos5800.dtsi             | 6 +++---
 arch/arm/boot/dts/s3c2416-smdk2416.dts        | 2 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts        | 4 ++--
 15 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 3eddf5dbcf7b..f8ebc620f42d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -15,7 +15,7 @@
 #include "exynos5250.dtsi"
 
 / {
-	model = "Insignal Arndale evaluation board based on EXYNOS5250";
+	model = "Insignal Arndale evaluation board based on Exynos5250";
 	compatible = "insignal,arndale", "samsung,exynos5250", "samsung,exynos5";
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 6dc96948a9cc..5c42df024adf 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG SMDK5250 board device tree source
+ * Samsung SMDK5250 board device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -12,7 +12,7 @@
 #include "exynos5250.dtsi"
 
 / {
-	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
+	model = "Samsung SMDK5250 board based on Exynos5250";
 	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index ec983283f573..b6135af7ef39 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -1,16 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5250 SoC device tree source
+ * Samsung Exynos5250 SoC device tree source
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * SAMSUNG EXYNOS5250 SoC device nodes are listed in this file.
- * EXYNOS5250 based board files can include this file and provide
+ * Samsung Exynos5250 SoC device nodes are listed in this file.
+ * Exynos5250 based board files can include this file and provide
  * values for board specfic bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
- * EXYNOS5250 SoC. As device tree coverage for EXYNOS5250 increases,
+ * Exynos5250 SoC. As device tree coverage for Exynos5250 increases,
  * additional nodes can be added to this file.
  */
 
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index 36a2b77eeb9d..0dc2ec16aa0a 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG XYREF5260 board device tree source
+ * Samsung XYREF5260 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -10,7 +10,7 @@
 #include "exynos5260.dtsi"
 
 / {
-	model = "SAMSUNG XYREF5260 board based on EXYNOS5260";
+	model = "Samsung XYREF5260 board based on Exynos5260";
 	compatible = "samsung,xyref5260", "samsung,exynos5260", "samsung,exynos5";
 
 	memory@20000000 {
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index b0811dbbb362..154df70128f3 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5260 SoC device tree source
+ * Samsung Exynos5260 SoC device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index dffa5e3ed90c..5282b5deca86 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG SMDK5410 board device tree source
+ * Samsung SMDK5410 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -10,7 +10,7 @@
 #include "exynos5410.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
 / {
-	model = "Samsung SMDK5410 board based on EXYNOS5410";
+	model = "Samsung SMDK5410 board based on Exynos5410";
 	compatible = "samsung,smdk5410", "samsung,exynos5410", "samsung,exynos5";
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index a4b03d4c3de5..2eab80bf5f3a 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5410 SoC device tree source
+ * Samsung Exynos5410 SoC device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * SAMSUNG EXYNOS5410 SoC device nodes are listed in this file.
- * EXYNOS5410 based board files can include this file and provide
+ * Samsung Exynos5410 SoC device nodes are listed in this file.
+ * Exynos5410 based board files can include this file and provide
  * values for board specfic bindings.
  */
 
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 592d7b45ecc8..ee28d30f5476 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -15,7 +15,7 @@
 #include <dt-bindings/clock/samsung,s2mps11.h>
 
 / {
-	model = "Insignal Arndale Octa evaluation board based on EXYNOS5420";
+	model = "Insignal Arndale Octa evaluation board based on Exynos5420";
 	compatible = "insignal,arndale-octa", "samsung,exynos5420", "samsung,exynos5";
 
 	memory@20000000 {
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 0ee6e92a3c29..58d1c54cf925 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5420 SoC cpu device tree source
+ * Samsung Exynos5420 SoC cpu device tree source
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 8240e5186972..e3f2afe8359a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG SMDK5420 board device tree source
+ * Samsung SMDK5420 board device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
@@ -12,7 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Samsung SMDK5420 board based on EXYNOS5420";
+	model = "Samsung SMDK5420 board based on Exynos5420";
 	compatible = "samsung,smdk5420", "samsung,exynos5420", "samsung,exynos5";
 
 	memory@20000000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f66a2d1b3428..b672080e7469 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5420 SoC device tree source
+ * Samsung Exynos5420 SoC device tree source
  *
  * Copyright (c) 2013 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * SAMSUNG EXYNOS5420 SoC device nodes are listed in this file.
- * EXYNOS5420 based board files can include this file and provide
+ * Samsung Exynos5420 SoC device nodes are listed in this file.
+ * Exynos5420 based board files can include this file and provide
  * values for board specfic bindings.
  */
 
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index e4a5857c135f..1b8605cf2407 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5422 SoC cpu device tree source
+ * Samsung Exynos5422 SoC cpu device tree source
  *
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index b4fd53496450..dfb99ab53c3e 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG EXYNOS5800 SoC device tree source
+ * Samsung Exynos5800 SoC device tree source
  *
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * SAMSUNG EXYNOS5800 SoC device nodes are listed in this file.
- * EXYNOS5800 based board files can include this file and provide
+ * Samsung Exynos5800 SoC device nodes are listed in this file.
+ * Exynos5800 based board files can include this file and provide
  * values for board specfic bindings.
  */
 
diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index cb371bf72f64..811bfdef4e9b 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * SAMSUNG SMDK2416 board device tree source
+ * Samsung SMDK2416 board device tree source
  *
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  */
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
index 3bf6c450a26e..96267f5f02a8 100644
--- a/arch/arm/boot/dts/s3c6410-smdk6410.dts
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
  *
- * Device tree source file for SAMSUNG SMDK6410 board which is based on
+ * Device tree source file for Samsung SMDK6410 board which is based on
  * Samsung's S3C6410 SoC.
  */
 
@@ -16,7 +16,7 @@
 #include "s3c6410.dtsi"
 
 / {
-	model = "SAMSUNG SMDK6410 board based on S3C6410";
+	model = "Samsung SMDK6410 board based on S3C6410";
 	compatible = "samsung,mini6410", "samsung,s3c6410";
 
 	memory@50000000 {
-- 
2.17.1

