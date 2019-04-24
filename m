Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC61C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB1C218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfDXNQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfDXNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:16:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5C0A3076C60;
        Wed, 24 Apr 2019 13:16:42 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-226.ams2.redhat.com [10.36.116.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13B4E5D9C8;
        Wed, 24 Apr 2019 13:16:38 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] HID: logitech-dj: add usbhid dependency in Kconfig
Date:   Wed, 24 Apr 2019 15:16:36 +0200
Message-Id: <20190424131636.8320-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 24 Apr 2019 13:16:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An oversight from me.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 76d82063d8d2..c3c390ca3690 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -521,6 +521,7 @@ config HID_LOGITECH
 
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
+	depends on USB_HID
 	depends on HIDRAW
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
-- 
2.19.2

