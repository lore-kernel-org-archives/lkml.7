Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36A21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254185;
	bh=aJhk66qRI6GTBKzyoGwJHPVtBkO//33xX3Ay5Aw0kl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2Dt3AJjibbrVA0eWvnZ9ApwBbt0xE22NPgmo4vtkq+QSYqfPSkU2MAQGKFhBaKW8
	 wzx4ZBEwbFYL7KWTcbjGVWWBDHEolL+HGTjyRWlpzCI9BXw0uKmt4iqriHH+PoIVqK
	 W77zQJKIAGLfOJNHOLv7HdnN6dCZpNwVoucX/VLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfCVL3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729825AbfCVL3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C84218B0;
        Fri, 22 Mar 2019 11:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254177;
        bh=aJhk66qRI6GTBKzyoGwJHPVtBkO//33xX3Ay5Aw0kl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ee2W7wIJOT3p7+j3DWjQyx3jYRIU7E91iYF/5LqrhsIAnI+JpgdWasZVdad4ZL2ZP
         tou8nECYhM0lTtYqXxp3rCNRCtp4xhy46uY+skkO+RoMTMnGDyL1NK43OQqFYmblq9
         EnpQhOV8VpTYqffC0vYmCY8OFsPN8xd+/XaqxKvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Mironov <mironov.ivan@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 056/230] USB: serial: cp210x: add ID for Ingenico 3070
Date:   Fri, 22 Mar 2019 12:13:14 +0100
Message-Id: <20190322111240.617927271@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

commit dd9d3d86b08d6a106830364879c42c78db85389c upstream.

Here is how this device appears in kernel log:

	usb 3-1: new full-speed USB device number 18 using xhci_hcd
	usb 3-1: New USB device found, idVendor=0b00, idProduct=3070
	usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
	usb 3-1: Product: Ingenico 3070
	usb 3-1: Manufacturer: Silicon Labs
	usb 3-1: SerialNumber: 0001

Apparently this is a POS terminal with embedded USB-to-Serial converter.

Cc: stable@vger.kernel.org
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -57,6 +57,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x08e6, 0x5501) }, /* Gemalto Prox-PU/CU contactless smartcard reader */
 	{ USB_DEVICE(0x08FD, 0x000A) }, /* Digianswer A/S , ZigBee/802.15.4 MAC Device */
 	{ USB_DEVICE(0x0908, 0x01FF) }, /* Siemens RUGGEDCOM USB Serial Console */
+	{ USB_DEVICE(0x0B00, 0x3070) }, /* Ingenico 3070 */
 	{ USB_DEVICE(0x0BED, 0x1100) }, /* MEI (TM) Cashflow-SC Bill/Voucher Acceptor */
 	{ USB_DEVICE(0x0BED, 0x1101) }, /* MEI series 2000 Combo Acceptor */
 	{ USB_DEVICE(0x0FCF, 0x1003) }, /* Dynastream ANT development board */


