Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C67C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4D62087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfD0My5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:54:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfD0MxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:25 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYkI-1gvnxz13qI-00m5Hh; Sat, 27 Apr 2019 14:53:01 +0200
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
Subject: [PATCH 32/41] drivers: tty: serial: 21285: define's for address/size, use mapsize field
Date:   Sat, 27 Apr 2019 14:52:13 +0200
Message-Id: <1556369542-13247-33-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:iEBl2J6aAGLLUc9gogjDel0fwK0zVBbCxPMJri/kbrSvb4JuRHU
 dMsu93FBbFwYR3dVsvSh1GJRRBnAct7RY5hnMruBRe4fpX6nxjKZ9a+FpdnPqRrRM6zajm/
 Zq6YvL7nAO4JNPTwsDDpcQwnA8FjfR6ICxhwBH3BRm3TCq2eoup3NR3iCqD3FNfZx2YoV/8
 V7MKmxrrBIOBo3I5f/tZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93H1R8MWbBw=:L0iEwc82GdE63pmHfe42UJ
 uQxcquJ3aJJ6XagNGb5FGjO5+Gqe68JZ8HjPmYBjEOz5cxI4FLV/EJb7ZZ4Y1tXzXf5DmiQSC
 jGjsnJLejS63nxXDdr7G7i1Zj87ckczGHw41+SX07w+g0h/OAWEt0Qrpak9E3FGVcyCmOJUga
 hbJqfS4JWsxbQKPw0kI+6ndJ373LfddM/MvpO5ERt4PzWcL0nspeNGet1o9gjCpUiD9nD01IT
 LngnK8dwnJOnWh/L/7tvgAI9bkBVglAvI4stcaTG+KJ02WFNPNQFlNn3tX8C/qqQ5ZoVtoH0o
 YCOtR2V+YpRlbPmvzp/NjwosNMtNg2fr2A4+jp8LVxwHEKx6Mq9rQlCZn48cIitdMCx3u2/8Z
 M7TdoDS9GdEIVYbxytMx9G63q7f34b7N4ovgVOyFqvk3EDR2ExnMQfI79d7+TthEa+OBHcMcP
 hc4ClgExLQpo/LSINaPEy9n00HY/I4d9QypfPIAHCYEnzCXADrc2t7CkhNepxTht+kgBJy1aS
 k+FsfSyCi2AqYiHiKoYXXuhlarg3YviDJeu51x/XK4YxQPvIdXBJG5P2i6KsHaq6UluVDG+QC
 qwQkfxB5GTCJhn4IkC2Um1VQxHSOGPJji3pBLjiV5pKZyGr1odsWyJb3bcwdxoTWDC1A0LmcQ
 VW3zq4vScC/GbUtZRrJdUVGJaF/4tuvZLntHWr9wcbtii+rDlmL0H4rk+Paj3NeMT503X+vXM
 zHbXOUjI7IZVWOStZx9mJyCXuG7NHF8tiIcRnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding raw numbers, add define's for the mmio address/size.
Also fill the mapsize field and use it on mem request/release calls, for
more consistency and allowing generic helpers to be used later.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/21285.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf..90684cd 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -27,6 +27,9 @@
 #define SERIAL_21285_MAJOR	204
 #define SERIAL_21285_MINOR	4
 
+#define SERIAL_21285_ADDRESS	0x42000160
+#define SERIAL_21285_SIZE	32
+
 #define RXSTAT_DUMMY_READ	0x80000000
 #define RXSTAT_FRAME		(1 << 0)
 #define RXSTAT_PARITY		(1 << 1)
@@ -305,12 +308,14 @@ static const char *serial21285_type(struct uart_port *port)
 
 static void serial21285_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, 32);
+	release_mem_region(port->mapbase, port->mapsize);
 }
 
 static int serial21285_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, 32, serial21285_name)
+	return request_mem_region(port->mapbase,
+				  port->mapsize,
+				  serial21285_name)
 			 != NULL ? 0 : -EBUSY;
 }
 
@@ -354,7 +359,8 @@ static int serial21285_verify_port(struct uart_port *port, struct serial_struct
 };
 
 static struct uart_port serial21285_port = {
-	.mapbase	= 0x42000160,
+	.mapbase	= SERIAL_21285_BASE,
+	.mapsize	= SERIAL_21285_SIZE,
 	.iotype		= UPIO_MEM,
 	.irq		= 0,
 	.fifosize	= 16,
-- 
1.9.1

