Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6974FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4030F20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988662;
	bh=5F9He/JTjS47XRoiu2ueFi9Y8ZrlEGSvSIqSGl6ur+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/OjsSYjzxznyYlX+j8VReDckgWgakGA3vOiUwVGefjgNKg2ae1gb+ekioBDBPWAK
	 IJkdot6h37duOG/2xgLeb7TdQ2Wpro+rGFtjoFIAvSl2Qp2vMbTth88RDnZYrpkMI9
	 7zO4PaYpVsAKVmXzRNfMD+7798de32pNwi0NgYDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfLJOhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfLJOhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551EA20836;
        Tue, 10 Dec 2019 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988656;
        bh=5F9He/JTjS47XRoiu2ueFi9Y8ZrlEGSvSIqSGl6ur+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Asj3mXXjQdygob6rd9S0uaev96tViCJSG8p4cN9zI4oMsQ1wB7nKWDAYyabUyFk7I
         XVtgyQ+Ehm1I7KehZv7JqaqD3aqnuFHXt8iTy8vfD5VAVwar70lN7Zx+dej4dFMekh
         16OUcNKotDz2Z4U4vyFgN3G5Ed8EaNzxNvNAa9ic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] tty: serial: samsung_tty: fix up minor comment formatting
Date:   Tue, 10 Dec 2019 15:37:05 +0100
Message-Id: <20191210143706.3928480-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up some minor formatting of comment blocks to make checkpatch
happier and to make things look more uniform.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 3dfb4f37ec69..4aebed241068 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -4,7 +4,7 @@
  *
  * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
-*/
+ */
 
 /* Hote on 2410 error handling
  *
@@ -19,7 +19,7 @@
  * and change the policy on BREAK
  *
  * BJD, 04-Nov-2004
-*/
+ */
 
 #if defined(CONFIG_SERIAL_SAMSUNG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -838,7 +838,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 
 	/* if there isn't anything more to transmit, or the uart is now
 	 * stopped, disable the uart and exit
-	*/
+	 */
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 		s3c24xx_serial_stop_tx(port);
@@ -1142,7 +1142,8 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 	ourport->tx_claimed = 1;
 
 	/* the port reset code should have done the correct
-	 * register setup for the port controls */
+	 * register setup for the port controls
+	 */
 
 	return ret;
 
@@ -1242,7 +1243,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
  * baud clocks (and the resultant actual baud rates) and then tries to
  * pick the closest one and select that.
  *
-*/
+ */
 
 #define MAX_CLK_NAME_LENGTH 15
 
@@ -1683,7 +1684,7 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 /* s3c24xx_serial_resetport
  *
  * reset the fifos and other the settings.
-*/
+ */
 
 static void s3c24xx_serial_resetport(struct uart_port *port,
 				   struct s3c2410_uartcfg *cfg)
@@ -1737,7 +1738,8 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 
 	if (val == CPUFREQ_PRECHANGE) {
 		/* we should really shut the port down whilst the
-		 * frequency change is in progress. */
+		 * frequency change is in progress.
+		 */
 
 	} else if (val == CPUFREQ_POSTCHANGE) {
 		struct ktermios *termios;
-- 
2.24.0

