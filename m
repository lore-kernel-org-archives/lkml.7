Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E32C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E672070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574342943;
	bh=tNWvoPXSaRpuFIsU8oDqXtHXbsh3Jbs2EGRtmTxYfhU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VxhCxaDgQOjEfp2ZfzuFoyAOms4VUHRF/zjGkAbPW1X3V1bTYJNVmGwD85mFC+LER
	 vWGRbY1YgPBE/8iaVxcZnBPnlBsmDI45ZnhXsCOZMRZgZ7acaC2KwLz8RBHDebrFMz
	 5yide556/A6Y1pjtZNp8AGvwgfppBeRpl+JXDYEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKUN3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfKUN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:00 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A692067D;
        Thu, 21 Nov 2019 13:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342940;
        bh=tNWvoPXSaRpuFIsU8oDqXtHXbsh3Jbs2EGRtmTxYfhU=;
        h=From:To:Cc:Subject:Date:From;
        b=h2K44BZiUxE6gXUCb3vxe/ZoY4HHwFT8UcBmjeILen+rmF78zvP5KNFIkwFUEbOOs
         DF61ATB3CkvOJvzYtGb4MUhjk5jZxsfVECKjKDL/9ssZ5GqgbWodOlfXMdLA57d6MP
         eCVz0zQDG0uvkksMUfPTy6772MokTSVT11nQCpiw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: serial: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:28:56 +0800
Message-Id: <20191121132856.29130-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/serial/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index 0a8c16a8cda2..ed4a18b435a0 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -269,16 +269,16 @@ config USB_SERIAL_F8153X
 
 
 config USB_SERIAL_GARMIN
-       tristate "USB Garmin GPS driver"
-       help
-	 Say Y here if you want to connect to your Garmin GPS.
-	 Should work with most Garmin GPS devices which have a native USB port.
+	tristate "USB Garmin GPS driver"
+	help
+	  Say Y here if you want to connect to your Garmin GPS.
+	  Should work with most Garmin GPS devices which have a native USB port.
 
-	 See <http://sourceforge.net/projects/garmin-gps> for the latest
-	 version of the driver.
+	  See <http://sourceforge.net/projects/garmin-gps> for the latest
+	  version of the driver.
 
-	 To compile this driver as a module, choose M here: the
-	 module will be called garmin_gps.
+	  To compile this driver as a module, choose M here: the
+	  module will be called garmin_gps.
 
 config USB_SERIAL_IPW
 	tristate "USB IPWireless (3G UMTS TDD) Driver"
-- 
2.17.1

