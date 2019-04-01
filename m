Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0588E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139524;
	bh=obkyJcG67TnTilAAhd6UlhLEAzAeFHW9kJgru0OrIl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dwc0GOus9qWGwgMPoWncgxxI8ccUUiexBl0qfBSihRojDSH7yHG/s4fzIQsNyny4d
	 YTSSizbOYQvGPFmin5B6VqzXihWeOBvZP7iSZ65lX5l3zajAzLxABekNCf7Lr9yUTo
	 lrd/acn+Qnub4t2ZdflnnM97AxD7m9iNxrWgUVPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbfDARZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbfDARZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F339E2063F;
        Mon,  1 Apr 2019 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139518;
        bh=obkyJcG67TnTilAAhd6UlhLEAzAeFHW9kJgru0OrIl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa6yu6Zr7npi1KQSF2xYYrIFtvu//FymxZfWBPgrjB/Kxu1gS7C00fJewe5FKOop8
         UFlijlfIbyQ9qKmBzc6QSCn90/f1OpdEnfSLYmjblXbZe5vL9N+oWFR4z+VvPo/VR5
         WIcHoER0UUwEA+T0tRVO86CIRvC/eecsChkx3aOk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Uli <t9cpu@web.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 082/107] USB: serial: cp210x: add new device id
Date:   Mon,  1 Apr 2019 19:02:37 +0200
Message-Id: <20190401170053.087020687@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -83,6 +83,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x804E) }, /* Software Bisque Paramount ME build-in converter */
 	{ USB_DEVICE(0x10C4, 0x8053) }, /* Enfora EDG1228 */
 	{ USB_DEVICE(0x10C4, 0x8054) }, /* Enfora GSM2228 */
+	{ USB_DEVICE(0x10C4, 0x8056) }, /* Lorenz Messtechnik devices */
 	{ USB_DEVICE(0x10C4, 0x8066) }, /* Argussoft In-System Programmer */
 	{ USB_DEVICE(0x10C4, 0x806F) }, /* IMS USB to RS422 Converter Cable */
 	{ USB_DEVICE(0x10C4, 0x807A) }, /* Crumb128 board */


