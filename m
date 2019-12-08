Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4FC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8A20692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLHQUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:20:38 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49694 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbfLHQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:20:36 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 004AF24177B;
        Sun,  8 Dec 2019 17:10:37 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id E5D35C20BC6; Sun,  8 Dec 2019 17:10:36 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 06/12] PCMCIA: insert blank line after declarations
Date:   Sun,  8 Dec 2019 17:09:41 +0100
Message-Id: <20191208160947.20694-7-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 0adac6b24915..b9366adfe087 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -188,6 +188,7 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg += socket * 0x40;
 	port = sockets[socket].io_base;
@@ -203,6 +204,7 @@ static unsigned short indirect_read16(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned short tmp;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg  = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -220,6 +222,7 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -233,6 +236,7 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -250,6 +254,7 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -266,6 +271,7 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
+
 	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
@@ -318,6 +324,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 
 		for (i = 0; i < socket_count; i++) {
 			int csc;
+
 			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
 				continue;
 
@@ -363,6 +370,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 static int card_present(int socketno)
 {
 	unsigned int val;
+
 	enter("card_present");
 
 	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
-- 
2.20.1

