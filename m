Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C6C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565DF212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfD0Mzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfD0MxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:13 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQ5nE-1h75AP44I4-00M2Ff; Sat, 27 Apr 2019 14:52:50 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 19/41] drivers: tty: serial: apbuart: fix code formatting
Date:   Sat, 27 Apr 2019 14:52:00 +0200
Message-Id: <1556369542-13247-20-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:pjIAjAgne4QqCMX+FIhXRp8twk2qiMY/VorT1FzzAauzfUv0f0K
 SouwmsHqH8JyEbDuRqNFwbEIDs+EyWcnB64N7nh/mWQM9zuPT5456futLRKhnzo2DzzmTAO
 S02Mck6t77pqC6132Z833rEpWkrhCHTZd9aBV6r93jE4Lyyveee4Vx4PENyVvPDGn5fzADC
 T1cnBnEc7a4HKVi45SoRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hEOSQVkrBtY=:E2i1fxkjmB++cF1pgysgSC
 8hsAb0Aq860XW0owLqBwUm2y5DJXO+V/Is8mFh4c9ru3QfeD9ojJIKExeE/gQMx2UOQEJgGRb
 nvrMAXOkXd1qYP1gKihMwQy9DHsjWbR3wxj+hp709JVyhiYnLw9UAD3t+5PPNn6ETAr98RQP2
 gHqDm/XUrKMU6kMIkWzlIgqfxdvTEA7d7CYJRA9+zsUFW6w+/kxNsRVEd2YH5fKzEWDZTB6mG
 AA1v18dy6/1w/Ta8+c1Z5r88c2mCOFG/kzIKZoFOpF02Re1cfPJiHtMPLpESpqBGkPJuT0pan
 wj5zbHmx+ec2NOcEAFhVUHZLEz20D89Udi/Cyt1T8qV0CmOeHhNQKA82G64fYOI5+TUIzx7QC
 obIBCK9wl1bRvMCTV4E/U6sBvRSiFWt5BcFHib/PhsHSUGo1Qoyf0VIUK6oReuSkCDZLub+8G
 Ob+eIhsXiwLKrxHAPOJ3mKdJEWu46k9EuJVL6xT+/FJe8XJTXXYFVmn8//sRTXHE9xnvp8m1O
 1hpfUx4oFrpuxlBsYSu4W9shD60EHF2Zw/7FCtDHNOWT3igcd4Kn+PwMo93U88O8Llhwj4qEi
 0CfcgMV9NBLuRd7LB5vp6/0Y+IfZe9HXOS6bEacBXOvat8PAAolbzxQuW8puvfRpBKG0XLB8X
 ofUclwTQPMphcmiPqlFXZf2nDhQxa57xuFpm3v4alrdRoOJx+GnGdJbV+E65VwyS+7GmnAy5B
 A0stBq2sqAbOn5qtmttutC8+4NSushVi0gD3aA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

    WARNING: line over 80 characters
    #9: FILE: drivers/tty/serial/apbuart.c:9:
    + *  Copyright (C) 2006 Daniel Hellstrom <daniel@gaisler.com>, Aeroflex Gaisler AB

    WARNING: line over 80 characters
    #11: FILE: drivers/tty/serial/apbuart.c:11:
    + *  Copyright (C) 2009 Kristoffer Glembo <kristoffer@gaisler.com>, Aeroflex Gaisler AB

    WARNING: line over 80 characters
    #16: FILE: drivers/tty/serial/apbuart.c:16:
    +#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)

    WARNING: labels should not be indented
    #122: FILE: drivers/tty/serial/apbuart.c:122:
    +	      ignore_char:

    WARNING: Missing a blank line after declarations
    #186: FILE: drivers/tty/serial/apbuart.c:186:
    +	unsigned int status = UART_GET_STATUS(port);
    +	return status & UART_STATUS_THE ? TIOCSER_TEMT : 0;

    WARNING: Missing a blank line after declarations
    #322: FILE: drivers/tty/serial/apbuart.c:322:
    +	int ret = 0;
    +	if (ser->type != PORT_UNKNOWN && ser->type != PORT_APBUART)

    WARNING: Missing a blank line after declarations
    #427: FILE: drivers/tty/serial/apbuart.c:427:
    +	unsigned int status;
    +	do {

    WARNING: Missing a blank line after declarations
    #463: FILE: drivers/tty/serial/apbuart.c:463:
    +		unsigned int quot, status;
    +		status = UART_GET_STATUS(port);

    WARNING: line over 80 characters
    #627: FILE: drivers/tty/serial/apbuart.c:627:
    +		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));

    WARNING: line over 80 characters
    #634: FILE: drivers/tty/serial/apbuart.c:634:
    +		port->fifosize = apbuart_scan_fifo_size((struct uart_port *) port, line);

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/apbuart.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 89e19b6..515a562 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -6,12 +6,15 @@
  *
  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
  *  Copyright (C) 2003 Konrad Eisele <eiselekd@web.de>
