Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BU6Sy5I+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCDKPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:15:19 -0500
Received: from mail.hundeboll.net ([88.198.92.70]:55658 "EHLO
        mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDKPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:15:19 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 05:15:18 EST
Received: from skn-laptop.serenergy.local (unknown [89.221.170.34])
        by mail.hundeboll.net (Postfix) with ESMTPSA id E41651C3CAB;
        Mon,  4 Mar 2019 11:08:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com;
        s=hundeboll; t=1551694103;
        bh=7hzfeuKu5PlyczmSh/VHMIWAGrFnhrXh2ARLi9+s5Hs=;
        h=From:To:Cc:Subject:Date;
        b=BU6Sy5I+uH1HUwAwe4SAxuAeURAK3jG6+108BXMC4O405r+qzmYEvV2PC3Qg6fvWq
         qOYzqjpO8ogTAde0J76yrh33b3WWlYV34w5EMkxQQu2lzxbdOzYksmvxo0i1EvDTdi
         79iroIjht5VOYzLqOImYsCeULA4QinRtwRy4MZ9O1Frwo/UidzMZ9KRUDJaNbOCkzT
         Oa+6a2afd/iC54Oa6leDEEBWA2pW1Zmcgi3DGkzfSQMbhMTawR7vn4BhyCmbcm4IvQ
         odyGcMbvJxsD5zAbtHb+FNz3mfZZ0lTtBUqI2x4rXhteaH7SN2qw/kUnHommiMEevc
         tpQ3CXf7+Jaqw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org
Subject: [PATCH] mailmap: Update email for Sean Nyekjaer
Date:   Mon,  4 Mar 2019 11:08:08 +0100
Message-Id: <20190304100808.7391-1-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I'll no longer be working with Prevas, add a mailmap entry so
any mail directed towards me reaches the appropriate mailbox.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ea98fcc197e4..4087826d8753 100644
--- a/.mailmap
+++ b/.mailmap
@@ -186,6 +186,7 @@ Santosh Shilimkar <ssantosh@kernel.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 S.Çağlar Onur <caglar@pardus.org.tr>
+Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
-- 
2.21.0

