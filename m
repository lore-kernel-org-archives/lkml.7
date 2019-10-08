Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AAFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA27206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfJHIWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:22:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48233 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfJHIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:22:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iHkkv-0005pC-VS; Tue, 08 Oct 2019 08:22:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: wfx: fix spelling mistake "hexdecimal" -> "hexadecimal"
Date:   Tue,  8 Oct 2019 09:22:05 +0100
Message-Id: <20191008082205.19740-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the documentation and a module parameter
description. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../devicetree/bindings/net/wireless/siliabs,wfx.txt            | 2 +-
 drivers/staging/wfx/main.c                                      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index 15965c9b4180..26de6762b942 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -89,7 +89,7 @@ Some properties are recognized either by SPI and SDIO versions:
    this property, driver will disable most of power saving features.
  - config-file: Use an alternative file as PDS. Default is `wf200.pds`. Only
    necessary for development/debug purpose.
- - slk_key: String representing hexdecimal value of secure link key to use.
+ - slk_key: String representing hexadecimal value of secure link key to use.
    Must contains 64 hexadecimal digits. Not supported in current version.
 
 WFx driver also supports `mac-address` and `local-mac-address` as described in
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index fe9a89703897..d2508bc950fa 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -48,7 +48,7 @@ MODULE_PARM_DESC(gpio_wakeup, "gpio number for wakeup. -1 for none.");
 
 static char *slk_key;
 module_param(slk_key, charp, 0600);
-MODULE_PARM_DESC(slk_key, "secret key for secure link (expect 64 hexdecimal digits).");
+MODULE_PARM_DESC(slk_key, "secret key for secure link (expect 64 hexadecimal digits).");
 
 #define RATETAB_ENT(_rate, _rateid, _flags) { \
 	.bitrate  = (_rate),   \
-- 
2.20.1

