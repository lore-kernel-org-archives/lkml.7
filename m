Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D088214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCLDEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:04:04 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60503 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbfCLDCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:02:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMW6jBd_1552359724;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMW6jBd_1552359724)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:02:05 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Bryan Wu <bryan.wu@analog.com>, Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v4 14/31] docs/zh_CN: volatile doc format changes
Date:   Tue, 12 Mar 2019 11:01:12 +0800
Message-Id: <20190312030129.47511-15-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
References: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make it readble as rst format for html etc doc making.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bryan Wu <bryan.wu@analog.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 .../process/volatile-considered-harmful.rst   | 35 ++++++++-----------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst b/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
index 475125967197..48b32ce58ef1 100644
--- a/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
@@ -1,30 +1,23 @@
-Chinese translated version of Documentation/process/volatile-considered-harmful.rst
+.. _cn_volatile_considered_harmful:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Maintainer: Jonathan Corbet <corbet@lwn.net>
-Chinese maintainer: Bryan Wu <bryan.wu@analog.com>
----------------------------------------------------------------------
-Documentation/process/volatile-considered-harmful.rst 的中文翻译
+:Original: :ref:`Documentation/process/volatile-considered-harmful.rst
+           <volatile_considered_harmful>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-英文版维护者： Jonathan Corbet <corbet@lwn.net>
-中文版维护者： 伍鹏  Bryan Wu <bryan.wu@analog.com>
-中文版翻译者： 伍鹏  Bryan Wu <bryan.wu@analog.com>
-中文版校译者： 张汉辉  Eugene Teo <eugeneteo@kernel.sg>
-               杨瑞  Dave Young <hidave.darkstar@gmail.com>
-以下为正文
----------------------------------------------------------------------
+        英文版维护者： Jonathan Corbet <corbet@lwn.net>
+        中文版维护者： 伍鹏  Bryan Wu <bryan.wu@analog.com>
+        中文版翻译者： 伍鹏  Bryan Wu <bryan.wu@analog.com>
+        中文版校译者： 张汉辉  Eugene Teo <eugeneteo@kernel.sg>
+                       杨瑞  Dave Young <hidave.darkstar@gmail.com>
+                       时奎亮 Alex Shi <alex.shi@linux.alibaba.com>
 
 为什么不应该使用“volatile”类型
-------------------------------
+==============================
 
 C程序员通常认为volatile表示某个变量可以在当前执行的线程之外被改变；因此，在内核
 中用到共享数据结构时，常常会有C程序员喜欢使用volatile这类变量。换句话说，他们经
@@ -41,7 +34,7 @@ C程序员通常认为volatile表示某个变量可以在当前执行的线程
 必要再使用volatile。如果仍然必须使用volatile，那么几乎可以肯定在代码的某处有一
 个bug。在正确设计的内核代码中，volatile能带来的仅仅是使事情变慢。
 
-思考一下这段典型的内核代码：
+思考一下这段典型的内核代码::
 
     spin_lock(&the_lock);
     do_something_on(&shared_data);
@@ -66,7 +59,7 @@ volatile的存储类型最初是为那些内存映射的I/O寄存器而定义。
 是必需的。
 
 另一种引起用户可能使用volatile的情况是当处理器正忙着等待一个变量的值。正确执行一
-个忙等待的方法是：
+个忙等待的方法是::
 
     while (my_variable != what_i_want)
         cpu_relax();
-- 
2.19.1.856.g8858448bb

