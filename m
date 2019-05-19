Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CE9C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0220578
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfESTYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 15:24:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53818 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfESTYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 15:24:04 -0400
Received: from [61.149.195.63] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1hSGE9-0004LW-GN; Sun, 19 May 2019 07:27:26 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        benjamin.tissoires@redhat.com
Subject: [PATCH 1/2] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Sun, 19 May 2019 15:27:10 +0800
Message-Id: <20190519072711.2592-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding 2 new touchpad PNPIDs to enable middle button support.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a7f8b1614559..530142b5a115 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.17.1

