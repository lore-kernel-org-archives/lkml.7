Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26786C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF23F20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfFQOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:39:41 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:45608 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:39:41 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id Rqfg2000B3XaVaC01qfgiQ; Mon, 17 Jun 2019 16:39:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsnM-0002KC-8Q; Mon, 17 Jun 2019 16:39:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hcsnM-0001Ow-70; Mon, 17 Jun 2019 16:39:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] staging: Add missing newline at end of file
Date:   Mon, 17 Jun 2019 16:39:39 +0200
Message-Id: <20190617143939.5318-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"git diff" says:

    \ No newline at end of file

after modifying the files.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/mt7621-dts/TODO | 2 +-
 drivers/staging/rts5208/TODO    | 2 +-
 drivers/staging/vt6655/test     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-dts/TODO b/drivers/staging/mt7621-dts/TODO
index 15803132c1ea798a..1b758e5c84e00d48 100644
--- a/drivers/staging/mt7621-dts/TODO
+++ b/drivers/staging/mt7621-dts/TODO
@@ -2,4 +2,4 @@
 - ensure all usage matches code
 - ensure all features used are documented
 
-Cc: NeilBrown <neil@brown.name>
\ No newline at end of file
+Cc: NeilBrown <neil@brown.name>
diff --git a/drivers/staging/rts5208/TODO b/drivers/staging/rts5208/TODO
index 57bcf5834c0c9333..9cec0d8dd0b6cad6 100644
--- a/drivers/staging/rts5208/TODO
+++ b/drivers/staging/rts5208/TODO
@@ -4,4 +4,4 @@ TODO:
 - We will use the stack in drivers/mmc to implement
   rts5208/5288 in the future
 
-Micky Ching <micky_ching@realsil.com.cn>
\ No newline at end of file
+Micky Ching <micky_ching@realsil.com.cn>
diff --git a/drivers/staging/vt6655/test b/drivers/staging/vt6655/test
index 039f7d71c537857c..ba6dec774478e9d5 100644
--- a/drivers/staging/vt6655/test
+++ b/drivers/staging/vt6655/test
@@ -6,4 +6,4 @@ KSP :=  /lib/modules/$(shell uname -r)/build \
 #	/usr/src/linux-$(shell uname -r | sed 's/\([0-9]*\.[0-9]*\)\..*/\1/') \
 #	/usr/src/linux   /home/plice
 test_dir = $(shell [ -e $(dir)/include/linux ] && echo $(dir))
-KSP := $(foreach dir, $(KSP), $(test_dir))
\ No newline at end of file
+KSP := $(foreach dir, $(KSP), $(test_dir))
-- 
2.17.1

