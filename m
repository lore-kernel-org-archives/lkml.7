Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0BD20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497840;
	bh=hbb7MuaPZaqdvEjSeViM3WM9/Zb0UaWiSQzu5+zwwjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=11KbI7CiGxCFwgF/fTyseTkFiNUTiKl6bdH7LxE6P2I+5HLG1AyLndnojkS6oDmiy
	 ahkHmu7yPaqxUlEfuU0+V4MdsRt2VGxDOqYeF8JIlHsy3kXnpjJR1Sz+oP4+jhVYs8
	 82O/C+REsCSqn4R46mOyCZjM7dgosl3icQehR5Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfKKSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfKKSn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:43:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2ED920674;
        Mon, 11 Nov 2019 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497835;
        bh=hbb7MuaPZaqdvEjSeViM3WM9/Zb0UaWiSQzu5+zwwjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJCkj0Fq/QMZxTZbvmuLAqFTQtwYiPjUkbM5LinKQAbaasOm3WJg2bjNFsVE+V7gH
         VgSWDI/CcYgqZv2ht2YobRtHhnQ97q0408mRSm7PxnjHifYCJ0TDM+thWPGbiy3D8w
         VsQl7SfBjG9hcGLa4KK3zwXql1FdP4+OUDEfr5fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 070/125] HID: google: add magnemite/masterball USB ids
Date:   Mon, 11 Nov 2019 19:28:29 +0100
Message-Id: <20191111181449.479293828@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

[ Upstream commit 9e4dbc4646a84b2562ea7c64a542740687ff7daf ]

Add 2 additional hammer-like devices.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-google-hammer.c | 4 ++++
 drivers/hid/hid-ids.h           | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 6bf4da7ad63a5..8cb63ea9977d6 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -120,6 +120,10 @@ static int hammer_input_configured(struct hid_device *hdev,
 static const struct hid_device_id hammer_devices[] = {
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_HAMMER) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MAGNEMITE) },
+	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_MASTERBALL) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6b33117ca60e5..02c263a4c0836 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -466,6 +466,8 @@
 #define USB_DEVICE_ID_GOOGLE_STAFF	0x502b
 #define USB_DEVICE_ID_GOOGLE_WAND	0x502d
 #define USB_DEVICE_ID_GOOGLE_WHISKERS	0x5030
+#define USB_DEVICE_ID_GOOGLE_MASTERBALL	0x503c
+#define USB_DEVICE_ID_GOOGLE_MAGNEMITE	0x503d
 
 #define USB_VENDOR_ID_GOTOP		0x08f2
 #define USB_DEVICE_ID_SUPER_Q2		0x007f
-- 
2.20.1



