Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D15C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BED20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355006;
	bh=7msc1tKFakpzZ9gI2yrE7V/oN5Mph5vD65JhgljuaQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Usa0liygbhI5qv7GOOliVum6x538HjB2CDIH+dGcESZ+Nj0WY82fbxLeGEz+Qb8Gq
	 EYDMWkBbOVX/1aT7gLsTkjXU70mTdLUUBlrXEd6wD9LtjNOrh0fwIRRXuqfJBR+3zy
	 bMc4bMbB/ALNB63pN/JMTjhtF0+JRqTZM6aboM7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbfETMX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388584AbfETMXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:23:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545E120675;
        Mon, 20 May 2019 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355003;
        bh=7msc1tKFakpzZ9gI2yrE7V/oN5Mph5vD65JhgljuaQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NR5VXJvcejvFQYg2HQVquPZUH/GrWer2HG3fJEfwCkWA1ho0Vha1s0mdWR53I918o
         lEXIHnK0TQUc8CyBvW+CV6LxiM+KKLwfANAc2RBa+ukLXA697Q96qb1jhl73E9aUMc
         h9ynt1wTnOkNSoWe9xW+7moIJjvpoxWBEGYtdcUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 061/105] mfd: max77620: Fix swapped FPS_PERIOD_MAX_US values
Date:   Mon, 20 May 2019 14:14:07 +0200
Message-Id: <20190520115251.355430786@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit ea611d1cc180fbb56982c83cd5142a2b34881f5c upstream.

The FPS_PERIOD_MAX_US definitions are swapped for MAX20024 and MAX77620,
fix it.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mfd/max77620.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -136,8 +136,8 @@
 #define MAX77620_FPS_PERIOD_MIN_US		40
 #define MAX20024_FPS_PERIOD_MIN_US		20
 
-#define MAX77620_FPS_PERIOD_MAX_US		2560
-#define MAX20024_FPS_PERIOD_MAX_US		5120
+#define MAX20024_FPS_PERIOD_MAX_US		2560
+#define MAX77620_FPS_PERIOD_MAX_US		5120
 
 #define MAX77620_REG_FPS_GPIO1			0x54
 #define MAX77620_REG_FPS_GPIO2			0x55


