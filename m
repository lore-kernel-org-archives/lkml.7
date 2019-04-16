Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00E720870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfDPNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:33:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:33:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGOD8-0004VO-KE; Tue, 16 Apr 2019 13:33:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: intel_scu_watchdog: fix spelling mistake: "set_hearbeat" -> "set_heartbeat"
Date:   Tue, 16 Apr 2019 14:33:18 +0100
Message-Id: <20190416133318.21045-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/watchdog/intel_scu_watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index 0caab6241eb7..718f7db35bec 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -224,7 +224,7 @@ static int intel_scu_set_heartbeat(u32 t)
 		 watchdog_device.timer_tbl_ptr->freq_hz);
 	pr_debug("set_heartbeat: timer_set is %x (hex)\n",
 		 watchdog_device.timer_set);
-	pr_debug("set_hearbeat: timer_margin is %x (hex)\n", timer_margin);
+	pr_debug("set_heartbeat: timer_margin is %x (hex)\n", timer_margin);
 	pr_debug("set_heartbeat: threshold is %x (hex)\n",
 		 watchdog_device.threshold);
 	pr_debug("set_heartbeat: soft_threshold is %x (hex)\n",
-- 
2.20.1

