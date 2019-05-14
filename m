Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28134C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE3521473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="JOFFcrn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfENFfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:35:50 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51758 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfENFfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:35:50 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0DF6783640;
        Tue, 14 May 2019 17:35:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557812146;
        bh=wVBdohI/n7MSYwyFNnz215vNMEvAa3jglAQK0ECa5I4=;
        h=From:To:Cc:Subject:Date;
        b=JOFFcrn8RIENx/dQf01nsQ/ykId81TYnfgoIUsH/wt1MwT9B1+5afXa/3TBKJeBRy
         AEEnqOGKWbuAI5mzdKATGmCeNGUm1069Km3FOmPYEv4mrQiIp/x1++bVRhcJrkv5kN
         aLb0ZBSKBwDslYoKxcgiwnVwbYBhSwlvEmpN1ct7v97AwYUH8fmy5SkBxug0sevxmT
         QThL50rqMFLrIZhhvrfa4GsCzA1I4iNrVrxxJyXQg6O2Fwem8t+sbukrz2Tk9K50Oj
         fWDDczmwiSTZlHV3JDjsHQGFw7218LfrzsIFWGGUXuh9x+2ySHzLGWrEQ7nxZsy2ks
         Igr8lOeHCDn1g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cda53b20000>; Tue, 14 May 2019 17:35:46 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 5142F13ED45;
        Tue, 14 May 2019 17:35:46 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id CB2A11E1D5B; Tue, 14 May 2019 17:35:45 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] USB: serial: pl2303: add Allied Telesis VT-Kit3
Date:   Tue, 14 May 2019 17:35:42 +1200
Message-Id: <20190514053542.28047-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is adds the vendor and device id for the AT-VT-Kit3 which is a
pl2303-based device.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 55122ac84518..d7abde14b3cf 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -106,6 +106,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(SANWA_VENDOR_ID, SANWA_PRODUCT_ID) },
 	{ USB_DEVICE(ADLINK_VENDOR_ID, ADLINK_ND6530_PRODUCT_ID) },
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
+	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
=20
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 559941ca884d..b0175f17d1a2 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -155,3 +155,6 @@
 #define SMART_VENDOR_ID	0x0b8c
 #define SMART_PRODUCT_ID	0x2303
=20
+/* Allied Telesis VT-Kit3 */
+#define AT_VENDOR_ID		0x0caa
+#define AT_VTKIT3_PRODUCT_ID	0x3001
--=20
2.21.0

