Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F80BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 568202087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfD0M4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:11 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfD0MxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:10 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmDAW-1gu8kq1m7s-00iDvn; Sat, 27 Apr 2019 14:52:40 +0200
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
Subject: [PATCH 08/41] drivers: tty: serial: sb1250-duart: fix checkpatch warning on printk()
Date:   Sat, 27 Apr 2019 14:51:49 +0200
Message-Id: <1556369542-13247-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:9XC3q0bfB2HQ4mApDU4u33n5sD/YoC7EqQPmqP5NMOedGA7sE7R
 zQ+4UMW4bXxRANtgf2zvHO2GKXDxkdKE28JdO/iNudeY0F3mJ+xc3fTNvs7ITqMXpD+h9nY
 QJb/I3M0+a59qd+LyzEcKpCXtBXjQ/BRgErxc0fambEKaAP14TyYVth7y55V4vy+3k5d+oN
 x/fGxgcPqoZSgK+QJd3pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KbQ0fHA3Nqk=:FuSxcrnKlCstL3CnqMetR8
 enSY2gm0q2GMzPD3zuPC8fZO7HmPN6yxLTvM8eVFp60ICRPcNK4tMFyvmEXAwQhCqV+QlhVfY
 /3SomP72AOXBFjUdm37A6u738T8AWaYhzD3ax41xd/91uO6TvCLXB01NFygTZ69KjGGvd6dHl
 J9lyE8nv3ouQZE4YSkwJ+QPVxRnzV+nPfZBZk/QPt3B8dqdrBa8sVikNqDUZSkcX6lYQS36SE
 LOscWWeMcd9cDI+xfMIg49C4I58k/YvzfJVXt4DERZ2OqnsDVF39SPQ6mxZd8kyZyvkWY68FT
 v4aBhQVWDfpD1t0GubgtmYzo8UOl2KV+/SB6VWAzR3um3S2sxVGVPm3DwToX97W+XO2x/IxZK
 Q6Pr1u8NIEMSywIsghBEkavAFQJyp6Kw1JS9qBGMdHI80KFXdjgfG+6C3hhkvcy6C1d4Y3nMS
 g+SUL9XMx7ynle+l8ySONYsf3S9/5LAeIgUVPU0xC0OjIcIwKL5yM7en/m6fRkNDK5yzev23m
 aXQatsJ5bHJbeQqA6Vbp/dppRd+sjlJA37mRBhWORrP0GnCiSK/iBZGK1z624u2RV/axQxVU8
 FgXt6VT4izE0gGVOenS522mBiI0JYa1/T+aqrIxVh2Mgd9NqSega9IxAQlHRGjbwRynjJt5Sg
 1101agAP9tCRr5Tje2tMwCcYDgbVyx7BPu9adznbugp+wmE/O4zeZ31tCdtTIo7gfOhkLPJ0f
 XXLVpK9o1Fyph8MTqd6Mt+RVaDYvSrfKML+CcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch complaints:

    WARNING: printk() should include KERN_<LEVEL> facility level
    #698: FILE: drivers/tty/serial/sb1250-duart.c:698:
    +		printk(err);

    WARNING: printk() should include KERN_<LEVEL> facility level
    #706: FILE: drivers/tty/serial/sb1250-duart.c:706:
    +			printk(err);

Even though it's a false alarm here (the string is already prefixed
w/ KERN_ERR), it's nicer to use pr_err() here, which also makes
checkpatch happy.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index b4342c8..227af87 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -689,13 +689,13 @@ static int sbd_map_port(struct uart_port *uport)
 
 static int sbd_request_port(struct uart_port *uport)
 {
-	const char *err = KERN_ERR "sbd: Unable to reserve MMIO resource\n";
+	const char *err = "sbd: Unable to reserve MMIO resource\n";
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
 	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
 				"sb1250-duart")) {
-		printk(err);
+		pr_err(err);
 		return -EBUSY;
 	}
 	refcount_inc(&duart->map_guard);
@@ -703,7 +703,7 @@ static int sbd_request_port(struct uart_port *uport)
 		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
 					"sb1250-duart")) {
 			refcount_dec(&duart->map_guard);
-			printk(err);
+			pr_err(err);
 			ret = -EBUSY;
 		}
 	}
-- 
1.9.1

