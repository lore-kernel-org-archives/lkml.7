Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95525218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfCNWhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfCNWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:21 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mdv2u-1gVlt40Nfy-00b3ty; Thu, 14 Mar 2019 23:35:08 +0100
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
Subject: [PATCH v2 38/45] drivers: tty: serial: samsung: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:08 +0100
Message-Id: <1552602855-26086-39-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:6UXVHHSN/pSBbNy6AuA8qQkx6AtLHwlQl48BR55G72r4iZNdygr
 41CzcU0EUEiy9E8U/gKNs9RKX+r0+HDvVNw9phNXgBrTiysdxISUDMeZYutFSVuwHc+siq8
 KCu3fiiqgRtnherFTgfS+lKex81+mnGAWOWPNUrRrnz7bpSbnDHsTqH7IVgMQKsxi699gu7
 Tg3YiWSOGXDVfYsd8iUeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gVsb7my8ifs=:ZlKeXjpmAVa7MpOXnQxYOj
 TzwAOTJlsCSA1CYJRA7azVKI+6fmsfBjTiEc0hDFveZvvvzccJ/n09vK39Z0RNAdN/8LabStb
 4P04VpHWZk5jlYee6Gz6+lVfqgQL8Vl2wb8SI5KPTJhCAzw5G4L0coOhwM71E2EqIQGfQgDMy
 Z/E8w3a9D2QRzo40a2cLm5Wg4H6tVSBOGvLXweU112hflMWLORA0fyHydRxetlsu1sNXsm6ur
 vf+EEjTyOpxYFpGXJ68XGxGTv6+UUVW9DMLEoKbJVcpXFmFVHgkUbhxwXorP+YaIIu0cu3qa/
 DOUieeg+PhibNmneDV9x7g+xo+hBcUdwHmgtFPFOR/Iai7cSysC1awvFbcF4m0M3y233Kn60N
 aBBX23OTNm55txYykyg/uCfkVoItv7QUOT12Bg7J4q+hyVN/i7BEaVfSDYrxRV4IrC+slGJKq
 5RME/jO4Et159K9Fu520nBitb/o2wQ6ngakOzUk/n2Z2Odn7xHKBYezhePnVdn6zq83eJz2wM
 IRzuY/MHktcsbyGwiNfAiZoDJkadtoDvIqrbU2xd40sm0X9ac9cCOd2ulRQcRCjgSEC8x8w/l
 1L7FH/j6mpUUbuwbbiP4bYLR5Plv5H5fB26rtZjRkmf9Sz8B84DzLRniHXAurkMdfu5WNozRn
 CndnG6Zabu00wLRTTTFpDRT/mh1+ngNQ68zCNqqZfBCY4S1pxj11Z4ocT1UUWheif0niYrvle
 CjrrijuPP3dK/aJo7G0leJo+mpdG2F/QsyqXfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/samsung.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index a49cf15..e0bab87 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1436,13 +1436,16 @@ static const char *s3c24xx_serial_type(struct uart_port *port)
 
 static void s3c24xx_serial_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, MAP_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, MAP_SIZE);
 }
 
 static int s3c24xx_serial_request_port(struct uart_port *port)
 {
 	const char *name = s3c24xx_serial_portname(port);
-	return request_mem_region(port->mapbase, MAP_SIZE, name) ? 0 : -EBUSY;
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       MAP_SIZE,
+				       name) ? 0 : -EBUSY;
 }
 
 static void s3c24xx_serial_config_port(struct uart_port *port, int flags)
-- 
1.9.1

