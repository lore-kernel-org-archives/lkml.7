Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CA5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612D5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbfDQMIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:08:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35872 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfDQMIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:08:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hGjMU-00033X-Ha; Wed, 17 Apr 2019 12:08:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtlwifi: fix spelling mistake "notity" -> "notify"
Date:   Wed, 17 Apr 2019 13:08:22 +0100
Message-Id: <20190417120822.21771-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistake in RT_TRACE messages. Fix them.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c b/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
index ade271cb4aab..32c797430512 100644
--- a/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
+++ b/drivers/staging/rtlwifi/btcoexist/halbtc8822b1ant.c
@@ -4730,7 +4730,7 @@ void ex_btc8822b1ant_media_status_notify(struct btc_coexist *btcoexist, u8 type)
 		if (wifi_under_b_mode) {
 			RT_TRACE(
 				rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-				"[BTCoex], ********** (media status notity under b mode) **********\n");
+				"[BTCoex], ********** (media status notify under b mode) **********\n");
 			btcoexist->btc_write_1byte(btcoexist, 0x6cd,
 						   0x00); /* CCK Tx */
 			btcoexist->btc_write_1byte(btcoexist, 0x6cf,
@@ -4738,7 +4738,7 @@ void ex_btc8822b1ant_media_status_notify(struct btc_coexist *btcoexist, u8 type)
 		} else {
 			RT_TRACE(
 				rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-				"[BTCoex], ********** (media status notity not under b mode) **********\n");
+				"[BTCoex], ********** (media status notify not under b mode) **********\n");
 			btcoexist->btc_write_1byte(btcoexist, 0x6cd,
 						   0x00); /* CCK Tx */
 			btcoexist->btc_write_1byte(btcoexist, 0x6cf,
-- 
2.20.1

