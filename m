Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812E8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5202D2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 05:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566712506;
	bh=xRyf4XOMzsxpEwPzFX1RlAog4Ep0LmEq5nnu9RllK+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8hjz1hJVK1IHFaqqo6LfU/9NcZhjHHzK3xE+eiDzzyTMLoqLS25v6r2n4zURSxqG
	 f8gSOOa6ygMcs/GbmNHRSOPo5cM73xix8byn3dbOCHE1Czq0BtMQyD4AVE+g4AmDs5
	 keofy1siX/Zk95lZ1q7vMPr2uKiDDVI/gxVuKS1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfHYFy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 01:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfHYFy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:54:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B2362173E;
        Sun, 25 Aug 2019 05:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712495;
        bh=xRyf4XOMzsxpEwPzFX1RlAog4Ep0LmEq5nnu9RllK+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/tq3KESuQICGL4MFxtGiOQZlVmce/PSeQVC61RdQwVjyDjTGB51MSSs196vi0aFv
         CF4gpq1CRye+RGAyWOe0tozkxpzbcKmJTEAaOk2pVhAJfgypmI0emWquQ5+ZGwhqWx
         547COrU4ZXGS1YZQU3BOIPeBiaMWzPYK3THBcVNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH 1/9] staging: greybus: fix up SPDX comment in .h files
Date:   Sun, 25 Aug 2019 07:54:21 +0200
Message-Id: <20190825055429.18547-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825055429.18547-1-gregkh@linuxfoundation.org>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When these files originally got an SPDX tag, I used // instead of /* */
for the .h files.  Fix this up to use // properly.

Cc: Viresh Kumar <vireshk@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/firmware.h               | 2 +-
 drivers/staging/greybus/gb-camera.h              | 2 +-
 drivers/staging/greybus/gbphy.h                  | 2 +-
 drivers/staging/greybus/greybus.h                | 2 +-
 drivers/staging/greybus/greybus_authentication.h | 2 +-
 drivers/staging/greybus/greybus_firmware.h       | 2 +-
 drivers/staging/greybus/greybus_manifest.h       | 2 +-
 drivers/staging/greybus/greybus_protocols.h      | 2 +-
 drivers/staging/greybus/greybus_trace.h          | 2 +-
 drivers/staging/greybus/hd.h                     | 2 +-
 drivers/staging/greybus/interface.h              | 2 +-
 drivers/staging/greybus/manifest.h               | 2 +-
 drivers/staging/greybus/module.h                 | 2 +-
 drivers/staging/greybus/operation.h              | 2 +-
 drivers/staging/greybus/spilib.h                 | 2 +-
 drivers/staging/greybus/svc.h                    | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/greybus/firmware.h b/drivers/staging/greybus/firmware.h
index 946221307ef6..72dfabfa4704 100644
--- a/drivers/staging/greybus/firmware.h
+++ b/drivers/staging/greybus/firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Firmware Management Header
  *
diff --git a/drivers/staging/greybus/gb-camera.h b/drivers/staging/greybus/gb-camera.h
index ee293e461fc3..5fc469101fc1 100644
--- a/drivers/staging/greybus/gb-camera.h
+++ b/drivers/staging/greybus/gb-camera.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Camera protocol driver.
  *
diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 99463489d7d6..087928a586fb 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Bridged-Phy Bus driver
  *
diff --git a/drivers/staging/greybus/greybus.h b/drivers/staging/greybus/greybus.h
index d03ddb7c9df0..f0488ffff93e 100644
--- a/drivers/staging/greybus/greybus.h
+++ b/drivers/staging/greybus/greybus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus driver and device API
  *
diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
index 03ea9615b217..d654760cf175 100644
--- a/drivers/staging/greybus/greybus_authentication.h
+++ b/drivers/staging/greybus/greybus_authentication.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Greybus Component Authentication User Header
  *
diff --git a/drivers/staging/greybus/greybus_firmware.h b/drivers/staging/greybus/greybus_firmware.h
index b58281a63ba4..13ef3aa5279e 100644
--- a/drivers/staging/greybus/greybus_firmware.h
+++ b/drivers/staging/greybus/greybus_firmware.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * Greybus Firmware Management User Header
  *
diff --git a/drivers/staging/greybus/greybus_manifest.h b/drivers/staging/greybus/greybus_manifest.h
index 2cec5cf7a846..db68f7e7d5a7 100644
--- a/drivers/staging/greybus/greybus_manifest.h
+++ b/drivers/staging/greybus/greybus_manifest.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus manifest definition
  *
diff --git a/drivers/staging/greybus/greybus_protocols.h b/drivers/staging/greybus/greybus_protocols.h
index ddc73f10eb22..7d649a7fc4c9 100644
--- a/drivers/staging/greybus/greybus_protocols.h
+++ b/drivers/staging/greybus/greybus_protocols.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
 /*
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
diff --git a/drivers/staging/greybus/greybus_trace.h b/drivers/staging/greybus/greybus_trace.h
index 7b5e2c6b1f6b..1bc9f1275c65 100644
--- a/drivers/staging/greybus/greybus_trace.h
+++ b/drivers/staging/greybus/greybus_trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus driver and device API
  *
diff --git a/drivers/staging/greybus/hd.h b/drivers/staging/greybus/hd.h
index 6cf024a20a58..348b76fabc9a 100644
--- a/drivers/staging/greybus/hd.h
+++ b/drivers/staging/greybus/hd.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Host Device
  *
diff --git a/drivers/staging/greybus/interface.h b/drivers/staging/greybus/interface.h
index 1c00c5bb3ec9..8fb1eacda302 100644
--- a/drivers/staging/greybus/interface.h
+++ b/drivers/staging/greybus/interface.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Interface Block code
  *
diff --git a/drivers/staging/greybus/manifest.h b/drivers/staging/greybus/manifest.h
index f3c95a255631..88aa7e44cad5 100644
--- a/drivers/staging/greybus/manifest.h
+++ b/drivers/staging/greybus/manifest.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus manifest parsing
  *
diff --git a/drivers/staging/greybus/module.h b/drivers/staging/greybus/module.h
index b1ebcc6636db..2a27e520ee94 100644
--- a/drivers/staging/greybus/module.h
+++ b/drivers/staging/greybus/module.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus Module code
  *
diff --git a/drivers/staging/greybus/operation.h b/drivers/staging/greybus/operation.h
index 40b7b02fff88..17ba3daf111b 100644
--- a/drivers/staging/greybus/operation.h
+++ b/drivers/staging/greybus/operation.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus operations
  *
diff --git a/drivers/staging/greybus/spilib.h b/drivers/staging/greybus/spilib.h
index 043d4d32c3ee..9d416839e3be 100644
--- a/drivers/staging/greybus/spilib.h
+++ b/drivers/staging/greybus/spilib.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus SPI library header
  *
diff --git a/drivers/staging/greybus/svc.h b/drivers/staging/greybus/svc.h
index ad01783bac9c..e7452057cfe4 100644
--- a/drivers/staging/greybus/svc.h
+++ b/drivers/staging/greybus/svc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Greybus SVC code
  *
-- 
2.23.0

