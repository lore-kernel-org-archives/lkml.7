Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D588FC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7CB218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254185;
	bh=VEpA/bF0++wTY0NgxHMNevRKXr3GZZ1fdVNodjBMEAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oCck1UhJHyGRi//1OQaS4z+wIOuGIqQlt8ElQFtXmPyEb4FNJc5BbUxsii+mFPLjH
	 JrfPFk/pjnGIWyFAQz0prPFLx/ZyIXkc49pad3e4TnAriaP59YdeGewX2XZfLFNyZZ
	 kYPcmXyQ7wQ0sCrzmOCHklUWyVV1hvsowYEpZlx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfCVL3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbfCVL3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E42218B0;
        Fri, 22 Mar 2019 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254181;
        bh=VEpA/bF0++wTY0NgxHMNevRKXr3GZZ1fdVNodjBMEAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVdPXk16i/yrVv7O0P4AJHGE4wzxYU2TwTlnKBY0RKBR67LpaJn20ifENGqWvzb8b
         onhmeGXTMfoGw53UoW78oF9JVzHh/VOVVJ5IIR0uHLJg8FouDi/9pAfQsUTVzocrGJ
         YK0caYvuV1JZJaiSC+wLNiNahW4Ohi9BoE4Spf9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 057/230] USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485
Date:   Fri, 22 Mar 2019 12:13:15 +0100
Message-Id: <20190322111240.684093582@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1020,6 +1020,8 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
+	/* EZPrototypes devices */
+	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1308,6 +1308,12 @@
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


