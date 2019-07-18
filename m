Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F5C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7686C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389874AbfGRJx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:53:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfGRJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:53:25 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ho36E-0000bu-57; Thu, 18 Jul 2019 09:53:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: line6: Fix wrong altsetting for LINE6_PODHD500_1
Date:   Thu, 18 Jul 2019 17:53:13 +0800
Message-Id: <20190718095313.19498-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b9584fa1c0b ("staging: line6: Move altsetting to properties")
set a wrong altsetting for LINE6_PODHD500_1 during refactoring.

Set the correct altsetting number to fix the issue.

BugLink: https://bugs.launchpad.net/bugs/1790595
Fixes: 7b9584fa1c0b ("staging: line6: Move altsetting to properties")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/line6/podhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index f0662bd4e50f..27bf61c177c0 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -368,7 +368,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.name = "POD HD500",
 		.capabilities	= LINE6_CAP_PCM
 				| LINE6_CAP_HWMON,
-		.altsetting = 1,
+		.altsetting = 0,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
 		.ep_audio_r = 0x86,
-- 
2.17.1

