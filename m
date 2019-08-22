Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB82064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495058;
	bh=bl6h+i39CPa14wyHRXrszytE1t+2O+Ahzz8FE8BE0/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsn5el8xtx360yDtpIJN2SGW0512/6asTLHsMCOD8NFf4eoTG8FEtXM4Z+Gx9Eqk9
	 lT7Ahd1YsL0IcxUx6aJj9gSvIixy6IePIWJRZWsgsRXoam5OVjzzLY5/iTNLWaeRRc
	 mzFU5TlZzqRshiN0Os5V4HGTvtoOHTtR1XXdRn1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392184AbfHVRa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404578AbfHVR0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:02 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FDC72341F;
        Thu, 22 Aug 2019 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494761;
        bh=bl6h+i39CPa14wyHRXrszytE1t+2O+Ahzz8FE8BE0/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTLF+BSKlMujALC3vQ7Blk4a7KfOA8gwzQnzubmggkXzE8W9mdTWVa3DEFo9gSiQk
         wCIRd5G8rro6OHNhjKY4FufsbddYQgG47G903rYjE4hFfDgRwj4dK0ThMGk5VjEkQo
         YL6rFeJshxJvLFpoglgdA1itL24qXAHb1YGAdOZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rogan Dawes <rogan@dawes.za.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 63/85] USB: serial: option: add D-Link DWM-222 device ID
Date:   Thu, 22 Aug 2019 10:19:36 -0700
Message-Id: <20190822171733.953005596@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rogan Dawes <rogan@dawes.za.net>

commit 552573e42aab5f75aff9bab855a9677979d9a7d5 upstream.

Add device id for D-Link DWM-222 A2.

MI_00 D-Link HS-USB Diagnostics
MI_01 D-Link HS-USB Modem
MI_02 D-Link HS-USB AT Port
MI_03 D-Link HS-USB NMEA
MI_04 D-Link HS-USB WWAN Adapter (qmi_wwan)
MI_05 USB Mass Storage Device

Cc: stable@vger.kernel.org
Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1952,6 +1952,8 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2001, 0x7e35, 0xff),			/* D-Link DWM-222 */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2001, 0x7e3d, 0xff),			/* D-Link DWM-222 A2 */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) },	/* D-Link DWM-152/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/A3 */


