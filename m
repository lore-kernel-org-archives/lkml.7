Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FECC17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DC6222BE
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353802;
	bh=gzEchfM7M9ylyt97dkh+RkFlfZBYYPbqX4JcKuUKC2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjIGLQZGg6oZN5AOEffisT2RWcIugGSgiRZaLkdgb7r2Z3PrjpTPYZkbeFzSQinLy
	 5PnQpapevv7lDk5PgcYOzSVf1W6M9HNrm3v63Aa0yb0RP8g9uiS+Mq1rH0scD0qCtG
	 6lypbS1mmJdfnWb1lUDBLJvaMLt+Y0MSDE+FkkNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfKJCnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfKJCnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:43:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7B021848;
        Sun, 10 Nov 2019 02:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353795;
        bh=gzEchfM7M9ylyt97dkh+RkFlfZBYYPbqX4JcKuUKC2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGfnF+2z9yFd/nwjAnDj87XVajMAXltviGtPTbgOaD9tj93hlKpAHmZw5UJRugCIr
         KfuzSuFGAKuBNaUehD0ngQ7nGjMi2V0mjPDdg7QemcbKQYrlOhaViYmWtty54j5SLK
         bmB7Iv+ww428o8RAauUUsqTkoDl1+HT/XMmROEg4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brad Love <brad@nextdimension.cc>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 094/191] media: au0828: Fix incorrect error messages
Date:   Sat,  9 Nov 2019 21:38:36 -0500
Message-Id: <20191110024013.29782-94-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit f347596f2bf114a3af3d80201c6e6bef538d884f ]

Correcting red herring error messages.

Where appropriate, replaces au0282_dev_register with:
- au0828_analog_register
- au0828_dvb_register

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/au0828/au0828-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index e3f63299f85c0..07e3322bb1827 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -632,7 +632,7 @@ static int au0828_usb_probe(struct usb_interface *interface,
 	/* Analog TV */
 	retval = au0828_analog_register(dev, interface);
 	if (retval) {
-		pr_err("%s() au0282_dev_register failed to register on V4L2\n",
+		pr_err("%s() au0828_analog_register failed to register on V4L2\n",
 			__func__);
 		mutex_unlock(&dev->lock);
 		goto done;
@@ -641,7 +641,7 @@ static int au0828_usb_probe(struct usb_interface *interface,
 	/* Digital TV */
 	retval = au0828_dvb_register(dev);
 	if (retval)
-		pr_err("%s() au0282_dev_register failed\n",
+		pr_err("%s() au0828_dvb_register failed\n",
 		       __func__);
 
 	/* Remote controller */
-- 
2.20.1

