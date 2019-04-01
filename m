Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28548C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157621473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139762;
	bh=iDrNuEwWxS6QuL5QMeftfZRA769BtjjEdTLTTguSTys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HpW9770K3MoAO8Cwgd5KpYItjmLcwqRR9ecaqpYAhPunIWmsJvOYfLOxGlYo4yTCC
	 /O4aDeMIk4o/2JT4bvgkfIrCWKw4u1hi1ZieH2963O2FdkfEfEZ1Ren1Ab+HlVTruc
	 if1g79sJNQJoQxRTIGNbfk3PiZF5VHSMeDDuhMAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbfDAR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732914AbfDAR3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCD420856;
        Mon,  1 Apr 2019 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139756;
        bh=iDrNuEwWxS6QuL5QMeftfZRA769BtjjEdTLTTguSTys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdB6pb02TUoneIA7JeEUhHdMyt9uwLgIbHvOvrTluA+7Wgh6b+eoAOU839Oq1IQIN
         3npxJ8Bin1Yjtiw67lR+0HdqvEGi56Qlb/6sIYjhFKUttbuuxLSewq17rTc6S5sKCB
         sTWtrxlJwKItdtRIq3WoX1LiMIrCTZl0OQvDxRxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        George McCollister <george.mccollister@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 39/56] USB: serial: ftdi_sio: add additional NovaTech products
Date:   Mon,  1 Apr 2019 19:02:55 +0200
Message-Id: <20190401170106.064681728@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George McCollister <george.mccollister@gmail.com>

commit 422c2537ba9d42320f8ab6573940269f87095320 upstream.

Add PIDs for the NovaTech OrionLX+ and Orion I/O so they can be
automatically detected.

Signed-off-by: George McCollister <george.mccollister@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    2 ++
 drivers/usb/serial/ftdi_sio_ids.h |    4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -604,6 +604,8 @@ static const struct usb_device_id id_tab
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLXM_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLX_PLUS_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORION_IO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SYNAPSE_SS200_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CUSTOMWARE_MINIPLEX2_PID) },
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -566,7 +566,9 @@
 /*
  * NovaTech product ids (FTDI_VID)
  */
-#define FTDI_NT_ORIONLXM_PID	0x7c90	/* OrionLXm Substation Automation Platform */
+#define FTDI_NT_ORIONLXM_PID		0x7c90	/* OrionLXm Substation Automation Platform */
+#define FTDI_NT_ORIONLX_PLUS_PID	0x7c91	/* OrionLX+ Substation Automation Platform */
+#define FTDI_NT_ORION_IO_PID		0x7c92	/* Orion I/O */
 
 /*
  * Synapse Wireless product ids (FTDI_VID)


