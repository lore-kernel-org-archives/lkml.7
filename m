Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B91C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F98206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLHQPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 11:15:40 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49516 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfLHQPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 11:15:39 -0500
Received: from faui04f.informatik.uni-erlangen.de (faui04f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:136])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id B499A24171A;
        Sun,  8 Dec 2019 17:10:14 +0100 (CET)
Received: by faui04f.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id A9374C20BC6; Sun,  8 Dec 2019 17:10:14 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH 02/12] PCMCIA: remove trailing whitespaces
Date:   Sun,  8 Dec 2019 17:09:37 +0100
Message-Id: <20191208160947.20694-3-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191208160947.20694-2-simon.geis@fau.de>
References: <20191208160947.20694-2-simon.geis@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The identation for the comment block is corrected.

Co-developed-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Lukas Panzer <lukas.panzer@fau.de>
Signed-off-by: Simon Geis <simon.geis@fau.de>

---
 drivers/pcmcia/i82092.c | 233 ++++++++++++++++++++--------------------
 1 file changed, 115 insertions(+), 118 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index ba33293b1a34..4d189af52afb 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* 
+/*
  * Driver for Intel I82092AA PCI-PCMCIA bridge.
  *
  * (C) 2001 Red Hat, Inc.
@@ -53,31 +53,33 @@ static struct pccard_operations i82092aa_operations = {
 
 struct socket_info {
 	int	number;
-	int	card_state; 	/*  0 = no socket,
-				    1 = empty socket, 
-				    2 = card but not initialized,
-				    3 = operational card */
+	int	card_state;
+		/* 0 = no socket,
+		 * 1 = empty socket,
+		 * 2 = card but not initialized,
+		 * 3 = operational card
+		 */
 	unsigned int io_base; 	/* base io address of the socket */
-	
+
 	struct pcmcia_socket socket;
 	struct pci_dev *dev;	/* The PCI device for the socket */
 };
 
 #define MAX_SOCKETS 4
 static struct socket_info sockets[MAX_SOCKETS];
-static int socket_count;  /* shortcut */                                  	                                	
+static int socket_count;	/* shortcut */
 
 
 static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i, ret;
-	
+
 	enter("i82092aa_pci_probe");
-	
+
 	if ((ret = pci_enable_device(dev)))
 		return ret;
-		
+
 	pci_read_config_byte(dev, 0x40, &configbyte);  /* PCI Configuration Control */
 	switch(configbyte&6) {
 		case 0:
@@ -90,7 +92,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		case 6:
 			socket_count = 4;
 			break;
-			
+
 		default:
 			dev_err(&dev->dev,
 				"i82092aa: Oops, you did something we didn't think of.\n");
@@ -104,7 +106,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		ret = -EBUSY;
 		goto err_out_disable;
 	}
-	
+
 	for (i = 0;i<socket_count;i++) {
 		sockets[i].card_state = 1; /* 1 = present but empty */
 		sockets[i].io_base = pci_resource_start(dev, 0);
@@ -116,7 +118,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 		sockets[i].socket.owner = THIS_MODULE;
 
 		sockets[i].number = i;
-		
+
 		if (card_present(i)) {
 			sockets[i].card_state = 3;
 			dev_dbg(&dev->dev, "i82092aa: slot %i is occupied\n", i);
@@ -124,7 +126,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 			dev_dbg(&dev->dev, "i82092aa: slot %i is vacant\n", i);
 		}
 	}
-		
+
 	/* Now, specifiy that all interrupts are to be done as PCI interrupts */
 	configbyte = 0xFF; /* bitmask, one bit per event, 1 = PCI interrupt, 0 = ISA interrupt */
 	pci_write_config_byte(dev, 0x50, configbyte); /* PCI Interrupt Routing Register */
@@ -162,7 +164,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *i
 	release_region(pci_resource_start(dev, 0), 2);
 err_out_disable:
 	pci_disable_device(dev);
-	return ret;			
+	return ret;
 }
 
 static void i82092aa_pci_remove(struct pci_dev *dev)
@@ -170,7 +172,7 @@ static void i82092aa_pci_remove(struct pci_dev *dev)
 	int i;
 
 	enter("i82092aa_pci_remove");
-	
+
 	free_irq(dev->irq, i82092aa_interrupt);
 
 	for (i = 0; i < socket_count; i++)
@@ -222,7 +224,7 @@ static void indirect_write(int socket, unsigned short reg, unsigned char value)
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
+	port = sockets[socket].io_base;
 	outb(reg,port);
 	outb(value,port+1);
 	spin_unlock_irqrestore(&port_lock,flags);
@@ -235,7 +237,7 @@ static void indirect_setbit(int socket, unsigned short reg, unsigned char mask)
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
+	port = sockets[socket].io_base;
 	outb(reg,port);
 	val = inb(port+1);
 	val |= mask;
