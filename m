Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4172B206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494754;
	bh=cXsUr080SobksBYfBW9FDNJrCAnWHqZA/gXb0P3qIrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEmCeLuiokyZIYJFnFPq+JeUDuTzF8UN4y2xSeIfbeAks/2yhHo7MX7irqZtVy+ow
	 DiVQswfhupxWBAKpFnz5gAB5UbA9A/rHAlYtIpudWqoadeDcrw8kViw7rTljNVcuNu
	 006t9o3at+KaAF3JdxGZiJZnYHBJmtQDAYy9qyKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404519AbfHVRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391789AbfHVRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:59 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1F6F2341D;
        Thu, 22 Aug 2019 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494698;
        bh=cXsUr080SobksBYfBW9FDNJrCAnWHqZA/gXb0P3qIrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCOrvp+IQWu0faL6EBnUyJ7NI7ctn2J2b4iOVZcMCAOpEByzLuBUXlSBr2Y/PSWzm
         U50KPGuqPIsUYWurQgwWRzaxySm/2VTcIHqHYsmqrDgBA3Ml8RCp+e0X1Agjf6Ctub
         O0/GvegrHcNlSWYxGp7DELVvmH6PsZaVnQCJI7gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rogan Dawes <rogan@dawes.za.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 50/71] USB: serial: option: add D-Link DWM-222 device ID
Date:   Thu, 22 Aug 2019 10:19:25 -0700
Message-Id: <20190822171730.005655525@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
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
@@ -1954,6 +1954,8 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2001, 0x7e35, 0xff),			/* D-Link DWM-222 */
 	  .driver_info = RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x2001, 0x7e3d, 0xff),			/* D-Link DWM-222 A2 */
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e01, 0xff, 0xff, 0xff) },	/* D-Link DWM-152/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x3e02, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/C1 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x07d1, 0x7e11, 0xff, 0xff, 0xff) },	/* D-Link DWM-156/A3 */


