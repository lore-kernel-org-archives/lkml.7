Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1420835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCDD7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:59:36 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39641 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfCDD6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:58:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TLtwN3n_1551671894;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TLtwN3n_1551671894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Mar 2019 11:58:14 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-kernel@zh-kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, harryxiyou@gmail.com, corbet@lwn.net
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <triplex@zh-kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH 08/20] docs/zh_CN: format the submitting-patches doc to rst
Date:   Mon,  4 Mar 2019 11:57:31 +0800
Message-Id: <20190304035744.155203-9-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And remove Enghlish explainations in the docs, which it isn't
necessary in Chinese doc.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: TripleX Chung <triplex@zh-kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 .../zh_CN/process/submitting-patches.rst      | 36 +++++++------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index e9098da8f1a4..2a2989733c8d 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -1,31 +1,21 @@
-Chinese translated version of Documentation/process/submitting-patches.rst
+.. _cn_process_submittingpatches:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Chinese maintainer: TripleX Chung <triplex@zh-kernel.org>
----------------------------------------------------------------------
-Documentation/process/submitting-patches.rst 的中文翻译
+:Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-中文版维护者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
-中文版翻译者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
-中文版校译者： 李阳 Li Yang <leo@zh-kernel.org>
-               王聪 Wang Cong <xiyou.wangcong@gmail.com>
+        中文版维护者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
+        中文版翻译者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
+        中文版校译者： 李阳 Li Yang <leo@zh-kernel.org>
+                       王聪 Wang Cong <xiyou.wangcong@gmail.com>
 
-以下为正文
----------------------------------------------------------------------
 
-   如何让你的改动进入内核
-     或者
-  获得亲爱的 Linus Torvalds 的关注和处理
-----------------------------------
+如何让你的改动进入内核
+======================
 
 对于想要将改动提交到 Linux 内核的个人或者公司来说，如果不熟悉“规矩”，
 提交的流程会让人畏惧。本文档收集了一系列建议，这些建议可以大大的提高你
@@ -35,12 +25,12 @@ Documentation/process/submitting-patches.rst 的中文翻译
 Documentation/process/submitting-drivers.rst 。
 
 
---------------------------
+---------------------------
 第一节 - 创建并发送你的改动
---------------------------
+---------------------------
 
 1) "diff -up"
------------
+-------------
 
 使用 "diff -up" 或者 "diff -uprN" 来创建补丁。
 
-- 
2.19.1.856.g8858448bb

