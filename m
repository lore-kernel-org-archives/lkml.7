Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F71C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB2520865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119642;
	bh=dHg+UqiT6WV5wD4kJBwsxxJ5umjrfYXlD5jeO2Zj59U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7N5p5BKs0N4AOgmiz2zIMHgFs639ABF6mbUwH1KDsahwnIcgAcZyVii/9XVGVQmz
	 jF4hV0yAYKhQ2sBOnaRtC8492iQ1S9q/eNCCl1Tv8QZ6bEI0eU/Y/oIxZOwzLeeHzo
	 e71uQ/w12iXcU+SpH5WUaV8CGK8WBXLJqaZDkbPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbfJCQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389958AbfJCQUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:20:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFD420865;
        Thu,  3 Oct 2019 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119639;
        bh=dHg+UqiT6WV5wD4kJBwsxxJ5umjrfYXlD5jeO2Zj59U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZR/JmqcZZxroWN5d8O2DItglIW0zwiXBRYsrH9dDiWgc3KoljDRSzakxejT9dSt6y
         c00a8NHkvntAdNBjaVRD3PFdEdzPDRgCI1TtYNnhPRMGcQFhuHLI4ek2I6y4UA8kZn
         4B5GtPdDyvNfWF9RDgcwHvrAmvfljWggYNL7ZKgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Easton <kevin@guarana.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com
Subject: [PATCH 4.19 138/211] libertas: Add missing sentinel at end of if_usb.c fw_table
Date:   Thu,  3 Oct 2019 17:53:24 +0200
Message-Id: <20191003154518.668175054@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Easton <kevin@guarana.org>

[ Upstream commit 764f3f1ecffc434096e0a2b02f1a6cc964a89df6 ]

This sentinel tells the firmware loading process when to stop.

Reported-and-tested-by: syzbot+98156c174c5a2cad9f8f@syzkaller.appspotmail.com
Signed-off-by: Kevin Easton <kevin@guarana.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_usb.c b/drivers/net/wireless/marvell/libertas/if_usb.c
index 3dbfce972c56b..9e82ec12564bb 100644
--- a/drivers/net/wireless/marvell/libertas/if_usb.c
+++ b/drivers/net/wireless/marvell/libertas/if_usb.c
@@ -49,7 +49,8 @@ static const struct lbs_fw_table fw_table[] = {
 	{ MODEL_8388, "libertas/usb8388_v5.bin", NULL },
 	{ MODEL_8388, "libertas/usb8388.bin", NULL },
 	{ MODEL_8388, "usb8388.bin", NULL },
-	{ MODEL_8682, "libertas/usb8682.bin", NULL }
+	{ MODEL_8682, "libertas/usb8682.bin", NULL },
+	{ 0, NULL, NULL }
 };
 
 static const struct usb_device_id if_usb_table[] = {
-- 
2.20.1



