Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE23CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8B2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfCEG7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:59:33 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52414 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbfCEG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:59:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TM.WZOD_1551769112;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM.WZOD_1551769112)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 14:58:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        harryxiyou@gmail.com, corbet@lwn.net, leoyang.li@nxp.com
Cc:     colyli@suse.de, fengguang.wu@intel.com, shawn.guo@linaro.org,
        lizefan@huawei.com, Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v2 06/27] docs/zh_CN: howto format changes
Date:   Tue,  5 Mar 2019 14:57:53 +0800
Message-Id: <20190305065815.157964-7-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190305065815.157964-1-alex.shi@linux.alibaba.com>
References: <20190305065815.157964-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

also with few contents changes

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 .../translations/zh_CN/process/howto.rst      | 37 ++++++++-----------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 5f6d09edc9ac..e4e800591ae9 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -1,32 +1,23 @@
-﻿Chinese translated version of Documentation/process/howto.rst
+﻿.. _cn_process_howto:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Maintainer: Greg Kroah-Hartman <greg@kroah.com>
-Chinese maintainer: Li Yang <leoli@freescale.com>
----------------------------------------------------------------------
-Documentation/process/howto.rst 的中文翻译
+:Original: :ref:`Documentation/process/howto.rst <process_howto>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
-中文版维护者： 李阳  Li Yang <leoli@freescale.com>
-中文版翻译者： 李阳  Li Yang <leoli@freescale.com>
-中文版校译者： 钟宇  TripleX Chung <xxx.phy@gmail.com>
-               陈琦  Maggie Chen <chenqi@beyondsoft.com>
-               王聪  Wang Cong <xiyou.wangcong@gmail.com>
-
-以下为正文
----------------------------------------------------------------------
+    英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
+    中文版维护者： 李阳  Li Yang <leoli@freescale.com>
+    中文版翻译者： 李阳  Li Yang <leoli@freescale.com>
+    中文版校译者:
+                   钟宇  TripleX Chung <xxx.phy@gmail.com>
+                   陈琦  Maggie Chen <chenqi@beyondsoft.com>
+                   王聪  Wang Cong <xiyou.wangcong@gmail.com>
 
 如何参与Linux内核开发
----------------------
+=====================
 
 这是一篇将如何参与Linux内核开发的相关问题一网打尽的终极秘笈。它将指导你
 成为一名Linux内核开发者，并且学会如何同Linux内核开发社区合作。它尽可能不
@@ -114,6 +105,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     "The Perfect Patch"
         http://www.ozlabs.org/~akpm/stuff/tpp.txt
     "Linux kernel patch submission format"
+
         http://linux.yyz.us/patch-format.html
 
   Documentation/process/stable-api-nonsense.rst
@@ -519,7 +511,8 @@ Linux内核社区并不喜欢一下接收大段的代码。修改需要被恰当
 很多人已经做到了，而他们都曾经和现在的你站在同样的起点上。
 
 
----------------
+感谢
+----
 感谢Paolo Ciarrocchi允许“开发流程”部分基于他所写的文章
 (http://www.kerneltravel.net/newbie/2.6-development_process)，感谢Randy
 Dunlap和Gerrit Huizenga完善了应该说和不该说的列表。感谢Pat Mochel, Hanna
-- 
2.19.1.856.g8858448bb