@@ -252,7 +254,7 @@ static void indirect_resetbit(int socket, unsigned short reg, unsigned char mask
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
+	port = sockets[socket].io_base;
 	outb(reg,port);
 	val = inb(port+1);
 	val &= ~mask;
@@ -268,14 +270,14 @@ static void indirect_write16(int socket, unsigned short reg, unsigned short valu
 	unsigned long flags;
 	spin_lock_irqsave(&port_lock,flags);
 	reg = reg + socket * 0x40;
-	port = sockets[socket].io_base; 
-	
+	port = sockets[socket].io_base;
+
 	outb(reg,port);
 	val = value & 255;
 	outb(val,port+1);
-	
+
 	reg++;
-	
+
 	outb(reg,port);
 	val = value>>8;
 	outb(val,port+1);
@@ -293,7 +295,7 @@ static int to_cycles(int ns)
 	else
 		return 0;
 }
-    
+
 
 /* Interrupt handler functionality */
 
@@ -304,55 +306,54 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 	int handled = 0;
 
 	unsigned int events, active=0;
-	
+
 /*	enter("i82092aa_interrupt");*/
-	
+
 	while (1) {
 		loopcount++;
 		if (loopcount>20) {
 			pr_err("i82092aa: infinite eventloop in interrupt\n");
 			break;
 		}
-		
+
 		active = 0;
-		
+
 		for (i=0;i<socket_count;i++) {
 			int csc;
 			if (sockets[i].card_state==0) /* Inactive socket, should not happen */
 				continue;
-			
+
 			csc = indirect_read(i,I365_CSC); /* card status change register */
-			
+
 			if (csc==0)  /* no events on this socket */
 			   	continue;
 			handled = 1;
 			events = 0;
-			 
+
 			if (csc & I365_CSC_DETECT) {
 				events |= SS_DETECT;
 				dev_info(&sockets[i].dev->dev,
 					 "Card detected in socket %i!\n", i);
 			 }
-			
-			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) { 
+
+			if (indirect_read(i,I365_INTCTL) & I365_PC_IOCARD) {
 				/* For IO/CARDS, bit 0 means "read the card" */
-				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0; 
+				events |= (csc & I365_CSC_STSCHG) ? SS_STSCHG : 0;
 			} else {
 				/* Check for battery/ready events */
 				events |= (csc & I365_CSC_BVD1) ? SS_BATDEAD : 0;
 				events |= (csc & I365_CSC_BVD2) ? SS_BATWARN : 0;
 				events |= (csc & I365_CSC_READY) ? SS_READY : 0;
 			}
-			
+
 			if (events) {
 				pcmcia_parse_events(&sockets[i].socket, events);
 			}
 			active |= events;
 		}
-				
+
 		if (active==0) /* no more events to handle */
-			break;				
-		
+			break;
 	}
 	return IRQ_RETVAL(handled);
 /*	leave("i82092aa_interrupt");*/
@@ -363,22 +364,22 @@ static irqreturn_t i82092aa_interrupt(int irq, void *dev)
 /* socket functions */
 
 static int card_present(int socketno)
-{	
+{
 	unsigned int val;
 	enter("card_present");
-	
+
 	if ((socketno<0) || (socketno >= MAX_SOCKETS))
 		return 0;
 	if (sockets[socketno].io_base == 0)
 		return 0;
 
-		
+
 	val = indirect_read(socketno, 1); /* Interface status register */
 	if ((val&12)==12) {
 		leave("card_present 1");
 		return 1;
 	}
-		
+
 	leave("card_present 0");
 	return 0;
 }
@@ -388,25 +389,21 @@ static void set_bridge_state(int sock)
 	enter("set_bridge_state");
 	indirect_write(sock, I365_GBLCTL,0x00);
 	indirect_write(sock, I365_GENCTL,0x00);
-	
+
 	indirect_setbit(sock, I365_INTCTL,0x08);
 	leave("set_bridge_state");
 }
 
 
-
-
-
-      
 static int i82092aa_init(struct pcmcia_socket *sock)
 {
 	int i;
 	struct resource res = { .start = 0, .end = 0x0fff };
         pccard_io_map io = { 0, 0, 0, 0, 1 };
 	pccard_mem_map mem = { .res = &res, };
-        
+
         enter("i82092aa_init");
-                        
+
         for (i = 0; i < 2; i++) {
         	io.map = i;
                 i82092aa_set_io_map(sock, &io);
@@ -415,27 +412,28 @@ static int i82092aa_init(struct pcmcia_socket *sock)
         	mem.map = i;
                 i82092aa_set_mem_map(sock, &mem);
 	}
-	
+
 	leave("i82092aa_init");
 	return 0;
 }
-                                                                                                                                                                                                                                              
+
+
 static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned int status;
-	
+
 	enter("i82092aa_get_status");
-	
+
 	status = indirect_read(sock,I365_STATUS); /* Interface Status Register */
 	*value = 0;
-	
+
 	if ((status & I365_CS_DETECT) == I365_CS_DETECT) {
 		*value |= SS_DETECT;
 	}
-		
+
 	/* IO cards have a different meaning of bits 0,1 */
 	/* Also notice the inverse-logic on the bits */
 	if (indirect_read(sock, I365_INTCTL) & I365_PC_IOCARD)	{
@@ -448,13 +446,13 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 		if (!(status & I365_CS_BVD2))
 			*value |= SS_BATWARN;
 	}
-	 
+
 	if (status & I365_CS_WRPROT)
 		(*value) |= SS_WRPROT;	/* card is write protected */
-	 
+
 	if (status & I365_CS_READY)
 		(*value) |= SS_READY;    /* card is not busy */
-	 	
+
 	if (status & I365_CS_POWERON)
 		(*value) |= SS_POWERON;  /* power is applied to the card */
 
@@ -463,33 +461,33 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 }
 
 
-static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state) 
+static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *state)
 {
 	struct socket_info *sock_info = container_of(socket, struct socket_info,
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned char reg;
-	
+
 	enter("i82092aa_set_socket");
-	
+
 	/* First, set the global controller options */
-	
+
 	set_bridge_state(sock);
-	
+
 	/* Values for the IGENC register */
-	
+
 	reg = 0;
 	if (!(state->flags & SS_RESET)) 	/* The reset bit has "inverse" logic */
-		reg = reg | I365_PC_RESET;  
-	if (state->flags & SS_IOCARD) 
+		reg = reg | I365_PC_RESET;
+	if (state->flags & SS_IOCARD)
 		reg = reg | I365_PC_IOCARD;
-		
+
 	indirect_write(sock,I365_INTCTL,reg); /* IGENC, Interrupt and General Control Register */
-	
+
 	/* Power registers */
-	
+
 	reg = I365_PWR_NORESET; /* default: disable resetdrv on resume */
-	
+
 	if (state->flags & SS_PWR_AUTO) {
 		dev_info(&sock_info->dev->dev, "Auto power\n");
 		reg |= I365_PWR_AUTO;	/* automatic power mngmnt */
@@ -498,11 +496,11 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 		dev_info(&sock_info->dev->dev, "Power Enabled\n");
 		reg |= I365_PWR_OUT;	/* enable power */
 	}
-	
+
 	switch (state->Vcc) {
-		case 0:	
+		case 0:
 			break;
-		case 50: 
+		case 50:
 			dev_info(&sock_info->dev->dev,
 				 "setting voltage to Vcc to 5V on socket %i\n",
 				 sock);
@@ -515,21 +513,20 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
-	
-	
+
 	switch (state->Vpp) {
-		case 0:	
+		case 0:
 			dev_info(&sock_info->dev->dev,
 				 "not setting Vpp on socket %i\n",
 				 sock);
 			break;
-		case 50: 
+		case 50:
 			dev_info(&sock_info->dev->dev,
 				 "setting Vpp to 5.0 for socket %i\n",
 				 sock);
 			reg |= I365_VPP1_5V | I365_VPP2_5V;
 			break;
-		case 120: 
+		case 120:
 			dev_info(&sock_info->dev->dev,
 				 "setting Vpp to 12.0\n");
 			reg |= I365_VPP1_12V | I365_VPP2_12V;
@@ -541,12 +538,12 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 			leave("i82092aa_set_socket");
 			return -EINVAL;
 	}
-	
+
 	if (reg != indirect_read(sock,I365_POWER)) /* only write if changed */
 		indirect_write(sock,I365_POWER,reg);
-		
+
 	/* Enable specific interrupt events */
-	
+
 	reg = 0x00;
 	if (state->csc_mask & SS_DETECT) {
 		reg |= I365_CSC_DETECT;
@@ -555,17 +552,17 @@ static int i82092aa_set_socket(struct pcmcia_socket *socket, socket_state_t *sta
 		if (state->csc_mask & SS_STSCHG)
 			reg |= I365_CSC_STSCHG;
 	} else {
-		if (state->csc_mask & SS_BATDEAD) 
+		if (state->csc_mask & SS_BATDEAD)
 			reg |= I365_CSC_BVD1;
-		if (state->csc_mask & SS_BATWARN) 
+		if (state->csc_mask & SS_BATWARN)
 			reg |= I365_CSC_BVD2;
-		if (state->csc_mask & SS_READY) 
-			reg |= I365_CSC_READY; 
-		                        
+		if (state->csc_mask & SS_READY)
+			reg |= I365_CSC_READY;
+
 	}
-	
+
 	/* now write the value and clear the (probably bogus) pending stuff by doing a dummy read*/
-	
+
 	indirect_write(sock,I365_CSCINT,reg);
 	(void)indirect_read(sock,I365_CSC);
 
@@ -579,12 +576,12 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 						     socket);
 	unsigned int sock = sock_info->number;
 	unsigned char map, ioctl;
-	
+
 	enter("i82092aa_set_io_map");
-	
+
 	map = io->map;
-	
-	/* Check error conditions */	
+
+	/* Check error conditions */
 	if (map > 1) {
 		leave("i82092aa_set_io_map with invalid map");
 		return -EINVAL;
@@ -594,7 +591,7 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
 		return -EINVAL;
 	}
 
-	/* Turn off the window before changing anything */ 
+	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_IO(map))
 		indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_IO(map));
 
@@ -602,23 +599,23 @@ static int i82092aa_set_io_map(struct pcmcia_socket *socket, struct pccard_io_ma
  *		 "set_io_map: Setting range to %x - %x\n",
  *		 io->start, io->stop);
  */
-	
+
 	/* write the new values */
-	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);            	
-	indirect_write16(sock,I365_IO(map)+I365_W_STOP,io->stop);            	
-	            	
+	indirect_write16(sock,I365_IO(map)+I365_W_START,io->start);
+	indirect_write16(sock,I365_IO(map)+I365_W_STOP,io->stop);
+
 	ioctl = indirect_read(sock,I365_IOCTL) & ~I365_IOCTL_MASK(map);
