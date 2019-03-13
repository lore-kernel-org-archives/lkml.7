Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B375C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156B92171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfCMNue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:50:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58160 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfCMNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMdk0s-_1552485022;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdk0s-_1552485022)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v5 10/31] docs/zh_CN: rst format change for stable-kernel-rules
Date:   Wed, 13 Mar 2019 21:49:40 +0800
Message-Id: <20190313135001.260905-11-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
References: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to Make it readble with rst format.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: TripleX Chung <xxx.phy@gmail.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/stable-kernel-rules.rst     | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
index db4ba5a0c39a..425d06f99ac2 100644
--- a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
@@ -1,31 +1,26 @@
-Chinese translated version of Documentation/process/stable-kernel-rules.rst
+.. _cn_stable_kernel_rules:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Chinese maintainer: TripleX Chung <triplex@zh-kernel.org>
----------------------------------------------------------------------
-Documentation/process/stable-kernel-rules.rst 的中文翻译
+:Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
+        中文版维护者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
+        中文版翻译者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
+        中文版校译者：
+            - 李阳  Li Yang <leo@zh-kernel.org>
+            - Kangkai Yin <e12051@motorola.com>
 
-中文版维护者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
-中文版翻译者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
-中文版校译者： 李阳  Li Yang <leo@zh-kernel.org>
-               Kangkai Yin <e12051@motorola.com>
-
-以下为正文
----------------------------------------------------------------------
+所有你想知道的事情 - 关于linux稳定版发布
+========================================
 
 关于Linux 2.6稳定版发布，所有你想知道的事情。
 
 关于哪些类型的补丁可以被接收进入稳定版代码树，哪些不可以的规则：
+----------------------------------------------------------------
 
   - 必须是显而易见的正确，并且经过测试的。
   - 连同上下文，不能大于100行。
@@ -41,6 +36,7 @@ Documentation/process/stable-kernel-rules.rst 的中文翻译
   - 必须遵循Documentation/process/submitting-patches.rst里的规则。
 
 向稳定版代码树提交补丁的过程：
+------------------------------
 
   - 在确认了补丁符合以上的规则后，将补丁发送到stable@vger.kernel.org。
   - 如果补丁被接受到队列里，发送者会收到一个ACK回复，如果没有被接受，收
@@ -49,6 +45,7 @@ Documentation/process/stable-kernel-rules.rst 的中文翻译
   - 安全方面的补丁不要发到这个列表，应该发送到security@kernel.org。
 
 审查周期：
+----------
 
   - 当稳定版的维护者决定开始一个审查周期，补丁将被发送到审查委员会，以
     及被补丁影响的领域的维护者（除非提交者就是该领域的维护者）并且抄送
@@ -63,4 +60,5 @@ Documentation/process/stable-kernel-rules.rst 的中文翻译
     通常的审查周期。请联系内核安全小组以获得关于这个过程的更多细节。
 
 审查委员会：
+------------
   - 由一些自愿承担这项任务的内核开发者，和几个非志愿的组成。
-- 
2.19.1.856.g8858448bb