- *  Copyright (C) 2006 Daniel Hellstrom <daniel@gaisler.com>, Aeroflex Gaisler AB
+ *  Copyright (C) 2006 Daniel Hellstrom <daniel@gaisler.com>,
+ *                     Aeroflex Gaisler AB
  *  Copyright (C) 2008 Gilead Kutnick <kutnickg@zin-tech.com>
- *  Copyright (C) 2009 Kristoffer Glembo <kristoffer@gaisler.com>, Aeroflex Gaisler AB
+ *  Copyright (C) 2009 Kristoffer Glembo <kristoffer@gaisler.com>,
+ *                     Aeroflex Gaisler AB
  */
 
-#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE) \
+	&& defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
 
@@ -116,8 +119,7 @@ static void apbuart_rx_chars(struct uart_port *port)
 
 		uart_insert_char(port, rsr, UART_STATUS_OE, ch, flag);
 
-
-	      ignore_char:
+ignore_char:
 		status = UART_GET_STATUS(port);
 	}
 
@@ -181,6 +183,7 @@ static irqreturn_t apbuart_int(int irq, void *dev_id)
 static unsigned int apbuart_tx_empty(struct uart_port *port)
 {
 	unsigned int status = UART_GET_STATUS(port);
+
 	return status & UART_STATUS_THE ? TIOCSER_TEMT : 0;
 }
 
@@ -317,6 +320,7 @@ static int apbuart_verify_port(struct uart_port *port,
 			       struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_APBUART)
 		ret = -EINVAL;
 	if (ser->irq < 0 || ser->irq >= NR_IRQS)
@@ -422,6 +426,7 @@ static void apbuart_flush_fifo(struct uart_port *port)
 static void apbuart_console_putchar(struct uart_port *port, int ch)
 {
 	unsigned int status;
+
 	do {
 		status = UART_GET_STATUS(port);
 	} while (!UART_TX_READY(status));
@@ -458,6 +463,7 @@ static void apbuart_console_putchar(struct uart_port *port, int ch)
 	if (UART_GET_CTRL(port) & (UART_CTRL_RE | UART_CTRL_TE)) {
 
 		unsigned int quot, status;
+
 		status = UART_GET_STATUS(port);
 
 		*parity = 'n';
@@ -622,14 +628,16 @@ static int __init grlib_apbuart_configure(void)
 		port = &grlib_apbuart_ports[line];
 
 		port->mapbase = addr;
-		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
+		port->membase = ioremap(addr,
+			sizeof(struct grlib_apbuart_regs_map));
 		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
 		port->flags = UPF_BOOT_AUTOCONF;
 		port->line = line;
 		port->uartclk = *freq_hz;
-		port->fifosize = apbuart_scan_fifo_size((struct uart_port *) port, line);
+		port->fifosize = apbuart_scan_fifo_size(
+			(struct uart_port *) port, line);
 		line++;
 
 		/* We support maximum UART_NR uarts ... */
-- 
1.9.1

