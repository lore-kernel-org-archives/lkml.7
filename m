Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C996DC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973162082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520308;
	bh=Iah1quRuK9hK5kP9iRQTZ+LpXwyJPEqiQgOiLMZsleI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xw1LK/CXHxk94z1Lp4fBPE4zi5i/VaXEjgfLFmDKd7hfLYKJwtGgUFg7q8WAxTFL8
	 WykIxqfvdOxrK5hmWF2bFF69+HffF26zGO2R9Vr7Uetuv9ZV14KOrU9tetHTgl8h92
	 GoJeO42WQ7gAkWDqT7VWM+fIDXsLsdLVBPt8tPPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbfLPSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbfLPSSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:18:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A776C206EC;
        Mon, 16 Dec 2019 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520303;
        bh=Iah1quRuK9hK5kP9iRQTZ+LpXwyJPEqiQgOiLMZsleI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAL7teDU9ltcJQzb+T7GWBY9OmWrmxRUlO5hxcg5Qtlt77UnE9N1AFF/9QUj5Jhd0
         PecB6Xc135BGHtsYoBthmBT/k6nq8QtTj/XYiv7hFE15pQEK4g93NeD0jcTu5o5ZMG
         Q5sFuw2qAWg/fcfjc3VUcD01Taxiqp9SKdc8Jtqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.4 100/177] media: vimc: sen: remove unused kthread_sen field
Date:   Mon, 16 Dec 2019 18:49:16 +0100
Message-Id: <20191216174840.979913530@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

commit 3ea35d5db448c27807acbcc7a2306cf65c5e6397 upstream.

The field kthread_sen in the vimc_sen_device is
not set and used. So remove the field and
the code that check if it is non NULL

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc: <stable@vger.kernel.org>      # for v5.4 and up
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vimc/vimc-sensor.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -25,7 +25,6 @@ struct vimc_sen_device {
 	struct v4l2_subdev sd;
 	struct device *dev;
 	struct tpg_data tpg;
-	struct task_struct *kthread_sen;
 	u8 *frame;
 	/* The active format */
 	struct v4l2_mbus_framefmt mbus_format;
@@ -208,10 +207,6 @@ static int vimc_sen_s_stream(struct v4l2
 		const struct vimc_pix_map *vpix;
 		unsigned int frame_size;
 
-		if (vsen->kthread_sen)
-			/* tpg is already executing */
-			return 0;
-
 		/* Calculate the frame size */
 		vpix = vimc_pix_map_by_code(vsen->mbus_format.code);
 		frame_size = vsen->mbus_format.width * vpix->bpp *


