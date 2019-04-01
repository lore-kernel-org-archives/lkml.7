Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D5B21929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138550;
	bh=ig6oBZ2PiJj83cIJpff6vQn9w0lV7sVqRNshsuVw8hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hwHDhZ0S9GOdptBa9Z2ZiqYras0y78b+c8YcAkAGFx66GyzAwQay3FtrRe4uh8LoH
	 xosZH+T35DgdFbitbmM3J33wqvTn79BXfX7YuBH3+rM/5OELPSddqAkqNzO89IkLSF
	 4kqHTgNPHsZH0NO2zfaY3EHDEiUF6zFy89kwoqwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfDARJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfDARJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB33206B8;
        Mon,  1 Apr 2019 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138543;
        bh=ig6oBZ2PiJj83cIJpff6vQn9w0lV7sVqRNshsuVw8hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El5YNE9NeGYdKYETpXLskzjWm1l+SVNIJ6Zezva1VntNmcl4dZxB0YVnjeMfI9SDt
         +W/XfTzyEo5CNn69lYl/hpujBHStmv29DRhTbLiN4S0r5uFBWWfZt/xEG+H7xYing9
         vq/v8M2bClZlDYFAaK5/mK5gzsux837KbIsiLAbQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.0 098/146] USB: serial: option: add Olicard 600
Date:   Mon,  1 Apr 2019 19:01:50 +0200
Message-Id: <20190401170057.059475190@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Bjørn Mork <bjorn@mork.no>

commit 84f3b43f7378b98b7e3096d5499de75183d4347c upstream.

This is a Qualcomm based device with a QMI function on interface 4.
It is mode switched from 2020:2030 using a standard eject message.

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2020 ProdID=2031 Rev= 2.32
S:  Manufacturer=Mobile Connect
S:  Product=Mobile Connect
S:  SerialNumber=0123456789ABCDEF
C:* #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=08(stor.) Sub=06 Prot=50 Driver=(none)
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=125us

Cc: stable@vger.kernel.org
Signed-off-by: Bjørn Mork <bjorn@mork.no>
[ johan: use tabs to align comments in adjacent lines ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1945,10 +1945,12 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2001, 0x7e35, 0xff),			/* D-Link DWM-222 */
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) }, /* D-Link DWM-152/C1 */
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) }, /* D-Link DWM-156/C1 */
-	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) }, /* D-Link DWM-156/A3 */
-	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x4000, 0xff) },                /* OLICARD300 - MT6225 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) },	/* D-Link DWM-152/C1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/C1 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/A3 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x2031, 0xff),			/* Olicard 600 */
+	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2020, 0x4000, 0xff) },			/* OLICARD300 - MT6225 */
 	{ USB_DEVICE(INOVIA_VENDOR_ID, INOVIA_SEW858) },
 	{ USB_DEVICE(VIATELECOM_VENDOR_ID, VIATELECOM_PRODUCT_CDS7) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD200, 0xff, 0xff, 0xff) },


