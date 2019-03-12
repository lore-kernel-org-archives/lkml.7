Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A527DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9A12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCLO7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:59:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCLO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:46 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ml72g-1geJeO3tj2-00lRZs; Tue, 12 Mar 2019 15:58:01 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drivers: tty: serial: xilinx_uartps: use helpers
Date:   Tue, 12 Mar 2019 15:57:40 +0100
Message-Id: <1552402660-31730-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:3vOdJtcuFi97R9HQAHPXeW5WbiIj9bdOlLxkEAZ4Ab/aPR0WSF1
 j7o0ssxuynK52QBIehBk+puY3CJTLIOhJgmg86uoj0pTb5tGfkVy8xaB5wFlh3QgCun7qA/
 wqgRm4wyBl6wBkcQjmglQh52NkGFNkJ/mkNH/7iZ1RQi3p0lG2WBxYKBHgKGdv3GoizgbNK
 eN1Y8l2W/izM3WKwAsOVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nQFfkVYH4jA=:GmtolKOmIfZy11JHg9b8js
 FcTcvgshbgurj9BzO1uZciK1kRO92xQ1MaAHbCsovCrIUo9r76u8nMI5VbidV8N0Sbz90cyd5
 8DF9llyb2SFDJQpguLs4FpnGhDyRidpxNFFSb2I5J1HSMOvMSn7RzOvOw46CadQZVhQ8wxwmQ
 +0s9WT2tpIKfKu89MN07WsAXByZQpUQtvEFUt1LlxK9szreLsg7fDpFuXFyxhbiUNf81daESF
 uPa0CJ5HbxeEa4Eglrqj+LW+MXV17nDHNtlAyXWPL29TNW8x678aHy0LdzasXgiwUHLM6cEKP
 fvOc2+bd9+34TbXzaWGEvg82AG8Tqd+mYX+SpFMbojfgeYYzZBH6axPq16XvLQSj17jFmpM5P
 YEkkQAf9SBtjCTlMXqZF7HOwJ2e2S/AUwdjgQMjRNhecjg0zaTBYGqxg7sfFQJ8wWHriUx37D
 2Cmm8i+R73QPiK5PYOZ23dBu882rGT6aOthSojhJIfavRPve0tsKI1X0PU8gsZVn/S61Gt3tt
 yPOmIXYWfREQW1fqy2V03yo8inaxmlYFrXEwjj3W2lEHmRqgCVean7mEPzCptrDe4SzhjqjNe
 b+RjPb9AhpRV62W5AIr6mGtlV30AE61Iv+U7mQ1u4gQqcdRvtKa8bg8iWfR1Gm5M+3Odm9CIg
 EdmXalprsEUWmMxhFjvOst/3eiG888uIGmU6wb/bwpGtIMdjnEu+OMT1lwh/ICrbtcBn+6KZC
 zwBrG8Y6NVwxRFm+BzayI/2kcMXLoj00MLs2/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/tty/serial/xilinx_uartps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..92aff38 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,14 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
-					 CDNS_UART_NAME)) {
+	if (!uart_memres_request(port, CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = uart_memres_ioremap(port);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		uart_memres_release(port);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,7 +975,7 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	uart_memres_release(port);
 	iounmap(port->membase);
 	port->membase = NULL;
 }
@@ -1626,7 +1625,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * This function also registers this device with the tty layer
 	 * and triggers invocation of the config_port() entry point.
 	 */
-	port->mapbase = res->start;
+	uart_memres_set(*res);
 	port->irq = irq;
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
@@ -1707,7 +1706,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
-	port->mapbase = 0;
+	uart_memres_clear(port);
 	mutex_lock(&bitmap_lock);
 	if (cdns_uart_data->id < MAX_UART_INSTANCES)
 		clear_bit(cdns_uart_data->id, bitmap);
-- 
1.9.1

