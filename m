Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E530C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B69C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfETHGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:06:18 -0400
Received: from skyboo.net ([94.40.87.198]:51518 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbfETHGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:06:17 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hScNA-0005pe-VT; Mon, 20 May 2019 09:06:13 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Mon, 20 May 2019 09:05:58 +0200
Message-Id: <20190520070558.20142-4-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
In-Reply-To: <20190520070558.20142-1-manio@skyboo.net>
References: <20190520070558.20142-1-manio@skyboo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH 4/4] w1: ds2805: rename w1_family struct, fixing c-p typo
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
 drivers/w1/slaves/w1_ds2805.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 29348d283a65..ab349604531a 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -288,7 +288,7 @@ static struct w1_family_ops w1_f0d_fops = {
 	.remove_slave   = w1_f0d_remove_slave,
 };
 
-static struct w1_family w1_family_2d = {
+static struct w1_family w1_family_0d = {
 	.fid = W1_EEPROM_DS2805,
 	.fops = &w1_f0d_fops,
 };
@@ -296,13 +296,13 @@ static struct w1_family w1_family_2d = {
 static int __init w1_f0d_init(void)
 {
 	pr_info("%s()\n", __func__);
-	return w1_register_family(&w1_family_2d);
+	return w1_register_family(&w1_family_0d);
 }
 
 static void __exit w1_f0d_fini(void)
 {
 	pr_info("%s()\n", __func__);
-	w1_unregister_family(&w1_family_2d);
+	w1_unregister_family(&w1_family_0d);
 }
 
 module_init(w1_f0d_init);
-- 
2.19.0.rc1

