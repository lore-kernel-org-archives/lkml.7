Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF66BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0CD2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgAINFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:05:49 -0500
Received: from mailout2.hostsharing.net ([83.223.78.233]:59857 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbgAINFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:05:49 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 6171B103B6726;
        Thu,  9 Jan 2020 13:56:47 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 1487660AD61A;
        Thu,  9 Jan 2020 13:56:47 +0100 (CET)
X-Mailbox-Line: From 4d77a67d77a1c699e9a6cc3e73044c31c02d60b5 Mon Sep 17 00:00:00 2001
Message-Id: <4d77a67d77a1c699e9a6cc3e73044c31c02d60b5.1578574427.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 9 Jan 2020 13:56:26 +0100
Subject: [PATCH] vt: Delete comment referencing non-existent
 unbind_con_driver()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Wang YanQing <udknight@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c1f5e38a5d35 ("vt: delete unneeded function unbind_con_driver")
removed unbind_con_driver() but retained a comment referencing the
function.  Delete it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Wang YanQing <udknight@gmail.com>
---
 drivers/tty/vt/vt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d1aed9..390d96741612 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3567,7 +3567,6 @@ static int do_bind_con_driver(const struct consw *csw, int first, int last,
 
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
-/* unlocked version of unbind_con_driver() */
 int do_unbind_con_driver(const struct consw *csw, int first, int last, int deflt)
 {
 	struct module *owner = csw->owner;
-- 
2.24.0

