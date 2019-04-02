Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50EDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B649F2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554214036;
	bh=BRSruHyESr/0VPJcIICsAXACkRFWWDXhg+wyR0+NyvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mANl6XgKPejGaelYT7Zi9zvIkj07hYx9ysdoOIp4nlhG2WwrVllb5/5cHD/i3sKqv
	 LTHhkMc8K1s1AZXq/PTLCisfCvx60enxkcAufqg3zuNEoNWaSVHFY+jWDRrLj3/xnz
	 dOr55GO2nroNjmHR9aZ9UVuyQDqXGO1LPlljSCU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfDBOHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBOHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:07:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B919F2084B;
        Tue,  2 Apr 2019 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554214033;
        bh=BRSruHyESr/0VPJcIICsAXACkRFWWDXhg+wyR0+NyvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQYJSq0l7FpvyZwxA5YZPx/mpTtpxLUkMcNc2MtxMRpCChgRGwbo8B6LqZ6QQtdPu
         cd749sS19GmQY2nkVQMXDVZeqEn0KNnEvFac1y3zQ2nKvmNjwB7uL9T0ZeW6ClTWrm
         G8jWVKSaY0JytRjBLNoo/syaRZETYXKBlkyKx9h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/2] tty: fix up a few remaining files without SPDX identifiers
Date:   Tue,  2 Apr 2019 16:07:08 +0200
Message-Id: <20190402140708.519-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402140708.519-1-gregkh@linuxfoundation.org>
References: <20190402140708.519-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few straggling files under drivers/tty/ that did not have
any SPDX identifier either because they entered the tree recently, or
they somehow missed the mass-tagging of commit b24413180f56 ("License
cleanup: add SPDX GPL-2.0 license identifier to files with no license")

This commit follows the same rule as b24413180f56 ("License cleanup: add
SPDX GPL-2.0 license identifier to files with no license") where files
without any specified license in them fall under GPL-2.0 as the correct
license for the individual file.  Add that identifier to these remaining
files so that we don't have to guess at the license of them in the
future.

Cc: Jiri Slaby <jslaby@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 1 +
 drivers/tty/serial/sn_console.c        | 1 +
 drivers/tty/vcc.c                      | 1 +
 drivers/tty/vt/.gitignore              | 1 +
 drivers/tty/vt/cp437.uni               | 1 +
 drivers/tty/vt/defkeymap.c_shipped     | 1 +
 drivers/tty/vt/defkeymap.map           | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 127017cc41d9..02c5aff58a74 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index fe9170731c16..283493358a62 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * C-Brick Serial Port (and console) driver for SGI Altix machines.
  *
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c34560..d2a1e1228c82 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* vcc.c: sun4v virtual channel concentrator
  *
  * Copyright (C) 2017 Oracle. All rights reserved.
diff --git a/drivers/tty/vt/.gitignore b/drivers/tty/vt/.gitignore
index 83683a2d8e6a..9b38b85f9d9a 100644
--- a/drivers/tty/vt/.gitignore
+++ b/drivers/tty/vt/.gitignore
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 consolemap_deftbl.c
 defkeymap.c
diff --git a/drivers/tty/vt/cp437.uni b/drivers/tty/vt/cp437.uni
index bc6163484f62..a1991904c559 100644
--- a/drivers/tty/vt/cp437.uni
+++ b/drivers/tty/vt/cp437.uni
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Unicode table for IBM Codepage 437.  Note that there are many more
 # substitutions that could be conceived (for example, thick-line
diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index d2208dfe3f67..c7095fb7d2d1 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Do not edit this file! It was automatically generated by   */
 /*    loadkeys --mktable defkeymap.map > defkeymap.c          */
 
diff --git a/drivers/tty/vt/defkeymap.map b/drivers/tty/vt/defkeymap.map
index 50b30cace261..37f1ac6ddfb9 100644
--- a/drivers/tty/vt/defkeymap.map
+++ b/drivers/tty/vt/defkeymap.map
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Default kernel keymap. This uses 7 modifier combinations.
 keymaps 0-2,4-5,8,12
 # Change the above line into
-- 
2.21.0

