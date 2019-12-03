Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236D92080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413016;
	bh=2od75twyd8JsIVh0E+fMHEG4l6sBN9ezELJsWv4ca5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AEqBpodjavlqz2WpzlLUsigcPNsIzPqE7nsIOjxvBAQJ6CpJqguxEsXhmOVViETTy
	 7ehy+SoP7WQzrEa9zWGj1V+rogWfttCA4u4S410LVtpMQSxs33WZHQ/AJAZPWYRTXY
	 bW3hzTF0OA1d+sa1W+HRY0QWBDTwDSEsHe0SZHew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfLCWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:43:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfLCWnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:43:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA902080F;
        Tue,  3 Dec 2019 22:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413012;
        bh=2od75twyd8JsIVh0E+fMHEG4l6sBN9ezELJsWv4ca5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJtCeLOQ23zmxAwAxj6vmeSMMMLVBCy4vxTy72JGijiM2z2euhcuoQLbdFXZeGQJm
         EUIFKdY0HQv4ZBcKWvOok2Ec3kKlv7xdBu5wlhucxQtiDwRJUK9JoR6/jVM40N8htl
         x9bZJKGhwwG7sGXBHl+6f6CZq/IcVVH3fyvdbh88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        youling257 <youling257@gmail.com>
Subject: [PATCH 5.3 102/135] staging: rtl8723bs: Add 024c:0525 to the list of SDIO device-ids
Date:   Tue,  3 Dec 2019 23:35:42 +0100
Message-Id: <20191203213039.714933124@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 3d5f1eedbfd22ceea94b39989d6021b1958181f4 upstream.

Add 024c:0525 to the list of SDIO device-ids, based on a patch found
in the Android X86 kernels. According to that patch this device id is
used on the Alcatel Plus 10 device.

Reported-and-tested-by: youling257 <youling257@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191111113846.24940-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -18,6 +18,7 @@
 static const struct sdio_device_id sdio_ids[] =
 {
 	{ SDIO_DEVICE(0x024c, 0x0523), },
+	{ SDIO_DEVICE(0x024c, 0x0525), },
 	{ SDIO_DEVICE(0x024c, 0x0623), },
 	{ SDIO_DEVICE(0x024c, 0x0626), },
 	{ SDIO_DEVICE(0x024c, 0xb723), },