-	
+
 	if (io->flags & (MAP_16BIT|MAP_AUTOSZ))
 		ioctl |= I365_IOCTL_16BIT(map);
-		
+
 	indirect_write(sock,I365_IOCTL,ioctl);
-	
+
 	/* Turn the window back on if needed */
 	if (io->flags & MAP_ACTIVE)
 		indirect_setbit(sock,I365_ADDRWIN,I365_ENA_IO(map));
-			
-	leave("i82092aa_set_io_map");	
+
+	leave("i82092aa_set_io_map");
 	return 0;
 }
 
@@ -629,18 +626,18 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	struct pci_bus_region region;
 	unsigned short base, i;
 	unsigned char map;
-	
+
 	enter("i82092aa_set_mem_map");
 
 	pcibios_resource_to_bus(sock_info->dev->bus, &region, mem->res);
-	
+
 	map = mem->map;
 	if (map > 4) {
 		leave("i82092aa_set_mem_map: invalid map");
 		return -EINVAL;
 	}
-	
-	
+
+
 	if ( (mem->card_start > 0x3ffffff) || (region.start > region.end) ||
 	     (mem->speed > 1000) ) {
 		leave("i82092aa_set_mem_map: invalid address / speed");
@@ -653,12 +650,12 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 			mem->card_start);
 		return -EINVAL;
 	}
