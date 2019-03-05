Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8987EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572F52082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 06:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCEG7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:59:13 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46845 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727233AbfCEG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:59:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TM.bthj_1551769123;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM.bthj_1551769123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 14:58:43 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        harryxiyou@gmail.com, corbet@lwn.net, leoyang.li@nxp.com
Cc:     colyli@suse.de, fengguang.wu@intel.com, shawn.guo@linaro.org,
        lizefan@huawei.com, Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v2 21/27] docs/zh_CN: update Li Yang's email address
Date:   Tue,  5 Mar 2019 14:58:08 +0800
Message-Id: <20190305065815.157964-22-alex.shi@linux.alibaba.com>
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

Change leoli@freescale.com and leo@zh-kernel.org to active address:
leoyang.li@nxp.com

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Li Yang <leoyang.li@nxp.com>
---
 Documentation/translations/zh_CN/oops-tracing.txt           | 2 +-
 Documentation/translations/zh_CN/process/howto.rst          | 4 ++--
 .../translations/zh_CN/process/stable-api-nonsense.rst      | 2 +-
 .../translations/zh_CN/process/stable-kernel-rules.rst      | 2 +-
 .../translations/zh_CN/process/submitting-drivers.rst       | 4 ++--
 .../translations/zh_CN/process/submitting-patches.rst       | 2 +-
 Documentation/translations/zh_CN/sparse.txt                 | 6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/translations/zh_CN/oops-tracing.txt b/Documentation/translations/zh_CN/oops-tracing.txt
index a893f04dfd5d..93fa061cf9e4 100644
--- a/Documentation/translations/zh_CN/oops-tracing.txt
+++ b/Documentation/translations/zh_CN/oops-tracing.txt
@@ -16,7 +16,7 @@ Documentation/admin-guide/bug-hunting.rst 的中文翻译
 
 中文版维护者： 杨瑞 Dave Young <hidave.darkstar@gmail.com>
 中文版翻译者： 杨瑞 Dave Young <hidave.darkstar@gmail.com>
-中文版校译者： 李阳 Li Yang <leo@zh-kernel.org>
+中文版校译者： 李阳 Li Yang <leoyang.li@nxp.com>
                王聪 Wang Cong <xiyou.wangcong@gmail.com>
 
 以下为正文
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index e4e800591ae9..22708f9f6078 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -9,8 +9,8 @@
 译存在问题，请联系中文版维护者::
 
     英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
-    中文版维护者： 李阳  Li Yang <leoli@freescale.com>
-    中文版翻译者： 李阳  Li Yang <leoli@freescale.com>
+    中文版维护者： 李阳  Li Yang <leoyang.li@nxp.com>
+    中文版翻译者： 李阳  Li Yang <leoyang.li@nxp.com>
     中文版校译者:
                    钟宇  TripleX Chung <xxx.phy@gmail.com>
                    陈琦  Maggie Chen <chenqi@beyondsoft.com>
diff --git a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
index e97bcf5c44ce..f11829429000 100644
--- a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
@@ -12,7 +12,7 @@
         英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
         中文版维护者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
         中文版翻译者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
-        中文版校译者： 李阳  Li Yang <leoli@freescale.com>
+        中文版校译者： 李阳  Li Yang <leoyang.li@nxp.com>
 
 Linux 内核驱动接口
 ==================
diff --git a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
index 425d06f99ac2..3d5a10dfc1ae 100644
--- a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
@@ -11,7 +11,7 @@
         中文版维护者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
         中文版翻译者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
         中文版校译者：
-            - 李阳  Li Yang <leo@zh-kernel.org>
+            - 李阳  Li Yang <leoyang.li@nxp.com>
             - Kangkai Yin <e12051@motorola.com>
 
 所有你想知道的事情 - 关于linux稳定版发布
diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index c90ab5ae233d..fade72515b04 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -9,8 +9,8 @@
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
 译存在问题，请联系中文版维护者::
 
-        中文版维护者： 李阳  Li Yang <leo@zh-kernel.org>
-        中文版翻译者： 李阳  Li Yang <leo@zh-kernel.org>
+        中文版维护者： 李阳  Li Yang <leoyang.li@nxp.com>
+        中文版翻译者： 李阳  Li Yang <leoyang.li@nxp.com>
         中文版校译者： 陈琦 Maggie Chen <chenqi@beyondsoft.com>
                        王聪 Wang Cong <xiyou.wangcong@gmail.com>
                        张巍 Zhang Wei <Wei.Zhang@freescale.com>
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 2a2989733c8d..54d2d45e27df 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -10,7 +10,7 @@
 
         中文版维护者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
         中文版翻译者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
-        中文版校译者： 李阳 Li Yang <leo@zh-kernel.org>
+        中文版校译者： 李阳 Li Yang <leoyang.li@nxp.com>
                        王聪 Wang Cong <xiyou.wangcong@gmail.com>
 
 
diff --git a/Documentation/translations/zh_CN/sparse.txt b/Documentation/translations/zh_CN/sparse.txt
index 2f728962a8e2..47fc4a06ebe8 100644
--- a/Documentation/translations/zh_CN/sparse.txt
+++ b/Documentation/translations/zh_CN/sparse.txt
@@ -6,7 +6,7 @@ communicating in English you can also ask the Chinese maintainer for
 help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
-Chinese maintainer: Li Yang <leo@zh-kernel.org>
+Chinese maintainer: Li Yang <leoyang.li@nxp.com>
 ---------------------------------------------------------------------
 Documentation/dev-tools/sparse.rst 的中文翻译
 
@@ -14,8 +14,8 @@ Documentation/dev-tools/sparse.rst 的中文翻译
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
 译存在问题，请联系中文版维护者。
 
-中文版维护者： 李阳  Li Yang <leo@zh-kernel.org>
-中文版翻译者： 李阳  Li Yang <leo@zh-kernel.org>
+中文版维护者： 李阳  Li Yang <leoyang.li@nxp.com>
+中文版翻译者： 李阳  Li Yang <leoyang.li@nxp.com>
 
 
 以下为正文
-- 
2.19.1.856.g8858448bb

