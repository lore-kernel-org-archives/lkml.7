Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C630FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991A0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411807;
	bh=hUvacjgJrtFiS3NZqGVP5ghXL0bdXlJDJbt7vOeoHqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MBCkzD6OqBeellH3FdwwMNLgjjkkaAlbK6dSabCQwEhtjlRCQKjGRJPHs9M/S7GeJ
	 omP4X1ZzE8Iyv4NyIA0GrfAljETetm4WlCi2lpTKR7XxCt5/HDUS2X+8vjAyw149Yh
	 8tiHItXmQ8aowxNGIymyLkLRswIsC/7MWqadOII8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfCLRaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbfCLRRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:21 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F222087C;
        Tue, 12 Mar 2019 17:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411040;
        bh=hUvacjgJrtFiS3NZqGVP5ghXL0bdXlJDJbt7vOeoHqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2ogtvlA4jA7NJC2sdp3rn5MpcCUkRJ5upbwuQlZvs0JPS6gD8etvAnkIIxXH9xUh
         36W1WH9aypkgTyO7kR/2UI7TRnu1uSWfjNSVLb+Ru6IeuMBYFIEpUCPNCfmKYvJNm2
         QZ1qZcjRkXybRLxpxFqB44TnsVTjOmOFAvvw2N5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 03/96] USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485
Date:   Tue, 12 Mar 2019 10:09:21 -0700
Message-Id: <20190312171034.801446109@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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


