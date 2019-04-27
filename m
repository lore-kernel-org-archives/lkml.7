Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77675C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582912087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfD0MyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:54:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfD0Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:33 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N79q8-1ghy553AGC-017Rst; Sat, 27 Apr 2019 14:53:03 +0200
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
Subject: [PATCH 35/41] drivers: tty: serial: 8250: add mapsize to platform data
Date:   Sat, 27 Apr 2019 14:52:16 +0200
Message-Id: <1556369542-13247-36-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:JcK0nmXUqvVZov6FpygbFCYx2SBIMbt8YBo1Pyu7lLXpjQoFRY+
 pUU91A2VFsC0opVj58fPkR0Q6FJXQi2dkc/wvSXJs1UuyFbz9fA4rXDWaSqNdJmI+Ni3NVN
 GCHT5mxv7iA219z7s0oyXnMLdcGAYrX/sQa9g9+0osWcxqkU8TBbfxVPdIH8z0lkkec4VUA
 Jy3EMpSULncwPlRSUSCNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HKE131FklXQ=:N+5TupvitkXMK24q5/jyxA
 sIX3ic5BD+uHPAGs20GJwkwPl9UDpk0TIanYdXumBoGIe0pn8xQHfMNAGWo6dzwFRYczrf7xW
 TxJABWtuVu+JiQ10VmrYJ6qbGD6m4TbE/uBc0upnH9JxQ1cVsfzzBmwiGXmmAaK657CfdpoPS
 Fz7U84teAYYbICi2O4GD/aLJ8uzK2AiOYExJtogutwoUfYQhEeqnt1MAK5B8+inbvVsZudb+l
 JJHjzlpoU/Oc+93FvVVMaymuIzy9f5R5gZGyofQ18Ch3DkihSAI67zUaYRbcl98qsSoKBF0qU
 0Bi3tP98ckrPEa8aT6/eEbWNDmQIaMq18HS/MVAYgP0Spig/t1UW2ix047NzAc3r2ovU57cD/
 m3113f332KKSzj3AKd4QtXe9A+c95IFcsbX/8ZcEtEUh4OjJicZ9FooqDctilf0RHzaAa2R0C
 rBL1UlQkiaGPBiXr/zXerWVeQj+YNsmUc6K/CvV8fuooCj8sZm9wrLZ8jVV/8DBx0EmiKK0FQ
 FMksN9EPcLIzrmxsrW7WAaj8ObKHty46EJiN+qpvZ7NIRTVKtyKeC7eYev77pxyv6ynBQwIto
 XvolrpgZ5uald3Dm9wAVwKn9K+v7AhEHQZv/NkEVcxJbA6C5VQ4xHu1nfwLeN8MtF/mnGnkCL
 7eovd4m1Pa0fyY2AFdvo5Xvee3L7sL7797X+E77dYhJ60wioVIWdRHlMcJMcL86pG4RtHQe3Y
 1TtyyEi0bqAfCKemGdUTrRo5E1LDoLRshCvoXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a mapsize field for the 8250 port platform data struct,
so we can now set the resource size (eg. *1) and don't need
funny runtime detections like serial8250_port_size() anymore.

For now, serial8250_port_size() is called everytime we need
the io resource size. That function checks which chip we
actually have and returns the appropriate size. This approach
is a bit clumpsy and not entirely easy to understand, and
it's a violation of layers :p

Obviously, that information cannot change after the driver init,
so we can safely do that probing once on driver init and just
use the stored value later.

*1) arch/mips/alchemy/common/platform.c

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 include/linux/serial_8250.h         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221..71a398b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -814,6 +814,7 @@ static int serial8250_probe(struct platform_device *dev)
 		uart.port.iotype	= p->iotype;
 		uart.port.flags		= p->flags;
 		uart.port.mapbase	= p->mapbase;
+		uart.port.mapsize	= p->mapsize;
 		uart.port.hub6		= p->hub6;
 		uart.port.private_data	= p->private_data;
 		uart.port.type		= p->type;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5a655ba..8b8183a 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -22,6 +22,7 @@ struct plat_serial8250_port {
 	unsigned long	iobase;		/* io base address */
 	void __iomem	*membase;	/* ioremap cookie or NULL */
 	resource_size_t	mapbase;	/* resource base */
+	resource_size_t	mapsize;	/* resource size */
 	unsigned int	irq;		/* interrupt number */
 	unsigned long	irqflags;	/* request_irq flags */
 	unsigned int	uartclk;	/* UART clock rate */
-- 
1.9.1

