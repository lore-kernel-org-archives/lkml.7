Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E7C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7052205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfFRGva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:51:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48629 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfFRGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:51:26 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hd7EC-00058V-LM; Tue, 18 Jun 2019 08:04:20 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hd7EB-00046E-VS; Tue, 18 Jun 2019 08:04:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        t.scherer@eckelmann.de, Gavin Schenk <g.schenk@eckelmann.de>
Subject: [PATCH v2] MAINTAINERS / Documentation: Thorsten Scherer is the successor of Gavin Schenk
Date:   Tue, 18 Jun 2019 08:04:12 +0200
Message-Id: <20190618060412.12923-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408133157.ykuprwtve7bmavbq@pengutronix.de>
References: <20190408133157.ykuprwtve7bmavbq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gavin Schenk <g.schenk@eckelmann.de>

Due to new challenges in my life I can no longer take care of SIOX.
Thorsten takes over my SIOX tasks.

Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Greg,

this patch was already send by Gavin back in April. I just noticed now
it didn't made it in. Assuming you already dropped the thread from your
inbox here comes a v2 with Thorsten's ack.

Best regards
Uwe

 Documentation/ABI/testing/sysfs-bus-siox | 22 +++++++++++-----------
 MAINTAINERS                              |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-siox b/Documentation/ABI/testing/sysfs-bus-siox
index fed7c3765a4e..c2a403f20b90 100644
--- a/Documentation/ABI/testing/sysfs-bus-siox
+++ b/Documentation/ABI/testing/sysfs-bus-siox
@@ -1,6 +1,6 @@
 What:		/sys/bus/siox/devices/siox-X/active
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		On reading represents the current state of the bus. If it
 		contains a "0" the bus is stopped and connected devices are
@@ -12,7 +12,7 @@ Description:
 
 What:		/sys/bus/siox/devices/siox-X/device_add
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Write-only file. Write
 
@@ -27,13 +27,13 @@ Description:
 
 What:		/sys/bus/siox/devices/siox-X/device_remove
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Write-only file. A single write removes the last device in the siox chain.
 
 What:		/sys/bus/siox/devices/siox-X/poll_interval_ns
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Defines the interval between two poll cycles in nano seconds.
 		Note this is rounded to jiffies on writing. On reading the current value
@@ -41,33 +41,33 @@ Description:
 
 What:		/sys/bus/siox/devices/siox-X-Y/connected
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value. "0" means the Yth device on siox bus X isn't "connected" i.e.
 		communication with it is not ensured. "1" signals a working connection.
 
 What:		/sys/bus/siox/devices/siox-X-Y/inbytes
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value reporting the inbytes value provided to siox-X/device_add
 
 What:		/sys/bus/siox/devices/siox-X-Y/status_errors
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Counts the number of time intervals when the read status byte doesn't yield the
 		expected value.
 
 What:		/sys/bus/siox/devices/siox-X-Y/type
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value reporting the type value provided to siox-X/device_add.
 
 What:		/sys/bus/siox/devices/siox-X-Y/watchdog
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value reporting if the watchdog of the siox device is
 		active. "0" means the watchdog is not active and the device is expected to
@@ -75,13 +75,13 @@ Description:
 
 What:		/sys/bus/siox/devices/siox-X-Y/watchdog_errors
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value reporting the number to time intervals when the
 		watchdog was active.
 
 What:		/sys/bus/siox/devices/siox-X-Y/outbytes
 KernelVersion:	4.16
-Contact:	Gavin Schenk <g.schenk@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
+Contact:	Thorsten Scherer <t.scherer@eckelmann.de>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 Description:
 		Read-only value reporting the outbytes value provided to siox-X/device_add.
diff --git a/MAINTAINERS b/MAINTAINERS
index 230a46aa5ad3..5bc491f34e61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14404,7 +14404,7 @@ F:	lib/test_siphash.c
 F:	include/linux/siphash.h
 
 SIOX
-M:	Gavin Schenk <g.schenk@eckelmann.de>
+M:	Thorsten Scherer <t.scherer@eckelmann.de>
 M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 S:	Supported
-- 
2.20.1

