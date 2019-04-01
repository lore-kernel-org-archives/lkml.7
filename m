Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B15921473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139758;
	bh=sNgt0Ks+JyUU5FJ76cCMus7lUmr3VL9VFB59I3RCMy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1TMZTD7eY+IBgZ77gVFgd1mY2HUeEpvGJ2ZZUOSh5rE7696oey057SRVI2z7318AH
	 cpQEoze6ZPcjWhgnK36Zvth/DJrWFo5WuShlQGo2gXPWFeSFUOvUQ+q1iXARyzz/cZ
	 dCrbvccSb7hAqXHEP123Rf4c8zdCRNHBiQH7h050=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfDAR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfDAR3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:29:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DDCD21473;
        Mon,  1 Apr 2019 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139750;
        bh=sNgt0Ks+JyUU5FJ76cCMus7lUmr3VL9VFB59I3RCMy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APWbRCG/Fmo7uYw7oPhu9xqRdZzwvbOAEendN06FkFQMT7j5ajtsD42qFWoWKMQsK
         IynztRKbWbqCnyXNTktVpXscpsaFVorhn0cXggXvqXFQ+zNfYwfrpjAelgnDwzJ5Vw
         NQPaMBspJ3gDbTuUXOzDJrQ3rdgild7J05xzTRbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Uli <t9cpu@web.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 38/56] USB: serial: cp210x: add new device id
Date:   Mon,  1 Apr 2019 19:02:54 +0200
Message-Id: <20190401170106.013707551@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit a595ecdd5f60b2d93863cebb07eec7f935839b54 upstream.

Lorenz Messtechnik has a device that is controlled by the cp210x driver,
so add the device id to the driver.  The device id was provided by
Silicon-Labs for the devices from this vendor.

Reported-by: Uli <t9cpu@web.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -77,6 +77,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME build-in converter */
 	{ USB_DEVICE(0x10C4, 0x8053) }, /* Enfora EDG1228 */
 	{ USB_DEVICE(0x10C4, 0x8054) }, /* Enfora GSM2228 */
+	{ USB_DEVICE(0x10C4, 0x8056) }, /* Lorenz Messtechnik devices */
 	{ USB_DEVICE(0x10C4, 0x8066) }, /* Argussoft In-System Programmer */
 	{ USB_DEVICE(0x10C4, 0x806F) }, /* IMS USB to RS422 Converter Cable */
 	{ USB_DEVICE(0x10C4, 0x807A) }, /* Crumb128 board */


