Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AA3C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823EF20693
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DT/iC9OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfG1PwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:52:14 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:34478 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1PwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:52:14 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6SFpifR021897;
        Mon, 29 Jul 2019 00:51:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6SFpifR021897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564329105;
        bh=t0JMKbCgzALADlRlk5daEw4umA/mhUeVbFe5ZCEoXzs=;
        h=From:To:Cc:Subject:Date:From;
        b=DT/iC9OSqN8XzGfizfCx7PjoKmmsDPAcRKw2s+qZ6iBF7rSrwmW9qu7Cn5dnFz+y9
         pzjciEVGn3hrJCUmjZ0YjPeVTNXcbocMQ89/6y+QJXEe74RDJmdfYEdxHCSo3VDx2r
         s/zYauqBiqTnT47/Y+jQgmTqOXZ0N9M17UFnZrvxo1W3bOxu6qC61vgwpDD7e/w9hH
         rCllQyZpNygKi7PFUwOA148iKpjKc9WxSxKeoOk8hn2RbGmHs5g+hSEAgPD5W4JSNs
         /HFvvz62OkV9f1rbI+2PJvM18l+uEN9lkrKE2qWIVpOVy5oo21nBUfqUmwTucqsMau
         F6EeVgzLFyDGw==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: add include guard to xt_connlabel.h
Date:   Mon, 29 Jul 2019 00:51:38 +0900
Message-Id: <20190728155138.29803-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/linux/netfilter/xt_connlabel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/netfilter/xt_connlabel.h b/include/uapi/linux/netfilter/xt_connlabel.h
index 2312f0ec07b2..323f0dfc2a4e 100644
--- a/include/uapi/linux/netfilter/xt_connlabel.h
+++ b/include/uapi/linux/netfilter/xt_connlabel.h
@@ -1,4 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_XT_CONNLABEL_H
+#define _UAPI_XT_CONNLABEL_H
+
 #include <linux/types.h>
 
 #define XT_CONNLABEL_MAXBIT 127
@@ -11,3 +15,5 @@ struct xt_connlabel_mtinfo {
 	__u16 bit;
 	__u16 options;
 };
+
+#endif /* _UAPI_XT_CONNLABEL_H */
-- 
2.17.1

