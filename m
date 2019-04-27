Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8FE2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfD0M5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:57:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfD0MxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:07 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBltM-1hUJWA0Zhs-00CCVD; Sat, 27 Apr 2019 14:52:42 +0200
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
Subject: [PATCH 10/41] drivers: tty: serial: sb1250-duart: fix missing parentheses
Date:   Sat, 27 Apr 2019 14:51:51 +0200
Message-Id: <1556369542-13247-11-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Q5d+R5/xof5LSpkM+m/1QK4rIat5cet+2kq+5TbMlzlAg7YOwcq
 yY6SxH8FWCXU0xZpYSh06YbjnruYS3jvbIaTQGqHoabIXLaqLV16hsMLD2TgWS4RStegv55
 BXylfzMhBa4VLDqOgexGnNJRWU6fc3oOK3V503qwx9kOQsSqkjZe8MoxRvmw7LEmLadmc7U
 bud6UfVRg0CpivgeZa72w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vacU+lH9z3Y=:pyr1jcpDGvApaYEzFf7e+R
 TMve7dv5wGRdKDhjI8oStSB5dn5DoxuIjQtwxI7jTd4ue0WswnmOCAVKClxkf4W5Y+po1lpzp
 uy6mxTJAhaqkZ+uGwup3aHiE2yXSyK5Dtp59G6H8wjH1xJxWJJe3rh1QuItg4GGwqOxe7ZvlT
 bCfCaP+FUICSNHAr7GAy80cRej9Mbw8LQ/CAIWpG2FHp/HNBuaCWY5bg6pgzDY6U4+Mpk3zpX
 NFS1TFEHN4C1TorFOl1ieIq8+33dawCeqWbRy63450HHNBOxnTXMXgXVZ2dGvHt/MaKHK5QHX
 znNS5++8zZ+FgewRGYerTgJaPvxtSpjOrO+jaVu3eScKrVacwFh6aPYL9Tg1gWYFFwQsJ6CzA
 iKmAZSq55bvXg+JjYDMB6zLZ4DgKDCfJKq+793jpqfro5b1srUPD1zx3NgseUD9Kp6w3sqboX
 Jvu9ZKFLbaF+cSRGF+A7QScl6NPRPACxYAB2L6P0+kWLYwR7X+40GC4Dw4eh8YRnCKclBPBig
 8U4uiH49D8vlepRn823eKH2LdKEGXzfXXG8QTIyXa/vacZIxHEo6Wg3QFLTaPFTQxybxeHFMN
 sVhpJgAzc594zwa50x10eL253pPhsMkF5H509I0vK9nGkC85rsoXTRr/Co6LoNNGj9pnxWgK9
 yOIYFsO9w0GUdP/baMxqZ6uqvZ4AtEaJLlWSshjX/lDO4KbZaj05oKWIdPmB24fo9yrxwcOFJ
 I5chlHAJ/2z+EvXqOzAr/sxxn02wqDKKYoAVwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

    ERROR: Macros with complex values should be enclosed in parentheses
    #911: FILE: drivers/tty/serial/sb1250-duart.c:911:
    +#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 1184226..ec74f09 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -908,7 +908,7 @@ static int __init sbd_serial_console_init(void)
 
 console_initcall(sbd_serial_console_init);
 
-#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
+#define SERIAL_SB1250_DUART_CONSOLE	(&sbd_console)
 #else
 #define SERIAL_SB1250_DUART_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_SB1250_DUART_CONSOLE */
-- 
1.9.1

