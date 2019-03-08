Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81872C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2A42087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCHMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:45:13 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:45209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCHMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:45:09 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkpOZ-1geygB0CQp-00mHtV; Fri, 08 Mar 2019 13:44:56 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        info@metux.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/5] Makefile: rules for printing kernel architecture and localversion
Date:   Fri,  8 Mar 2019 13:44:20 +0100
Message-Id: <1552049064-32044-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:+ixOwLE+asB1gu5KRcJba3ZH6tn0P8p/UELGgM50mCP40lk3VeI
 GKZ9QDK2s+f8m3Ah3aDaWOw4T4JtMaBLkb7JBxD0Rg9kn7ql7tOpmnjavKihaIXuiQ8YYHE
 Lt65GwcFTc0jV3pYDy7e8iwANSCrKz/7tTR9k+lG+6Z4DByebo+772xXEChCPEM1rAooED9
 OxPvxZE7hhSvQN/ksyB1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:byOpdQzzR6c=:wZ5M0Pv2bS+7hixhgm9M0e
 UGh0dBe7Em9HsXAsbvLjTSdKGUB2cTtRCFx95JcxkPRbK/vcc4/ToJ3wuPdn7pro+IdzY+qMY
 Oq556zVtK/SydgkbcUJEufKS9FjcVS4pqcOKEoz3bAVWBOfxqEqguivy1JikAwAM9YwOeu8Gc
 CB0jhk54YWBJ2chxMrsCQvkxhP3jIkZB43hmIEKQVvTdPcKsuOzTwCncAWKKP9x1jr3Tdcjnl
 s62WPrDIg1T7URHmBQ/kTkV5mZzSKFBt/l/NHbQ4BMJLWT550C6BWQHWMuy0BQcUWTtry3GOW
 frFGvCyJQV3CDmy+aKDdbJMHQM8xqW9PqCtubtBJzUXRo/ocxg7vQsK8VR18z7/kWySvqULkG
 LbLVJ/1MS3Z3YwNObl5yr+aN9huVhalYgxbEeXhRh7ZccDOl4arQntWyowVRKSUs9OOvhdyrU
 96sDXlrF4MKI7WwyTrFJUyNy5Oq5vZVgBjM+9D5/be1/1LQzCJ0zhGFZ4MfWks56S+Z7YZ/+P
 3OvkhNY4NfO6N7/n8DjiUtA50CQCo3FMk9t7MFy3PM2qLE1/uekt0tGZ1jkFzL9+8PQlKaMdl
 jXqoqsWqqMP1oBo4cTa2qZM+lhnhkrL7gsrkh2HvN4MKkaJPqhrNhuptG5q8/2XWTc5ThrPMP
 HD+AQBhpFx5OYGDDNuF2Ec5h9W2fbO1X1Pwb7dmQkTjm3eXBSGnjWUJfFm61w/IJUXYBvePJL
 3Un3nXhWIwGDgId1AWN8+e0e+i4CyzZH7prJnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trivial rule to print out the kernel arch and localversion, so
external tools, like distro packagers, can easily get it.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index f070e0d..95b50f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1664,6 +1664,12 @@ kernelrelease:
 kernelversion:
 	@echo $(KERNELVERSION)
 
+kernellocalversion:
+	@$(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree) | sed -e 's~^\-~~'
+
+kernelarch:
+	@echo $(ARCH)
+
 image_name:
 	@echo $(KBUILD_IMAGE)
 
-- 
1.9.1

