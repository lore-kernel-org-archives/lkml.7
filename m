Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE07C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B420862
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142730;
	bh=gzEchfM7M9ylyt97dkh+RkFlfZBYYPbqX4JcKuUKC2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=grWbT8ExTozNXwMR9mKUSytFDT3zFO1nsEqPDft2/PXMYdbN0G8406zZlJIHsAMMt
	 DwQ47FIbIDncTVGKmKKionypLOD6KLXAc9/PC4629+d3BUrA7XxOmmtJ2KUGYLeh2v
	 8VCyyMP/hqp9BWuXi0KkYOAPJu+rbLja/9kaayvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfKSFwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731871AbfKSFwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:52:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC0020862;
        Tue, 19 Nov 2019 05:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142726;
        bh=gzEchfM7M9ylyt97dkh+RkFlfZBYYPbqX4JcKuUKC2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdrmkTtfIhOTf+klzyl9j5err08tInpHcBIbnkHIK/uP3q8itU2bJ3O+e9BKtBKFF
         LxGw491TDwLLzLR5yAciXrYV4nq+bhBe6hlL0W32v02BjF2HLNfZ7dr74P+ep3BWhQ
         hl5j72Pq2n0tAIv+IPRlXfJLhWL09KDRqzAjTfpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 180/239] media: au0828: Fix incorrect error messages
Date:   Tue, 19 Nov 2019 06:19:40 +0100
Message-Id: <20191119051334.565050072@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



