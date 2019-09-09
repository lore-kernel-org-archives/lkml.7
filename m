Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F310CC49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25342086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391764AbfIIUqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:46:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIIUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:46:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McH1Q-1ihaFj11VE-00ceqT; Mon, 09 Sep 2019 22:46:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] smack: include linux/watch_queue.h
Date:   Mon,  9 Sep 2019 22:46:25 +0200
Message-Id: <20190909204631.1076624-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7kPRGYZSWYf2iP8zTqFhK7+b0tun5SPyfoyi+uDXVHze5EFuFqS
 Nzh3llpFi4dmcPwTfZOoHLg3he80h016/nSZQMEE/LclAAnZshx65ZWiqrpp6ewK6y+iKZp
 TK40a875Caah6kL2Z6OJLqQYd5DMCurbxVGHv0veJL+f1WJ2vGkPvJG60YwKcr4mbQFoVH7
 vp56UYM1KdXNtRtxjDX7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2q+6/0M+sY=:+ZeLnOSbtYroQQf1oURVYy
 tLW6O3suuY3f2DJRTvLJJ5eHugugl9w3/Xk4a7r3lF0IypVF31eKbWJx5y3rqcE1m/RatIfWG
 XtEZFlH3ZPdHQM/mqlqzCTWlF7zYpEP0e7yoRZc39KYUwkf0ZBPCx9h/gZ8JOV4Q+/yV5aZvk
 JC9gLeRRxkpaXqI3LKGVm5LOERxEdSQ+gIwlIUkNcKGeoQJ9f2pvGQfBTu/7ab/FB9HcyqnwD
 ObLCydlDoh63tdoUJnJ56cGM8NRymT1nHGc2tksdOQpN8zayjEOKEkw/XsWO7vbUwB2Fjy4Uc
 mxGmdOSJRZVAOiIPIQzs7w98KpRc4EIaMlzO0csfbh2K0WBjUpAQD9Su1m1j2jaOJ/imYFUuy
 LAF1whCkZe78ABAsSJ7BBJrShKIu2cT/fAOyIF6Ri57qRZysNbI8vlUCGUJ1QIZmM8bBzSYhd
 KfyKiTI9DfWBseZDKQCG/weOSi+d7Iz4UwjV04OiP5nkneaJ4hcxg/LObLUo64pxAXPinw1/w
 HOndy9Nv/Mbfb67ZUAnSBQSILI2HpkrRRxXU/A6NTpSb7wrLx8GU0nenXxPo29Jx5oHU5TV/l
 l7jZfIS5r2HfRV4yfAYlsnNzrNGug8+hrv+t/pLG9kPNem3mQSGbZsOQdfiYeOwDekweKIELt
 cTVLn2GZ6HKMqq2T8Qoe9NXh4O7WcTSkeGWAyidRN86l9tS9qdRqtwpPE5L06H+l3fLrrbmcl
 ZqkkB/ktI44sgFMOrSTBMFTNA5CCnO1mDoe+RRjeVfsljPlXdC1ciRxb3HdigWb352tcZlBbA
 YcyviTOFF8uU8aAGMaL2xSduJYRVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some randconfig builds, the lack of an explicit #include
in smack_lsm.c causes a build failure:

security/smack/smack_lsm.c:4384:7: error: incomplete definition of type 'struct watch_notification'
        if (n->type == WATCH_TYPE_META)
            ~^
include/linux/device.h:46:8: note: forward declaration of 'struct watch_notification'
struct watch_notification;
       ^
security/smack/smack_lsm.c:4384:17: error: use of undeclared identifier 'WATCH_TYPE_META'
        if (n->type == WATCH_TYPE_META)

Fixes: 5301fef8ca60 ("smack: Implement the watch_key and post_notification hooks [untested]")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/smack/smack_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a15e76489683..5120dd9c6335 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -42,6 +42,7 @@
 #include <linux/parser.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/watch_queue.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
-- 
2.20.0

