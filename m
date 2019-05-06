Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CFC004C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8552082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 02:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vob8ntYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFCTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 22:19:47 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57598 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfEFCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 22:19:47 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x462Jdw5003248;
        Mon, 6 May 2019 11:19:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x462Jdw5003248
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557109180;
        bh=Vya/13bsWcbegIjw+dGbayHmf3WM/WFP+czE83gdy80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vob8ntYVYqlBp6KqtMsWpwPA+xJsOkwSq6oXdeMUhqTjf2lOmAmyUZFv7ssxQ+pL2
         SdAczp/EDK7W1WM2IDmzF5nKONgyZxJbc818rGuA0nfHgnDu7v8HlTks6LOefqFSzR
         cpUd/w7OGCIGpNTmV/40bA8NMXqyP+ZYMsSjpuLjKbAPF/F1Bz2ZiKKGEIXynNV4Ey
         fTzKbHIigMzufgzmBucoNXbJ5GyqPCyd7Y8uHhSiA+2mLizDXENLp5cxutyi8B46Zv
         vUaYZGoP+AhgMTMtE9KZf0oiWmetCIolMYWytypJ7p6l3KpPOEAyFauqmbRnVmsDX4
         7E6zBsZZvCzrQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id 49so701298uas.0;
        Sun, 05 May 2019 19:19:39 -0700 (PDT)
X-Gm-Message-State: APjAAAV9BlHi2h6nU5YWVYKKOBy73C/uIyWCjwTbd4MbWkfe66hmIbKh
        ZXhN+VJNGxCSjgzfCJeSlAFfuKVlnTskQeJM0Rs=
X-Google-Smtp-Source: APXvYqzNpAk6HvfTjhnOfMFygyp2YynWbz0GYI0vCCnRJtWS0p6k5Elw2WFFMSUkfCuMRxcH3asnT/kVNT2VXeXe/oA=
X-Received: by 2002:a9f:2d99:: with SMTP id v25mr10412617uaj.25.1557109178802;
 Sun, 05 May 2019 19:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190506094609.08e930f2@canb.auug.org.au>
In-Reply-To: <20190506094609.08e930f2@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 6 May 2019 11:19:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
Message-ID: <CAK7LNASH4CuVBjfEJsT+aBx4aLrj9j2=aOD3B4f9+Tdcm=x2pg@mail.gmail.com>
Subject: Fwd: linux-next: build failure after merge of the kbuild tree
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007ac93f05882ebb3c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007ac93f05882ebb3c
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

In today's linux-next build testing,
more "make ... explicitly non-modular"
candidates showed up.


arch/arm/plat-omap/dma.c
drivers/clocksource/timer-ti-dm.c
drivers/mfd/omap-usb-host.c
drivers/mfd/omap-usb-tll.c

Would you send patches?

I think EXPORT_SYMBOL_GPL() in omap-usb-tll.c
are also unnecessary.

Thanks.



---------- Forwarded message ---------
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, May 6, 2019 at 8:51 AM
Subject: linux-next: build failure after merge of the kbuild tree
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
Mailing List <linux-kernel@vger.kernel.org>, Alexey Gladkov
<gladkov.alexey@gmail.com>, Keshava Munegowda <keshava_mgowda@ti.com>,
Samuel Ortiz <sameo@linux.intel.com>


Hi Masahiro,

After merging the kbuild tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from include/linux/module.h:18,
                 from drivers/mfd/omap-usb-tll.c:21:
drivers/mfd/omap-usb-tll.c:462:26: error: expected ',' or ';' before
'USBHS_DRIVER_NAME'
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
                          ^~~~~~~~~~~~~~~~~
include/linux/moduleparam.h:26:47: note: in definition of macro '__MODULE_INFO'
   = __MODULE_INFO_PREFIX __stringify(tag) "=" info
                                               ^~~~
include/linux/module.h:164:30: note: in expansion of macro 'MODULE_INFO'
 #define MODULE_ALIAS(_alias) MODULE_INFO(alias, _alias)
                              ^~~~~~~~~~~
drivers/mfd/omap-usb-tll.c:462:1: note: in expansion of macro 'MODULE_ALIAS'
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 ^~~~~~~~~~~~

Caused by commit

  6a26793a7891 ("moduleparam: Save information about built-in modules
in separate file")

USBHS_DRIVER_NAME is not defined and this kbuild tree change has
exposed it. It has been this way since commit

  16fa3dc75c22 ("mfd: omap-usb-tll: HOST TLL platform driver")

From v3.7-rc1 in 2012.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 May 2019 09:39:14 +1000
Subject: [PATCH] mfd: omap: remove unused MODULE_ALIAS from omap-usb-tll.c

USBHS_DRIVER_NAME has never been defined, so this cannot have ever
been used.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/omap-usb-tll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 446713dbee27..1cc8937e8bec 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -459,7 +459,7 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);

 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
+// MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");

--
2.20.1

--
Cheers,
Stephen Rothwell


-- 
Best Regards
Masahiro Yamada

--0000000000007ac93f05882ebb3c
Content-Type: application/pgp-signature; name=noname
Content-Disposition: attachment; filename=noname
Content-Transfer-Encoding: base64
Content-ID: <16a8aec8052c204bfcc1>
X-Attachment-Id: 16a8aec8052c204bfcc1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFFekJBRUJDQUFkRmlFRU5JQzk2Z2la
ODF0V2RMZ0tBVkJDODBsWDBHd0ZBbHpQZGNFQUNna1FBVkJDODBsWA0KMEd4UnRnZi9lNGNBdXRw
WENGUFdOcGRtTEpuejB5UitrOUN0UGdhd0I2dTEvNWhvUGswbkZyWTZCU0hwbGltdw0KUjg2L2o4
ajRoVmswMy9Yd3RjYVNGaXNqbnpVZ2lOSU04K3lWVU1WWUd0b20rM3hLLzR5RW42UGxXd1lybDBI
UQ0KbG5pemx1U2lyZk1IOHVkN1FxV3htMk1xbENuVlJTV0piM3UrM0pzaUljSkNiS3I3MjNVczNI
SUtKWktoK1MvdQ0KK3F3OXpscGM5c1U5N0JBWTBuVHh0VVFUVXVBTHF4UGYvanlXejlnR095dmF1
dW1zd1lDb3MxSmtVeHMzaWhqNg0KaGErWklyeWdXT3VmVXF0bGFENXNveGoxbEdNdkpheXZ2K3R6
bk1wQTNFUGxQMGNRTmwxR1FIbFQvWlVOTGJ4bQ0KVmpYcUNoUjZYaXRldWxyRG9tVGd5VHlJaUkz
WmVBPT0NCj1SNXhNDQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==
--0000000000007ac93f05882ebb3c--
