Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940792075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCLO6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:22 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36227 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:16 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MI4gb-1hF3Vf2OON-00F8u7; Tue, 12 Mar 2019 15:58:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drivers: tty: serial: vt8500: use memres
Date:   Tue, 12 Mar 2019 15:57:38 +0100
Message-Id: <1552402660-31730-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AgJO3cLcCylRAK+ZkkUPH8ZzUYqtkBvDjuIylVSweQEavq0/gER
 hM7F/mldy0krgUUTNMmpw7EOzl7iws1gVwzwWNFHJEC15k4xBIJV3zUeRdjbhUGUluIW7Jp
 Ymx7KvileiDAsmR2GmaX/VmHorcxkxVmw4mDBDUDcTTMFbMiLgIsca3A0ZzsyOqA6wEpLbX
 +tOOc3SChDLeXlwhr2B1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x2F99PDas8A=:/7ezgjleH+kNbOCm03elRX
 do6DtxXBSYz2yHdeFOfYNcJHm3k58dwe8ehw9rML33bc2/zuynnDyP9A9ZCBSIAME0XhDjg9P
 2+esKVJz/ldNeeXzpbTdEOT2N2EBYj8zxT9UVlfjHS6WlnmR3Xj4TVwbs47v62oNIpwuFy0va
 wDDc0+RrFzbkUo/wVRHBUiqlSn8xcqgJcNgZQhdyUYiDe6rRJJHRXmJgDROwzLdTWbfFqEIEu
 hlULjanBwfwelQFpO0Cb7r/6tGLJNyl5U74MBd2sQ4nfWBfDXPhH6znOwnBeL2QU2YAT4N5DA
 oahSukcxuOxMK+TD85e4hovv0scfk9dJqqlyh4gl/doVPamgOUDQHhsfeztiZQhKTW9PJGYl3
 AIfo+8fwK1Qzsaxt5aploTuVfm6zsJBCjdptEehVFxTky/PKv/o0Dc1Ig7kifZlEWfWpWKmZb
 QzIKqeRhRQYAT14cKs/XK1Kd/C5ONgLLFwpn4ofmz1Ch2opgIrQn5CHyTYfITKqlVM+IsJsu1
 VB51XP2VvI1nIW4CTw13Gn2qiceDKD8Q+YGH2A5YQ41gK08VwBQSWPPXaWdJj4ediGVPqnM1r
 1HcKsJotx4SH9Qis0ZiUkwYkXZ35JWQycxv8xLdKQBNEWflrV+j0fisEdXBfW/P4c9e9aVRZ4
 s50/DkU/8njTRyGeC6DtaBG7eN0IIGKtP6cP+pPZQBvCmpjj6VbbGrpalQ/HZ7PkhLaih2lgC
 hQJDfjUAtp1sZI8fCH1l/6VEtaVUJ4PR99uTEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/tty/serial/vt8500_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 3d58e9b..331a9dd 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -696,13 +696,13 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 				      );
 	vt8500_port->uart.type = PORT_VT8500;
 	vt8500_port->uart.iotype = UPIO_MEM;
-	vt8500_port->uart.mapbase = mmres->start;
 	vt8500_port->uart.irq = irqres->start;
 	vt8500_port->uart.fifosize = 16;
 	vt8500_port->uart.ops = &vt8500_uart_pops;
 	vt8500_port->uart.line = port;
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
+	uart_memres_set(&vt8500_port->uart, *mmres);
 
 	/* Serial core uses the magic "16" everywhere - adjust for it */
 	vt8500_port->uart.uartclk = 16 * clk_get_rate(vt8500_port->clk) /
-- 
1.9.1

