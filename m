Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548DC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7F821473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfFNLQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:16:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFNLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:16:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8A86528606E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 3/3] platform/chrome: cros_ec_debugfs: Add debugfs ABI documentation
Date:   Fri, 14 Jun 2019 13:15:51 +0200
Message-Id: <20190614111551.28686-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614111551.28686-1-enric.balletbo@collabora.com>
References: <20190614111551.28686-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing ABI documentation for the already available debugfs
entries: console_log, panicinfo and pdinfo.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 Documentation/ABI/testing/debugfs-cros-ec | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
index c91da2d374aa..573a82d23c89 100644
--- a/Documentation/ABI/testing/debugfs-cros-ec
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -1,3 +1,29 @@
+What:		/sys/kernel/debug/<cros-ec-device>/console_log
+Date:		September 2017
+KernelVersion:	4.13
+Description:
+		If the EC supports the CONSOLE_READ command type, this file
+		can be used to grab the EC logs. The kernel polls for the log
+		and keeps its own buffer but userspace should grab this and
+		write it out to some logs.
+
+What:		/sys/kernel/debug/<cros-ec-device>/panicinfo
+Date:		September 2017
+KernelVersion:	4.13
+Description:
+		This file dumps the EC panic information from the previous
+		reboot. This file will only exist if the PANIC_INFO command
+		type is supported by the EC.
+
+What:		/sys/kernel/debug/<cros-ec-device>/pdinfo
+Date:		June 2018
+KernelVersion:	4.17
+Description:
+		This file provides the port role, muxes and power debug
+		information for all the USB PD/type-C ports available. If
+		the are no ports available, this file will be just an empty
+		file.
+
 What:		/sys/kernel/debug/<cros-ec-device>/uptime
 Date:		June 2019
 KernelVersion:	5.3
-- 
2.20.1

