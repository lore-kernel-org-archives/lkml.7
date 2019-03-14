Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D921873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfCNWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:34 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfCNWfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:22 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McHQA-1gU8G81aX6-00chnU; Thu, 14 Mar 2019 23:35:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 30/45] drivers: tty: serial: serial_ks8695: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:00 +0100
Message-Id: <1552602855-26086-31-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RqmNHQG6GlZCyxEPs4T/D+FeHKdpMqllZFhLAoxsdJ5FPoo1fK3
 oJcg8qSRtX/GrS1AQsMUQ0WKpU9Quss9wS8FvyXaAbtDBWHMtXOnotDfmnX7+ginoYsPnTq
 vru5F/NsJawa/bbk17tAvdhbrQGbKFC44LzRg/WnWeT42AYueLN4HL85mh8HgFsoUUVyyUy
 /Lop32066rj15fzOr+vvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mqejw16SOpQ=:KFNSlCtfkkisPEPkBrBnsc
 kuivJd3XAekgcvBcTxoD5c6wXNt1mIBGzghPRwc08fWDouBDLWMXrGikjetGM0iKAFnvJT7Uj
 h2yQojH28ZZ1A8U8fO1klYyStE/NLgK9t+TPo9xcNI1UkEVc0p01kg7r+XhAU78MKO3j6LUBe
 BXRT3Gp9RQTDzrAfZO4h17u3Hcxd7Nke2wgU+u+qzdpiiNg+ycfL6U2nKGX8IZkYbMGh85vyH
 n7D4MwVqKg72xusHwri0VR9ONsNFu+MdULL+NtOmcjLheAQflJ3WPguPKj4OMPB9X5GgIdky3
 jZBMjI4DHvemhYjiymVWUCW/ECs69iqZZnHa4fy69qauZtZz5hbtRt3pMqVH3wwCwYYu8Lt/T
 75vuJVZgmxMv+AfInzEHI03OIQhW6K9ukS8b97ag3V+H0mbt3I1IDSRcvz3xolBYOsViOrGHk
 ouXXEVKBzX6sipeJveuNFeuJ1whFpomkUOmUV3Orn/I7HlB7PsL94d7D40ZH59dw8HKtExJP9
 QEwJb0/RQHpVfuXSYH9aJgfcxe90KQPDh1rW0Y5JV+B2Y4zxXONAGhjmrULuAXzE3REuOS9XO
 brOozwTbGiYHiBzIFp62M+m2zgI7cInPlu74m+l9XNIEX2976yzAhKJ35tJjA9AMH4dV1X/PA
 1LTZal/pcySypISsWQLADC1bhmfLW71elf91Diz+8N799Q4WarLXuNi3Ls7O1lY4En7wTmh0g
 +nvCQ5OuxI2A3rgBQ/hY6FKlOLwms7z4rUI0TA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.
---
 drivers/tty/serial/serial_ks8695.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index b461d79..f901eea 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -482,7 +482,7 @@ static const char *ks8695uart_type(struct uart_port *port)
  */
 static void ks8695uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -490,7 +490,9 @@ static void ks8695uart_release_port(struct uart_port *port)
  */
 static int ks8695uart_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       UART_PORT_SIZE,
 			"serial_ks8695") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

