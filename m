Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A82CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AF217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905115;
	bh=a7lsjfD5XOqATd/HHMEqnA12kAyKJex2d6w/wuLsBQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHEZiZJnfXShTK2uL8eLVq41Ya7x27o5Qst6xlsSogk6mOWWuLNGHVr+Ec7rqur6m
	 M39xTt6bZClUPmYnXLeK8qRdAdtHOWlebXkTZfXLPgtAHo8k5b3CSF7PFyScqnxAPo
	 ahV9sYom0pt5bAYVMckoVSTeo4d+cwjhpMamC9WY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfKDWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389811AbfKDWFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:05:11 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9281217F4;
        Mon,  4 Nov 2019 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905111;
        bh=a7lsjfD5XOqATd/HHMEqnA12kAyKJex2d6w/wuLsBQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7H2bOa4Eq7IUMJvFLhg3WhO72A+NnoOmPR+qO6WIQE598eftmTJGPig4dTdFD7Ij
         wbDRnwGjs7GrkcMjoPHDPWw6iNSMAYkVw32bxngKiF4OfsolzoYYSfK+qmuEGhD7U+
         xTvRJOMCI0M6lMy9GUYNFnNutRAawPOE8faUm/pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 032/163] tty: serial: owl: Fix the link time qualifier of owl_uart_exit()
Date:   Mon,  4 Nov 2019 22:43:42 +0100
Message-Id: <20191104212142.607391192@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 6264dab6efd6069f0387efb078a9960b5642377b ]

'exit' functions should be marked as __exit, not __init.

Fixes: fc60a8b675bd ("tty: serial: owl: Implement console driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20190910041129.6978-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/owl-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23c..73fcc6bdb0312 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -742,7 +742,7 @@ static int __init owl_uart_init(void)
 	return ret;
 }
 
-static void __init owl_uart_exit(void)
+static void __exit owl_uart_exit(void)
 {
 	platform_driver_unregister(&owl_uart_platform_driver);
 	uart_unregister_driver(&owl_uart_driver);
-- 
2.20.1



