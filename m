Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBBAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48520883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201171;
	bh=tIfjgBqW7oOaf+ZZfyvBn6G2mdVBNfTYyh58HBK1NNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dy+B+mmlvX4SyOhFpg/a9uwbgJJSXYv3cb8Q5dMla6uIbggJLiBzp0qSX6OQZ3iUT
	 8ydifjb9cJAJAwyLkGtSj3la/jbxS9yOdJrqbTbQPrX5tLVI549WbJcKPNenctWWHX
	 jZQRWJMuN1lLcqUndb3Q1kWxEN4S/Rd8aE/kZP9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfDBKcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbfDBKcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E702148E;
        Tue,  2 Apr 2019 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201167;
        bh=tIfjgBqW7oOaf+ZZfyvBn6G2mdVBNfTYyh58HBK1NNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmxU1cAfofSgZW/+ZYkk1buEr5ne3JKbCCq1plPYDtkaSovXaYlepSmB6cWxhIvcx
         lGjYgruXWcmgNHepOF9RW2/Wbq9F0k9uWXoNsFFlA+oDhWv2fTlHaiOHp6hZchggHt
         g8P6yQErKZskAYXMfp/4mjqkuUqwPU+tmY0jkJ4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Aymen Qader <qader.aymen@gmail.com>,
        =?UTF-8?q?Tobias=20B=C3=BCttner?= <tobias.buettner@fau.de>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/16] staging: vc04_services: add proper SPDX identifier for dual licensed files
Date:   Tue,  2 Apr 2019 12:31:52 +0200
Message-Id: <20190402103203.14959-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402103203.14959-1-gregkh@linuxfoundation.org>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of vc04_services files that are dual licensed under
the GPL2 and BSD-3 licenses.  They currently do not have a SPDX
identifier on them, so fix that up and add the proper identifier so that
tools can pick it up easily.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Aymen Qader <qader.aymen@gmail.com>
Cc: "Tobias Büttner" <tobias.buettner@fau.de>
Cc: Dominic Braun <inf.braun@fau.de>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>
Cc: Phil Elwell <phil@raspberrypi.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h              | 1 +
 drivers/staging/vc04_services/interface/vchi/vchi_cfg.h          | 1 +
 drivers/staging/vc04_services/interface/vchi/vchi_common.h       | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h        | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c   | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h    | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h    | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_connected.c  | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_connected.h  | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h   | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c    | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h    | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h     | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h  | 1 +
 .../staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h   | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c   | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c   | 1 +
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h   | 1 +
 20 files changed, 20 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index df7f8ef478af..a662e1bf7341 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index 0d3c468c3504..d9f16a544412 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index 1672848d5c83..fdb17a80fa5c 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 21adf89a9065..4b6e657081f1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index dd4898861b83..70d7f6ff1483 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6dad624d0e49..c95b7eaf7343 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2014 Raspberry Pi (Trading) Ltd. All rights reserved.
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index cdb963054975..fc732ca76ca5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2014 Raspberry Pi (Trading) Ltd. All rights reserved.
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
index d2797db702f9..e31475610be0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2014 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
index 7d64e2ed7b42..fc5a9c359b09 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
index 863b3e335c1a..dc6d99dbb1b4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_connected.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index c60db447ae8e..daadc9d6ff8e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 5f07db519633..34685f89f910 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 3928287cf5f7..e099be476ec5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2014 Raspberry Pi (Trading) Ltd. All rights reserved.
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
index 5be1a5663f51..1697d3fdb0a4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2014 Raspberry Pi (Trading) Ltd. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 13ed23eacfae..957e226df626 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 56aef490e870..4dbc16d2a944 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
index 4eaf7398cf2e..eed4913a6c66 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index ab6ca8fd6f14..661ec3df90a2 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
index 55c5fd82b911..5a60870c89c3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
index d842194b4023..3f0ddbc1dd5b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /**
  * Copyright (c) 2010-2012 Broadcom. All rights reserved.
  *
-- 
2.21.0

