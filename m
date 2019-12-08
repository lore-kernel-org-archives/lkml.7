Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD9C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82B9206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLHQPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:15:42 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49522 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfLHQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:15:40 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [131.188.30.136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 9D2E0241754;
        Sun,  8 Dec 2019 17:10:20 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id 91DD4C20BC6; Sun,  8 Dec 2019 17:10:20 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 03/12]  PCMCIA: add/remove wrong spaces
Date:   Sun,  8 Dec 2019 17:09:38 +0100
Message-Id: <20191208160947.20694-4-simon.geis@fau.de>
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
 drivers/pcmcia/i82092.c | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 4d189af52afb..bb3014ba329e 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -81,7 +81,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		return ret;
 
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
-	switch(configbyte&6) {
+	switch (configbyte&6) {
 		case 0:
 			socket_count = 2;
 			break;
@@ -107,7 +107,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		goto err_out_disable;
 	}
 
-	for (i = 0;i<socket_count;i++) {
+	for (i = 0; i < socket_count; i++) {
 		sockets[i].card_state = 1; /* 1 = present but empty */
 		sockets[i].io_base = pci_resource_start(dev, 0);
 		sockets[i].socket.features |= SS_CAP_PCCARD;
@@ -140,7 +140,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		goto err_out_free_res;
 	}
 
-	for (i = 0; i<socket_count; i++) {
+	for (i = 0; i < socket_count; i++) {
 		sockets[i].socket.dev.parent = &dev->dev;
 		sockets[i].socket.ops = &i82092aa_operations;
 		sockets[i].socket.resource_ops = &pccard_nonstatic_ops;
@@ -155,7 +155,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 
 err_out_free_sockets:
 	if (i) {
-		for (i--;i>=0;i--) {
+		for (i--; i >= 0; i--) {
 			pcmcia_unregister_socket(&sockets[i].socket);
 		}
 	}
@@ -190,12 +190,12 @@ static unsigned char indirect_read(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg += socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	val = inb(port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	spin_unlock_irqrestore(&port_lock, flags);
 	return val;
 }
 
@@ -205,15 +205,15 @@ static unsigned short indirect_read16(int socket, unsigned short reg)
 	unsigned short int port;
 	unsigned short tmp;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg  = reg + socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	tmp = inb(port+1);
 	reg++;
-	outb(reg,port);
+	outb(reg, port);
 	tmp = tmp | (inb(port+1)<<8);
-	spin_unlock_irqrestore(&port_lock,flags);
+	spin_unlock_irqrestore(&port_lock, flags);
 	return tmp;
 }
 #endif
@@ -222,12 +222,12 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 {
 	unsigned short int port;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
-	outb(value,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(reg, port);
+	outb(value, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
@@ -235,15 +235,15 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	val = inb(port+1);
 	val |= mask;
-	outb(reg,port);
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(reg, port);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 
@@ -252,15 +252,15 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
-	outb(reg,port);
+	outb(reg, port);
 	val = inb(port+1);
 	val &= ~mask;
-	outb(reg,port);
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(reg, port);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 static void indirect_write16(int socket, unsigned short reg, unsigned short value)
@@ -268,20 +268,20 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned short int port;
 	unsigned char val;
 	unsigned long flags;
-	spin_lock_irqsave(&port_lock,flags);
+	spin_lock_irqsave(&port_lock, flags);
 	reg = reg + socket * 0x40;
 	port = sockets[socket].io_base;
 
-	outb(reg,port);
+	outb(reg, port);
 	val = value & 255;
-	outb(val,port+1);
+	outb(val, port+1);
 
 	reg++;
 
-	outb(reg,port);
+	outb(reg, port);
 	val = value>>8;
-	outb(val,port+1);
-	spin_unlock_irqrestore(&port_lock,flags);
+	outb(val, port+1);
+	spin_unlock_irqrestore(&port_lock, flags);
 }
 
 /* simple helper functions */
@@ -290,7 +290,7 @@ static int cycle_time = 120;
 
 static int to_cycles(int ns)
 {
-	if (cycle_time!=0)
+	if (cycle_time != 0)
 		return ns/cycle_time;
 	else
 		return 0;
@@ -305,27 +305,27 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 	int loopcount = 0;
 	int handled = 0;
 
-	unsigned int events, active=0;
+	unsigned int events, active = 0;
 
 /*	enter("i82092aa_interrupt");*/
 
 	while (1) {
 		loopcount++;
-		if (loopcount>20) {
+		if (loopcount > 20) {
 			pr_err("i82092aa: infinite eventloop in interrupt\n");
 			break;
 		}
 
 		active = 0;
 
-		for (i=0;i<socket_count;i++) {
+		for (i = 0; i < socket_count; i++) {
 			int csc;
-			if (sockets[i].card_state==0) /* Inactive socket, should not happen */
+			if (sockets[i].card_state == 0) /* Inactive socket, should not happen */
 				continue;
 
-			csc = indirect_read(i,I365_CSC); /* card status change register */
+			csc = indirect_read(i, I365_CSC); /* card status change register */
 
-			if (csc==0)  /* no events on this socket */
+			if (csc == 0)  /* no events on this socket */
 			   	continue;
 			handled = 1;
 			events = 0;
@@ -336,7 +336,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 					 "Card detected in socket %i!\n", i);
 			 }
 
-			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) {
+			if (indirect_read(i, I365_INTCTL) & I365_PC_IOCARD) {
 				/* For IO/CARDS, bit 0 means "read the card" */
 				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
 			} else {
@@ -352,7 +352,7 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 			active |= events;
 		}
 
-		if (active==0) /* no more events to handle */
+		if (active == 0) /* no more events to handle */
 			break;
 	}
 	return IRQ_RETVAL(handled);
@@ -368,14 +368,14 @@ static int card_present(int socketno)
 	unsigned int val;
 	enter("card_present");
 
-	if ((socketno<0) || (socketno >= MAX_SOCKETS))
+	if ((socketno < 0) || (socketno >= MAX_SOCKETS))
 		return 0;
 	if (sockets[socketno].io_base == 0)
 		return 0;
 
 
 	val = indirect_read(socketno, 1); /* Interface status register */
-	if ((val&12)==12) {
+	if ((val&12) == 12) {
 		leave("card_present 1");
 		return 1;
 	}
@@ -387,10 +387,10 @@ static int card_present(int socketno)
 static void set_bridge_state(int sock)
 {
 	enter("set_bridge_state");
-	indirect_write(sock, I365_GBLCTL,0x00);
-	indirect_write(sock, I365_GENCTL,0x00);
+	indirect_write(sock, I365_GBLCTL, 0x00);
+	indirect_write(sock, I365_GENCTL, 0x00);
 
-	indirect_setbit(sock, I365_INTCTL,0x08);
+	indirect_setbit(sock, I365_INTCTL, 0x08);
 	leave("set_bridge_state");
 }
 
@@ -427,7 +427,7 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 
 	enter("i82092aa_get_status");
 
-	status = indirect_read(sock,I365_STATUS); /* Interface Status Register */
+	status = indirect_read(sock, I365_STATUS); /* Interface Status Register */
 	*value = 0;
 
 	if ((status & I365_CS_DETECT) == I365_CS_DETECT) {
@@ -482,7 +482,7 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 	if (state->flags & SS_IOCARD)
 		reg = reg | I365_PC_IOCARD;
 
-	indirect_write(sock,I365_INTCTL,reg); /* IGENC, Interrupt and General Control Register */
+	indirect_write(sock, I365_INTCTL, reg); /* IGENC, Interrupt and General Control Register */
 
 	/* Power registers */
 
@@ -539,8 +539,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 			return -EINVAL;
 	}
 
-	if (reg != indirect_read(sock,I365_POWER)) /* only write if changed */
-		indirect_write(sock,I365_POWER,reg);
+	if (reg != indirect_read(sock, I365_POWER)) /* only write if changed */
+		indirect_write(sock, I365_POWER, reg);
 
 	/* Enable specific interrupt events */
 
@@ -563,8 +563,8 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 
 	/* now write the value and clear the (probably bogus) pending stuff by doing a dummy read*/
 
-	indirect_write(sock,I365_CSCINT,reg);
-	(void)indirect_read(sock,I365_CSC);
+	indirect_write(sock, I365_CSCINT, reg);
+	(void)indirect_read(sock, I365_CSC);
 
 	leave("i82092aa_set_socket");
 	return 0;
@@ -586,7 +586,7 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
 	}
-	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)){
+	if ((io->start > 0xffff) || (io->stop > 0xffff) || (io->stop < io->start)) {
 		leave("i82092aa_set_io_map with invalid io");
 		return -EINVAL;
 	}
@@ -601,19 +601,19 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
  */
 
 	/* write the new values */
-	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);
-	indirect_write16(sock,I365_IO(map)+I365_W_STOP,io->stop);
+	indirect_write16(sock, I365_IO(map)+I365_W_START, io->start);
+	indirect_write16(sock, I365_IO(map)+I365_W_STOP, io->stop);
 
-	ioctl = indirect_read(sock,I365_IOCTL) & ~I365_IOCTL_MASK(map);
+	ioctl = indirect_read(sock, I365_IOCTL) & ~I365_IOCTL_MASK(map);
 
 	if (io->flags & (MAP_16BIT|MAP_AUTOSZ))
 		ioctl |= I365_IOCTL_16BIT(map);
 
-	indirect_write(sock,I365_IOCTL,ioctl);
+	indirect_write(sock, I365_IOCTL, ioctl);
 
 	/* Turn the window back on if needed */
 	if (io->flags & MAP_ACTIVE)
-		indirect_setbit(sock,I365_ADDRWIN,I365_ENA_IO(map));
+		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
 	leave("i82092aa_set_io_map");
 	return 0;
@@ -638,8 +638,8 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	}
 
 
-	if ( (mem->card_start > 0x3ffffff) || (region.start > region.end) ||
-	     (mem->speed > 1000) ) {
+	if ((mem->card_start > 0x3ffffff) || (region.start > region.end) ||
+	     (mem->speed > 1000)) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
 		dev_err(&sock_info->dev->dev,
 			"invalid mem map for socket %i: %llx to %llx with a "
@@ -670,11 +670,11 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 		i |= I365_MEM_16BIT;
 	if (mem->flags & MAP_0WS)
 		i |= I365_MEM_0WS;
-	indirect_write16(sock,base+I365_W_START,i);
+	indirect_write16(sock, base+I365_W_START, i);
 
 	/* write the stop address */
 
-	i= (region.end >> 12) & 0x0fff;
+	i = (region.end >> 12) & 0x0fff;
 	switch (to_cycles(mem->speed)) {
 		case 0:
 			break;
@@ -689,7 +689,7 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 			break;
 	}
 
-	indirect_write16(sock,base+I365_W_STOP,i);
+	indirect_write16(sock, base+I365_W_STOP, i);
 
 	/* card start */
 
@@ -708,7 +708,7 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
  *			 sock);
  */
 	}
-	indirect_write16(sock,base+I365_W_OFF,i);
+	indirect_write16(sock, base+I365_W_OFF, i);
 
 	/* Enable the window if necessary */
 	if (mem->flags & MAP_ACTIVE)
@@ -727,7 +727,7 @@ static void i82092aa_module_exit(void)
 {
 	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_driver);
-	if (sockets[0].io_base>0)
+	if (sockets[0].io_base > 0)
 			 release_region(sockets[0].io_base, 2);
 	leave("i82092aa_module_exit");
 }
-- 
2.20.1

