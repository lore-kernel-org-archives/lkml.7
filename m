Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC26DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6522067D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394706AbfIFPJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:09:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfIFPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:09:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhUDj-1iated0Y4J-00eZJS; Fri, 06 Sep 2019 17:09:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] exfat stopusing CONFIG_FAT_DEFAULT_IOCHARSET
Date:   Fri,  6 Sep 2019 17:09:04 +0200
Message-Id: <20190906150917.1025250-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uqse4hogKOr7BI9YbaZwXs0qyNe9NNWburGdPI+eJEYl2q8Qt1s
 uQVNJNkUVfq+l/FOkvdPd5DI9S065oyd28MutYIcNOCemFvmd3sk0OS91NieEqurLW0ou7f
 7ybSd+bMXeKQX5WVWhkVlHXTSMVz410x/mC3E8ME35vkFYSA8+DLyrt9KG6rKKChBeUtw66
 fXV42UtlfUIJdeW5Yh2ZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FoCFpjAsA8=:5xtEH+8/eJEDimTUKDvoYx
 kHftU+cpIZPlUEmKAgHcJcxq4+61ytMOFgBk1BUg/7s3p9h3KjyOBG4cplYu2dq9FduHsP5Wd
 etPBm5XzDrEnA9JY8SZ1xaAR7hD2IxFe1Stnq6vsIEpFiqPcJmicIKmVjvF325ZY0IyIrvzdr
 TQNfgsdGgIgXaEiHFvtwPZtWH3UpLrD8tp/lYpaBUP5GqFIYLsJyrVidm5t42K25yyfF8IG9N
 vYQwy/yGu1XDYBHnnWjnk0d0at38ouNKDmx9jDQgr+BAIFQWjAXnD4eY8jFP9btIELx8fHEhd
 OpU8yixFAEbdhpms2EPQ7/wQ7TOA+cCl/1Qk1nunsskh6meH2OeEiMT1aH7kGMaNecVP/pWP6
 RrQekXMfDXUmHSi8+iSBUKP2uHkETJkOFqN0fXjisKElLbxq11b2Vwa2NkwUE87H0gNe78Qty
 lIVGFWJqW4g4epFt31ZxReiSmtTxshaz/lCpNVfQwAf0yCpq+OnaaKbhvD5bjnwznMJDVDXMn
 SVfFK/LPNj3dCPIO0S4pstaF+rsEKQ3O0UpHyMSYBk1Virp5T+b9ScsK3AOiR6pk+mNr6JkD0
 sDJCXFSskfU8O5Ky1m3zMVsBWAwRG6qqzCz2KfYgXsFJwDjShdHbsOq6rm1kV86hKelnGerIZ
 /n6ejLqNNTazUL7mEzUWJqg+DzXA/dkphaju4bZlcBowvBQ1GvMzzHzhoM8T9dobYJMNPWCPj
 RHQFXGcTLWue1b0TAUZpOzbZJA3c/hKBWaJlbetfN/Rkt39ZPz+M0ybZzyysB2Y5cATh9aQEH
 3nyf+i1B3NKhmOpzHwTU1xruTx4QN0n6LzmF5qAQNPGNS+hyF0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_VFAT_FS is disabled, the reference to CONFIG_FAT_DEFAULT_IOCHARSET
causes a link failure:

drivers/staging/exfat/exfat_super.c:46:41: error: use of undeclared identifier 'CONFIG_FAT_DEFAULT_IOCHARSET'
static char exfat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;

I could not figure out why the correct code is commented
out, but using that fixes the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/exfat/exfat_super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 3934b120e1dd..37e78620723f 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -39,11 +39,8 @@
 
 static struct kmem_cache *exfat_inode_cachep;
 
-// FIXME use commented lines
-// static int exfat_default_codepage = CONFIG_EXFAT_DEFAULT_CODEPAGE;
-// static char exfat_default_iocharset[] = CONFIG_EXFAT_DEFAULT_IOCHARSET;
-static int exfat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
-static char exfat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
+static int exfat_default_codepage = CONFIG_EXFAT_DEFAULT_CODEPAGE;
+static char exfat_default_iocharset[] = CONFIG_EXFAT_DEFAULT_IOCHARSET;
 
 #define INC_IVERSION(x) (inode_inc_iversion(x))
 #define GET_IVERSION(x) (inode_peek_iversion_raw(x))
-- 
2.20.0

