Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855AC33CA3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CEE2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgAHTqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:46:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43390 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728474AbgAHTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:46:00 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHB-0006nk-DH; Wed, 08 Jan 2020 19:45:57 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1ipHHA-007dkf-Vk; Wed, 08 Jan 2020 19:45:56 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jiri Kosina" <jkosina@suse.cz>,
        "Roderick Colenbrander" <roderick.colenbrander@sony.com>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
Date:   Wed, 08 Jan 2020 19:43:01 +0000
Message-ID: <lsq.1578512578.408797056@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 03/63] HID: sony: Update device ids
In-Reply-To: <lsq.1578512578.117275639@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.81-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

commit cf1015d65d7c8a5504a4c03afb60fb86bff0f032 upstream.

Support additional DS4 model.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-core.c | 2 ++
 drivers/hid/hid-ids.h  | 1 +
 drivers/hid/hid-sony.c | 4 ++++
 3 files changed, 7 insertions(+)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1932,6 +1932,8 @@ static const struct hid_device_id hid_ha
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -876,6 +876,7 @@
 #define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2	0x09cc
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1998,6 +1998,10 @@ static const struct hid_device_id sony_d
 		.driver_data = DUALSHOCK4_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 		.driver_data = DUALSHOCK4_CONTROLLER_BT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
+		.driver_data = DUALSHOCK4_CONTROLLER_USB },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
+		.driver_data = DUALSHOCK4_CONTROLLER_BT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);

