Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864EC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE912711E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfFCQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:20:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57018 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfFCQU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:20:57 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hXphc-0001ur-Rx; Mon, 03 Jun 2019 16:20:53 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] USB: usb-storage: Add new ID to ums-realtek
Date:   Tue,  4 Jun 2019 00:20:49 +0800
Message-Id: <20190603162049.1863-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one more Realtek card reader requires ums-realtek to work
correctly.

Add the device ID to support it.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/storage/unusual_realtek.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/storage/unusual_realtek.h b/drivers/usb/storage/unusual_realtek.h
index 6b2140f966ef..7e14c2d7cf73 100644
--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -17,6 +17,11 @@ UNUSUAL_DEV(0x0bda, 0x0138, 0x0000, 0x9999,
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
 
+UNUSUAL_DEV(0x0bda, 0x0153, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 UNUSUAL_DEV(0x0bda, 0x0158, 0x0000, 0x9999,
 		"Realtek",
 		"USB Card Reader",
-- 
2.17.1

