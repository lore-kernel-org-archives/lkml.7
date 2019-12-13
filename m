Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3205C50714
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E724712
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLMNzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:55:36 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43704 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727489AbfLMNzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 08:55:36 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 6E1F52417E0;
        Fri, 13 Dec 2019 14:55:34 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 5F3BEC20BC7; Fri, 13 Dec 2019 14:55:34 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v3 04/10] PCMCIA/i82092: insert blank line after declarations
Date:   Fri, 13 Dec 2019 14:53:08 +0100
Message-Id: <20191213135311.9111-5-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213135311.9111-1-simon.geis@fau.de>
References: <20191213135311.9111-1-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve readability of the code by inserting a blank line
after variable declarations.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index b957e095bbb6..16431b48fd9e 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -187,6 +187,7 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg += socket * 0x40;
 	port = sockets[socket].io_base;
@@ -202,6 +203,7 @@ static unsigned short indirect_read16(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned short tmp;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg  = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -219,6 +221,7 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -232,6 +235,7 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -249,6 +253,7 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -265,6 +270,7 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -317,6 +323,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 		for (i = 0; i < socket_count; i++) {
 			int csc;
+
 			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
 				continue;
 
@@ -362,6 +369,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 static int card_present(int socketno)
 {
 	unsigned int val;
+
 	enter("card_present");
 
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
-- 
2.20.1

