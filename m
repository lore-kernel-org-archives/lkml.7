Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BFC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F2A206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLHQPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:15:38 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49514 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbfLHQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:15:37 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id A22E3241768;
        Sun,  8 Dec 2019 17:10:25 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 96D95C20BC6; Sun,  8 Dec 2019 17:10:25 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 04/12] PCMCIA: Remove spaces before tabs
Date:   Sun,  8 Dec 2019 17:09:39 +0100
Message-Id: <20191208160947.20694-5-simon.geis@fau.de>
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
 drivers/pcmcia/i82092.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index bb3014ba329e..2f698d021411 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -42,7 +42,7 @@ static struct pci_driver i82092aa_pci_driver = {
 
 /* the pccard structure and its functions */
 static struct pccard_operations i82092aa_operations = {
-	.init 		 	= i82092aa_init,
+	.init			= i82092aa_init,
 	.get_status		= i82092aa_get_status,
 	.set_socket		= i82092aa_set_socket,
 	.set_io_map		= i82092aa_set_io_map,
@@ -59,7 +59,7 @@ struct socket_info {
 		 * 2 = card but not initialized,
 		 * 3 = operational card
 		 */
-	unsigned int io_base; 	/* base io address of the socket */
+	unsigned int io_base;	/* base io address of the socket */
 
 	struct pcmcia_socket socket;
 	struct pci_dev *dev;	/* The PCI device for the socket */
@@ -326,7 +326,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 			csc = indirect_read(i, I365_CSC); /* card status change register */
 
 			if (csc == 0)  /* no events on this socket */
-			   	continue;
+				continue;
 			handled = 1;
 			events = 0;
 
@@ -334,7 +334,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 				events |= SS_DETECT;
 				dev_info(&sockets[i].dev->dev,
 					 "Card detected in socket %i!\n", i);
-			 }
+			}
 
 			if (indirect_read(i, I365_INTCTL) & I365_PC_IOCARD) {
 				/* For IO/CARDS, bit 0 means "read the card" */
@@ -399,18 +399,18 @@ static int i82092aa_init(struct pcmcia_socket *sock)
 {
 	int i;
 	struct resource res = { .start = 0, .end = 0x0fff };
-        pccard_io_map io = { 0, 0, 0, 0, 1 };
+	pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
 
-        enter("i82092aa_init");
+	enter("i82092aa_init");
 
-        for (i = 0; i < 2; i++) {
-        	io.map = i;
-                i82092aa_set_io_map(sock, &io);
+	for (i = 0; i < 2; i++) {
+		io.map = i;
+		i82092aa_set_io_map(sock, &io);
 	}
-        for (i = 0; i < 5; i++) {
-        	mem.map = i;
-                i82092aa_set_mem_map(sock, &mem);
+	for (i = 0; i < 5; i++) {
+		mem.map = i;
+		i82092aa_set_mem_map(sock, &mem);
 	}
 
 	leave("i82092aa_init");
@@ -653,7 +653,7 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 
 	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
-	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
+		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
 
 
 /*	dev_info(&sock_info->dev->dev,
-- 
2.20.1

