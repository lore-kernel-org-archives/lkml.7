Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA38C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B5321473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554214042;
	bh=kJQZVEExwZ9bn5tm2IPFJ1g6+wx4fExqb+5VnyHz3eA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ygXB8J06JaJXIxUmY3juUIb/oy2TK0rAOuc0k/udPZnz4kBe8w5YIpRn8jLUJHyZq
	 T8IHc2rD9kBt+n9fqDv3uBYqhSWyMaRRu2uJzVHhunFtzOhRiMp/Xo8q2IiK6eilWL
	 c0QEh34T7sT+vdg1TGl5XW7os+45W5Ph6ihYmbJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfDBOHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfDBOHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:07:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E79C2133D;
        Tue,  2 Apr 2019 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554214036;
        bh=kJQZVEExwZ9bn5tm2IPFJ1g6+wx4fExqb+5VnyHz3eA=;
        h=From:To:Cc:Subject:Date:From;
        b=cAu8ps6CSK9H3DyAQeEccstzRIKYGhKAnRZa0GGn4y0SYmeYFlJE9MOrWKhjjSx0j
         DoEKzWtijkoye9E6qQoLDCE4mZvAhKWuIp00cMucGh11v5buSB+mFlraTLGK1YUw2H
         nvxesqFbnoYi6zMfBEKEWahOV7nV83yUMk35ikZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] tty: add SPDX identifiers to Kconfig and Makefiles
Date:   Tue,  2 Apr 2019 16:07:07 +0200
Message-Id: <20190402140708.519-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few Kconfig and Makefiles under drivers/tty/ that were
missing a SPDX identifier.  Fix that up so that automated tools can
properly classify all kernel source files.

Cc: Jiri Slaby <jslaby@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/Kconfig                  | 1 +
 drivers/tty/hvc/Kconfig              | 1 +
 drivers/tty/ipwireless/Makefile      | 1 +
 drivers/tty/serdev/Kconfig           | 1 +
 drivers/tty/serdev/Makefile          | 1 +
 drivers/tty/serial/8250/Kconfig      | 1 +
 drivers/tty/serial/Kconfig           | 1 +
 drivers/tty/serial/cpm_uart/Makefile | 1 +
 drivers/tty/serial/jsm/Makefile      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0a04bfc873e..8034473c54ca 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 config TTY
 	bool "Enable TTY" if EXPERT
 	default y
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 4293c172e120..1a910ec9f643 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 if TTY
 
 config HVC_DRIVER
diff --git a/drivers/tty/ipwireless/Makefile b/drivers/tty/ipwireless/Makefile
index fe2e1730986b..a665d021e24d 100644
--- a/drivers/tty/ipwireless/Makefile
+++ b/drivers/tty/ipwireless/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the IPWireless driver
 #
diff --git a/drivers/tty/serdev/Kconfig b/drivers/tty/serdev/Kconfig
index 1dbc8352e027..46ae732bfc68 100644
--- a/drivers/tty/serdev/Kconfig
+++ b/drivers/tty/serdev/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Serial bus device driver configuration
 #
diff --git a/drivers/tty/serdev/Makefile b/drivers/tty/serdev/Makefile
index 0cbdb9444d9d..078417e5b068 100644
--- a/drivers/tty/serdev/Makefile
+++ b/drivers/tty/serdev/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 serdev-objs := core.o
 
 obj-$(CONFIG_SERIAL_DEV_BUS) += serdev.o
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..296115f6a4d8 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # The 8250/16550 serial drivers.  You shouldn't be in this list unless
 # you somehow have an implicit or explicit dependency on SERIAL_8250.
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc0ac76..a5032e58c737 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Serial device configuration
 #
diff --git a/drivers/tty/serial/cpm_uart/Makefile b/drivers/tty/serial/cpm_uart/Makefile
index 896a5d57881c..3f3a6ed02ed4 100644
--- a/drivers/tty/serial/cpm_uart/Makefile
+++ b/drivers/tty/serial/cpm_uart/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Motorola 8xx FEC ethernet controller
 #
diff --git a/drivers/tty/serial/jsm/Makefile b/drivers/tty/serial/jsm/Makefile
index 705d1ff6fdeb..4f2dbada7741 100644
--- a/drivers/tty/serial/jsm/Makefile
+++ b/drivers/tty/serial/jsm/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for Jasmine adapter
 #
-- 
2.21.0

