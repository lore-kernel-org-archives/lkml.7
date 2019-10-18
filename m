Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4865520640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437638;
	bh=a7lsjfD5XOqATd/HHMEqnA12kAyKJex2d6w/wuLsBQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gdjHzn9XH+FV2e2hcvuVpzvev6GcIxhCYTyqgsCbK3I6RhY5xIrgjD7NL28a6g/oJ
	 vGT96UtVwDyLv00R8yeZjVfi1n7pKWnyQ6x+XRIV5uS3/hacs9Ik01rPu9QTrsS9hb
	 s+5TUnoSgQD1iwIP+bSuj7DKIT9NZeusbC6bYSbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406387AbfJRW1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfJRWEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9752246A;
        Fri, 18 Oct 2019 22:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436243;
        bh=a7lsjfD5XOqATd/HHMEqnA12kAyKJex2d6w/wuLsBQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOvscl0bkm45WNJOAu1nCLtf1L5BpeMYQW4Pl4vx9hMc+Fakmgq4lAHaTklfTNP+r
         U95+8NxdJTq2M/zqaV+A0yf8HLTQuA8xlkXVZovR3V7KEF21SNQpJ7tFHfJlngg8zp
         tyFO/53ILPoSiImSTxnGcaTM1CSKrsbmbw1Sa7xs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 28/89] tty: serial: owl: Fix the link time qualifier of 'owl_uart_exit()'
Date:   Fri, 18 Oct 2019 18:02:23 -0400
Message-Id: <20191018220324.8165-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

