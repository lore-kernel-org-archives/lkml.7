Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF93C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B507620857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfDHV1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:27:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDHV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:27:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MS3zP-1hJPdY1wV9-00TWvn; Mon, 08 Apr 2019 23:26:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] s390: remove -fno-strength-reduce flag
Date:   Mon,  8 Apr 2019 23:26:14 +0200
Message-Id: <20190408212648.2407234-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LqHHgpaYv00C4GNBFy+ulbCuWrypd5VbvhNBVd9z69CI+OkMOsg
 RwG7b0Zahao0Gqw/bG87G9VjwdXfjNGuEEsLSY5DbMxoItd57xr8HN0lLpSZgQiRLZt0Au1
 8q/kqSiwHROLdYeWkvSOn6VKFen52IgyQZ1nhOFjvw9rUp7xZ9bV1pl4v3HD1IM9ljZoyQ4
 JAkOAZhTqjiSd5D6acnnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0H06SCbXAyM=:qvY6HriRt+kLxdCEgblnmp
 QMbPBW9p3VipyP7Pn6lJou1GNZBLKQ3FboMmLK7QXb2bH9q7V17eJmyTIfphspc7s74wQfTnB
 tFufQqPrPi3eHC7EE7OdvqW+yv0NyVQQl7AyX4ExV4hQQarVtDFOUZB9ThOKJHMXeJKLbuNak
 twyICw49eNT2QhnNWEvGBWzPtA8CxRAIYhEklcybUFcjc+lpEtJZQCZud2Gt5tImkZfJwSoFw
 JJA4UBl3J4nigKNUh7OYtfAcmbPFY6veWeneGieDvDYde4Zkt9H6XpJ2GLXP8HYsiNLzctOlc
 FfR/mYIINnDQxjbhtRw4cD1BDCg2mPj1hhnoPIrBlE1hm2oWLbiSzdMMp1Nzdd1iIVfCbF23b
 jUU+9aeSpnPQ8wIDibB8ONs/SFA6hlmuk+4Zm+kWKSpE2fVSgxe/7yEUZC4JGV9vAeElgr0pi
 WpmnKdqiTIp9rcCXCcWyQ2jzUHyQy3XiVCe8ZqQloaOq5evh5T35SXVi+Q/8eP58Qo+RBTW+S
 cwq+IJLcu4RiPl4GRMILQPbkWvZwC45xDJBqHqgXtuLHjtlh41me69sFObuvAKZP/pgkJcZ9a
 J2cRNUF/uBZRupf7K0sETL1YJm7lsyCyeWemtohmEJTFmephVsetjkbuGYFf7WfPW3h6NMUmX
 69gEaBPitD0n11oTvdMXxRoB9+/jOa0pkx3BcG/aRKa1xRJsWclzUxMcRcpA7UT+X1N0TBvAf
 qSiQcfcVDwlFHtSKYAHAWl86rMSewsiby/5MSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was added as a workaround for really old compilers, and it prevents
building with clang now. I can see no reason for keeping it, as it has
already been removed for most architectures in the pre-git era, so
let's remove it everywhere, rather than only for clang.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 86c76b149cc2..0087d11e3eaf 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -114,7 +114,7 @@ endif
 cfi := $(call as-instr,.cfi_startproc\n.cfi_val_offset 15$(comma)-160\n.cfi_endproc,-DCONFIG_AS_CFI_VAL_OFFSET=1)
 
 KBUILD_CFLAGS	+= -mbackchain -msoft-float $(cflags-y)
-KBUILD_CFLAGS	+= -pipe -fno-strength-reduce -Wno-sign-compare
+KBUILD_CFLAGS	+= -pipe -Wno-sign-compare
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables $(cfi)
 KBUILD_AFLAGS	+= $(aflags-y) $(cfi)
 export KBUILD_AFLAGS_DECOMPRESSOR
-- 
2.20.0

