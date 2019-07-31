Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EDC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6AD206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfGaJrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:47:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGaJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:47:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hslCr-0006P6-2g; Wed, 31 Jul 2019 09:47:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove redundant assignment to variable rtstatus
Date:   Wed, 31 Jul 2019 10:47:36 +0100
Message-Id: <20190731094736.28637-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable rtstatus is being initialized with a value that is never read
and rtstatus is being re-assigned a little later on. The assignment is
redundant and hence can be removed.  Also, make rtstatus a bool to
match the function return type.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/hal/bb_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/bb_cfg.c b/drivers/staging/rtl8188eu/hal/bb_cfg.c
index 11e0bb9c67d7..51882858fcf0 100644
--- a/drivers/staging/rtl8188eu/hal/bb_cfg.c
+++ b/drivers/staging/rtl8188eu/hal/bb_cfg.c
@@ -653,7 +653,7 @@ static bool config_parafile(struct adapter *adapt)
 
 bool rtl88eu_phy_bb_config(struct adapter *adapt)
 {
-	int rtstatus = true;
+	bool rtstatus;
 	u32 regval;
 	u8 crystal_cap;
 
-- 
2.20.1

