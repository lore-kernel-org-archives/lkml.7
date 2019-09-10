Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A7CC49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E22216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568141146;
	bh=buDzRBIkAkYDEh9lsYjrjDhRTyGGo4mtZJEWBxbG99A=;
	h=From:To:Subject:Date:List-ID:From;
	b=vzDu5WzUIOSx7cqwBeVAvohzbOwIPs3CtBXdA/0FbBcg5UuGG/eoqp82MwHWL0Bh1
	 TqKF0Q/nrFkeT3BIfjhiE8AhMjGtNm9vmFue8hR4tlDIuKyC35dxlmrfebG0OPllL1
	 blz//F7LXlLckEzm3QIB80gK5HsbOcOETeWdZ+iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfIJSpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfIJSpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:45:45 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39E820872;
        Tue, 10 Sep 2019 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568141144;
        bh=buDzRBIkAkYDEh9lsYjrjDhRTyGGo4mtZJEWBxbG99A=;
        h=From:To:Subject:Date:From;
        b=lGabk/d2+DPUKUXKXIKcaz/Dx9i06mspKz2bTfgtxarhDGh7LiKGy5kwCWdMI6a97
         ZqZrJqYUe7Q3h648sHwxKx9KjAsDz07+jhj0XcjilXkbxYYQw+5jB6xWfzFxBzWfbi
         A+4PnKYKxMgVCie2RIOhCWPLapm3akn/5Xw1UxPY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guan Xuetao <gxt@pku.edu.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] unicore32: defconfig: Cleanup from old Kconfig options
Date:   Tue, 10 Sep 2019 20:45:36 +0200
Message-Id: <20190910184536.21881-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - MTD_PARTITIONS: commit 6a8a98b22b10 ("mtd: kill
   CONFIG_MTD_PARTITIONS");
 - MTD_CHAR: commit 660685d9d1b4 ("mtd: merge mtdchar module with
   mtdcore");
 - NETDEV_1000: commit f860b0522f65 ("drivers/net: Kconfig and Makefile
   cleanup"); NET_ETHERNET should be replaced with just ETHERNET but
   that is separate change;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/unicore32/configs/defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/unicore32/configs/defconfig b/arch/unicore32/configs/defconfig
index 360cc9abcdb0..511e216a2f13 100644
--- a/arch/unicore32/configs/defconfig
+++ b/arch/unicore32/configs/defconfig
@@ -1,5 +1,4 @@
 ### General setup
-CONFIG_EXPERIMENTAL=y
 CONFIG_LOCALVERSION="-unicore32"
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
@@ -75,8 +74,6 @@ CONFIG_PUV3_UART=n
 #	Memory Technology Device (MTD) support
 CONFIG_MTD=m
 CONFIG_MTD_UBI=m
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=m
 CONFIG_MTD_BLKDEVS=m
 #	RAM/ROM/Flash chip drivers
 CONFIG_MTD_CFI=m
@@ -101,7 +98,6 @@ CONFIG_SATA_VIA=y
 #	Network device support
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
-CONFIG_NETDEV_1000=y
 #	Wireless LAN
 CONFIG_WLAN_80211=n
 CONFIG_RT2X00=n
-- 
2.17.1

