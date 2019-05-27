Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857CCC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F1B20673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfE0MZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:25:36 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:41150 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE0MZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:25:35 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HQRZ2000T3XaVaC01QRZR4; Mon, 27 May 2019 14:25:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEh3-0001UE-Hp; Mon, 27 May 2019 14:25:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEh3-0001as-GN; Mon, 27 May 2019 14:25:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [trivial] HID: Typo s/to back 0/back to 0/
Date:   Mon, 27 May 2019 14:25:32 +0200
Message-Id: <20190527122532.6084-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a silly word ordering typo.

Fixes: 42337b9d4d958daa ("HID: add driver for U2F Zero built-in LED and RNG")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c3c390ca369022f0..735223f90035b2bf 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1028,7 +1028,7 @@ config HID_U2FZERO
 
 	  U2F Zero only supports blinking its LED, so this driver doesn't
 	  allow setting the brightness to anything but 1, which will
-	  trigger a single blink and immediately reset to back 0.
+	  trigger a single blink and immediately reset back to 0.
 
 config HID_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
-- 
2.17.1

