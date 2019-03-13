Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65537C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1802087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfCMNux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:50:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60335 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfCMNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMdUTbH_1552485026;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdUTbH_1552485026)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:27 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Yang <leoyang.li@nxp.com>, Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v5 16/31] docs/zh_CN: format submitting drivers as rst
Date:   Wed, 13 Mar 2019 21:49:46 +0800
Message-Id: <20190313135001.260905-17-alex.shi@linux.alibaba.com>
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

to Make it readble for html etc docs making.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/submitting-drivers.rst      | 30 +++++++------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index 15e73562f710..c90ab5ae233d 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -1,30 +1,22 @@
-﻿Chinese translated version of Documentation/process/submitting-drivers.rst
+﻿.. _cn_submittingdrivers:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Chinese maintainer: Li Yang <leo@zh-kernel.org>
----------------------------------------------------------------------
-Documentation/process/submitting-drivers.rst 的中文翻译
+:Original: :ref:`Documentation/process/submitting-drivers.rst
+           <submittingdrivers>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-中文版维护者： 李阳  Li Yang <leo@zh-kernel.org>
-中文版翻译者： 李阳  Li Yang <leo@zh-kernel.org>
-中文版校译者： 陈琦 Maggie Chen <chenqi@beyondsoft.com>
-               王聪 Wang Cong <xiyou.wangcong@gmail.com>
-               张巍 Zhang Wei <Wei.Zhang@freescale.com>
-
-以下为正文
----------------------------------------------------------------------
+        中文版维护者： 李阳  Li Yang <leo@zh-kernel.org>
+        中文版翻译者： 李阳  Li Yang <leo@zh-kernel.org>
+        中文版校译者： 陈琦 Maggie Chen <chenqi@beyondsoft.com>
+                       王聪 Wang Cong <xiyou.wangcong@gmail.com>
+                       张巍 Zhang Wei <Wei.Zhang@freescale.com>
 
 如何向 Linux 内核提交驱动程序
------------------------------
+=============================
 
 这篇文档将会解释如何向不同的内核源码树提交设备驱动程序。请注意，如果你感
 兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(http://www.xfree86.org/)
-- 
2.19.1.856.g8858448bb

