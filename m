Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F77C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAFA20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCEG7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:59:02 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40077 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbfCEG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:58:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TM.nNqN_1551769122;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM.nNqN_1551769122)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 14:58:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        harryxiyou@gmail.com, corbet@lwn.net, leoyang.li@nxp.com
Cc:     colyli@suse.de, fengguang.wu@intel.com, shawn.guo@linaro.org,
        lizefan@huawei.com, Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v2 20/27] docs/zh_CN: format stable-api-nonsense
Date:   Tue,  5 Mar 2019 14:58:07 +0800
Message-Id: <20190305065815.157964-21-alex.shi@linux.alibaba.com>
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

to make it follow rst format and readble in html etc doc making.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: TripleX Chung <xxx.phy@gmail.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 .../zh_CN/process/stable-api-nonsense.rst     | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
index a2b27fab382c..e97bcf5c44ce 100644
--- a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
@@ -1,26 +1,21 @@
-Chinese translated version of Documentation/process/stable-api-nonsense.rst
+.. _cn_stable_api_nonsense:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have problem
-communicating in English you can also ask the Chinese maintainer for help.
-Contact the Chinese maintainer, if this translation is outdated or there
-is problem with translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Maintainer: Greg Kroah-Hartman <greg@kroah.com>
-Chinese maintainer: TripleX Chung <zhongyu@18mail.cn>
----------------------------------------------------------------------
-Documentation/process/stable-api-nonsense.rst 的中文翻译
+:Original: :ref:`Documentation/process/stable-api-nonsense.rst
+           <stable_api_nonsense>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
-中文版维护者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
-中文版翻译者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
-中文版校译者： 李阳  Li Yang <leoli@freescale.com>
-以下为正文
----------------------------------------------------------------------
+        英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
+        中文版维护者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
+        中文版翻译者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
+        中文版校译者： 李阳  Li Yang <leoli@freescale.com>
+
+Linux 内核驱动接口
+==================
 
 写作本文档的目的，是为了解释为什么Linux既没有二进制内核接口，也没有稳定
 的内核接口。这里所说的内核接口，是指内核里的接口，而不是内核和用户空间
@@ -124,7 +119,7 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 
 
 要做什么
--------
+--------
 
 如果你写了一个Linux内核驱动，但是它还不在Linux源代码树里，作为一个开发
 者，你应该怎么做？为每个发布的每个版本提供一个二进制驱动，那简直是一个
@@ -150,7 +145,8 @@ Linux能成为强壮，稳定，成熟的操作系统，这也是你最开始选
 同体系结构的处理器上支持这些设备。这个经过考验的开发模式，必然是错不了
 的 :)
 
--------------
+感谢
+----
 感谢 Randy Dunlap, Andrew Morton, David Brownell, Hanna Linder,
 Robert Love, and Nishanth Aravamudan 对于本文档早期版本的评审和建议。
 
-- 
2.19.1.856.g8858448bb

