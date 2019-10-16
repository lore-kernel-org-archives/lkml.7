Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DEBECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8FC207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264037;
	bh=OLGdegQHa3DJYJi1u/8icXbWKnf3l+8tAQ9VivWuHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDvVqBmep2XboRJaOKXn+Oib0Nimv1Vodnhg18srF82qwssp2sPUQ6Mf8m6mh2z+b
	 4/eLIwja7dfIe5v25x/M1fh4Ffrp8HtxdOCJ9Q5Ozki7E7YEHEq9/mA4X94p77UD+z
	 B6PVrxbdHvOn/UmK2fbcro3/fz2PxNC2mdj8I5m8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395335AbfJPVzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395278AbfJPVzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:37 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595E221D7E;
        Wed, 16 Oct 2019 21:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262937;
        bh=OLGdegQHa3DJYJi1u/8icXbWKnf3l+8tAQ9VivWuHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/aeE6Li2KpMw+Nv3nQYLuPE7LogVJcA268v/JBmR/Bp/PQCF9/FHUntI8CZUhDR1
         64QJTfF8gqioClzJbJRQieg4pkZWxE3oA/7a7Uh4H2qAITl+2nyTcKalCe1phRKFcb
         W/z3ozCc2oCb9omIc1QgS3eZfeYVOvwV6/k8iDU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beni Mahler <beni.mahler@gmx.net>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 59/92] USB: serial: ftdi_sio: add device IDs for Sienna and Echelon PL-20
Date:   Wed, 16 Oct 2019 14:50:32 -0700
Message-Id: <20191016214839.925722149@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beni Mahler <beni.mahler@gmx.net>

commit 357f16d9e0194cdbc36531ff88b453481560b76a upstream.

Both devices added here have a FTDI chip inside. The device from Echelon
is called 'Network Interface' it is actually a LON network gateway.

 ID 0403:8348 Future Technology Devices International, Ltd
 https://www.eltako.com/fileadmin/downloads/de/datenblatt/Datenblatt_PL-SW-PROF.pdf

 ID 0920:7500 Network Interface
 https://www.echelon.com/products/u20-usb-network-interface

Signed-off-by: Beni Mahler <beni.mahler@gmx.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/ftdi_sio.c     |    3 +++
 drivers/usb/serial/ftdi_sio_ids.h |    9 +++++++++
 2 files changed, 12 insertions(+)

--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1025,6 +1025,9 @@ static const struct usb_device_id id_tab
 	/* EZPrototypes devices */
 	{ USB_DEVICE(EZPROTOTYPES_VID, HJELMSLUND_USB485_ISO_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(UNJO_VID, UNJO_ISODEBUG_V1_PID, 1) },
+	/* Sienna devices */
+	{ USB_DEVICE(FTDI_VID, FTDI_SIENNA_PID) },
+	{ USB_DEVICE(ECHELON_VID, ECHELON_U20_PID) },
 	{ }					/* Terminating entry */
 };
 
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -38,6 +38,9 @@
 
 #define FTDI_LUMEL_PD12_PID	0x6002
 
+/* Sienna Serial Interface by Secyourit GmbH */
+#define FTDI_SIENNA_PID		0x8348
+
 /* Cyber Cortex AV by Fabulous Silicon (http://fabuloussilicon.com) */
 #define CYBER_CORTEX_AV_PID	0x8698
 
@@ -688,6 +691,12 @@
 #define BANDB_ZZ_PROG1_USB_PID	0xBA02
 
 /*
+ * Echelon USB Serial Interface
+ */
+#define ECHELON_VID		0x0920
+#define ECHELON_U20_PID		0x7500
+
+/*
  * Intrepid Control Systems (http://www.intrepidcs.com/) ValueCAN and NeoVI
  */
 #define INTREPID_VID		0x093C


