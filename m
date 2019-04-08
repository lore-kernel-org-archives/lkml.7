Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A788DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C14E21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDHMi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:38:58 -0400
Received: from mail.delivery-10-eu-central-1.prod.hydra.sophos.com ([35.159.27.106]:58552
        "EHLO mail.delivery-10-eu-central-1.prod.hydra.sophos.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfDHMi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:38:58 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 08:38:56 EDT
Received: from mail.delivery-50-eu-central-1.prod.hydra.sophos.com (ip-172-20-1-98.eu-central-1.compute.internal [172.20.1.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.delivery-10-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id 44d8w16wRCz8Bn
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 12:33:05 +0000 (UTC)
Received: from ip-172-20-1-174.eu-central-1.compute.internal (ip-172-20-1-174.eu-central-1.compute.internal [127.0.0.1])
        by mail.delivery-50-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTP id 44d8w03lV8zRhQr;
        Mon,  8 Apr 2019 12:33:04 +0000 (UTC)
X-Sophos-Email-ID: 3525a9a60ba84063ae1047f94d1241cb
Received: from smtp.eckelmann.de (smtp.eckelmann.de [217.19.183.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by relay-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 44d8vy6KszzTgCr; Mon,  8 Apr 2019 12:33:02 +0000 (UTC)
Received: from ws161-Debian.eckelmann.group
 (2a00:1f08:4007:5c00:fde5:652:edb5:c402) by EX-SRV1.eckelmann.group
 (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 8 Apr
 2019 14:33:02 +0200
From:   Gavin Schenk <g.schenk@eckelmann.de>
To:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <u.kleine-koenig@pengutronix.de>, <t.scherer@eckelmann.de>
CC:     <kernel@pengutronix.de>, Gavin Schenk <g.schenk@eckelmann.de>
Subject: [PATCH] MAINTAINERS / Documentation: Thorsten Scherer is the
 successor of Gavin Schenk
Date:   Mon, 8 Apr 2019 14:32:08 +0200
Message-ID: <20190408123208.10965-1-g.schenk@eckelmann.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2a00:1f08:4007:5c00:fde5:652:edb5:c402]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4)
 To EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4)
X-LASED-Pver: 0000002
X-Sophos-Email: [eu-central-1] Antispam-Engine: 3.1.5,
 AntispamData: 2019.4.8.121516
X-LASED-SpamProbabilty: 0.083173
X-LASED-Hits: BODY_SIZE_5000_5999 0.000000, BODY_SIZE_7000_LESS 0.000000,
 CT_TEXT_PLAIN_UTF8_CAPS 0.000000, FROM_SAME_AS_TO_DOMAIN 0.000000,
 HTML_00_01 0.050000, HTML_00_10 0.050000, MULTIPLE_RCPTS 0.100000,
 NO_URI_HTTPS 0.000000, WEBMAIL_SOURCE 0.000000, __ANY_URI 0.000000,
 __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000, __CC_REAL_NAMES 0.000000,
 __CT 0.000000, __CTE 0.000000, __CT_TEXT_PLAIN 0.000000,
 __FROM_DOMAIN_IN_ANY_CC1 0.000000, __FROM_DOMAIN_IN_ANY_TO1 0.000000,
 __FROM_DOMAIN_IN_RCPT 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
 __HAS_MSGID 0.000000, __HAS_XOIP 0.000000, __HAS_X_MAILER 0.000000,
 __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
 __MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
 __NO_HTML_TAG_RAW 0.000000, __SANE_MSGID 0.000000, __SUBJ_ALPHA_END 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_NO_WWW 0.000000,
 __URI_NS 0.000000
X-LASED-Authed: 1
X-LASED-Spam: NonSpam
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to new challenges in my life I can no longer take care of SIOX.
Thorsten takes over my SIOX tasks.

Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
---
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
index 43b36dbed48e..34156d1c6468 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14191,7 +14191,7 @@ F:	lib/test_siphash.c
 F:	include/linux/siphash.h
 
 SIOX
-M:	Gavin Schenk <g.schenk@eckelmann.de>
+M:	Thorsten Scherer <t.scherer@eckelmann.de>
 M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 S:	Supported
-- 
2.20.1

