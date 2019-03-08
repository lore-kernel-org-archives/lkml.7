Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B932D2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049556;
	bh=Gfeq3gE3EXyx6ScdyYGjZV3atiV3NXtQ7+6f9ZNT6/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lvv/PrNsAxZHs9LCPnUPRE+bBTHTngwFl899iR+8gZnLDMR8KbURopCSCI1ByraoP
	 rxMgPcXFyu8M84YxgnZBI9MJMMSWGdGnf1b1U0xZyoGBuUxg778wTYEM9GeZt9PEuj
	 q50zCGSlCD1ZQqtYkMtpr70Piqr4hZm1cNSmgrXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfCHMwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfCHMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDF72085A;
        Fri,  8 Mar 2019 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049552;
        bh=Gfeq3gE3EXyx6ScdyYGjZV3atiV3NXtQ7+6f9ZNT6/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/mKFD/lrlTNC6Nm+bU9mWK8Id9BkIs5zGkplW6ObIRwnURGzBrzbfrhkY2nAvWQT
         XjW+8/CfyVJYXZ+x2o5kXqz8ruALW3oIVsUhZZ0wriVWSWBT+I5X5Hs/wopLcglaQc
         WPoB9B/WkXaYUkaz+t3zuGzFULib/ZFRjfu9/H/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.0 06/46] USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485
Date:   Fri,  8 Mar 2019 13:49:39 +0100
Message-Id: <20190308124902.660375519@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mans Rullgard <mans@mansr.com>

commit 8d7fa3d4ea3f0ca69554215e87411494e6346fdc upstream.

This adds the USB ID of the Hjelmslund Electronics USB485 Iso stick.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    2 ++
 drivers/usb/serial/ftdi_sio_ids.h |    6 ++++++
 2 files changed, 8 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1025,6 +1025,8 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
+	/* EZPrototypes devices */
+	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1309,6 +1309,12 @@
 #define IONICS_PLUGCOMPUTER_PID		0x0102
 
 /*
+ * EZPrototypes (PID reseller)
+ */
+#define EZPROTOTYPES_VID		0x1c40
+#define HJELMSLUND_USB485_ISO_PID	0x0477
+
+/*
  * Dresden Elektronik Sensor Terminal Board
  */
 #define DE_VID			0x1cf1 /* Vendor ID */