-	
+
 	/* Turn off the window before changing anything */
 	if (indirect_read(sock, I365_ADDRWIN) & I365_ENA_MEM(map))
 	              indirect_resetbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
-	                 
-	                 
+
+
 /*	dev_info(&sock_info->dev->dev,
  *		 "set_mem_map: Setting map %i range to %x - %x on socket %i, "
  *		 "speed is %i, active = %i\n", map,
@@ -669,14 +666,14 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 	/* write the start address */
 	base = I365_MEM(map);
 	i = (region.start >> 12) & 0x0fff;
-	if (mem->flags & MAP_16BIT) 
+	if (mem->flags & MAP_16BIT)
 		i |= I365_MEM_16BIT;
 	if (mem->flags & MAP_0WS)
-		i |= I365_MEM_0WS;	
+		i |= I365_MEM_0WS;
 	indirect_write16(sock,base+I365_W_START,i);
-		               
+
 	/* write the stop address */
-	
+
 	i= (region.end >> 12) & 0x0fff;
 	switch (to_cycles(mem->speed)) {
 		case 0:
@@ -691,11 +688,11 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
 			i |= I365_MEM_WS1 | I365_MEM_WS0;
 			break;
 	}
-	
+
 	indirect_write16(sock,base+I365_W_STOP,i);
-	
+
 	/* card start */
-	
+
 	i = ((mem->card_start - region.start) >> 12) & 0x3fff;
 	if (mem->flags & MAP_WRPROT)
 		i |= I365_MEM_WRPROT;
@@ -712,11 +709,11 @@ static int i82092aa_set_mem_map(struct pcmcia_socket *socket, struct pccard_mem_
  */
 	}
 	indirect_write16(sock,base+I365_W_OFF,i);
-	
+
 	/* Enable the window if necessary */
 	if (mem->flags & MAP_ACTIVE)
 		indirect_setbit(sock, I365_ADDRWIN, I365_ENA_MEM(map));
-	            
+
 	leave("i82092aa_set_mem_map");
 	return 0;
 }
-- 
2.20.1

