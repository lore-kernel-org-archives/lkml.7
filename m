Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF22084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfCLD0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:26:40 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34427 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbfCLDZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMW6nUd_1552361148;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMW6nUd_1552361148)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Yang <leoyang.li@nxp.com>, TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v4 31/31] docs/zh_CN: fix rst format issue in submitting-patch
Date:   Tue, 12 Mar 2019 11:25:00 +0800
Message-Id: <20190312032501.62056-32-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tame 'make htmldocs' to avoid indent and code section
error complains.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: TripleX Chung <xxx.phy@gmail.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/submitting-patches.rst      | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 47cdca62cfa2..66c64acf86c1 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -39,7 +39,7 @@ Documentation/process/submitting-drivers.rst 。
 参数生成。而且，请使用 '-p' 参数，那样会显示每个改动所在的C函数，使得
 产生的补丁容易读得多。补丁应该基于内核源代码树的根目录，而不是里边的任
 何子目录。
-为一个单独的文件创建补丁，一般来说这样做就够了：
+为一个单独的文件创建补丁，一般来说这样做就够了::
 
         SRCTREE= linux-2.6
         MYFILE=  drivers/net/mydriver.c
@@ -51,7 +51,7 @@ Documentation/process/submitting-drivers.rst 。
         diff -up $SRCTREE/$MYFILE{.orig,} > /tmp/patch
 
 为多个文件创建补丁，你可以解开一个没有修改过的内核源代码树，然后和你自
-己的代码树之间做 diff 。例如：
+己的代码树之间做 diff 。例如::
 
         MYSRC= /devel/linux-2.6
 
@@ -141,6 +141,7 @@ MAINTAINERS 文件里的）发送一个手册页（man-pages）补丁，或者
 对于小的补丁，你也许会CC到 Adrian Bunk 管理的搜集琐碎补丁的邮件列表
 (Trivial Patch Monkey)trivial@kernel.org，那里专门收集琐碎的补丁。下面这样
 的补丁会被看作“琐碎的”补丁：
+
   文档的拼写修正。
   修正会影响到 grep(1) 的拼写。
   警告信息修正(频繁的打印无用的警告是不好的。)
@@ -241,8 +242,10 @@ Linus 和 linux-kernel 邮件列表的 e-mail 流量都很高，一个通常的
 "sign-off" 是在补丁的注释的最后的简单的一行文字，认证你编写了它或者其他
 人有权力将它作为开放源代码的补丁传递。规则很简单：如果你能认证如下信息
 ：
-      开发者来源证书 1.1
-      对于本项目的贡献，我认证如下信息：
+开发者来源证书 1.1
+^^^^^^^^^^^^^^^^^^
+对于本项目的贡献，我认证如下信息：
+
       （a）这些贡献是完全或者部分的由我创建，我有权利以文件中指出
        的开放源代码许可证提交它；或者
       （b）这些贡献基于以前的工作，据我所知，这些以前的工作受恰当的开放
@@ -295,7 +298,7 @@ e-mail 标题中的“一句话概述”扼要的描述 e-mail 中的补丁。
 丁。用户将希望通过 google 来搜索"一句话概述"来找到那些讨论这个补丁的文
 章。
 
-一些标题的例子：
+一些标题的例子::
 
     Subject: [patch 2/5] ext2: improve scalability of bitmap searching
     Subject: [PATCHv2 001/207] x86: fix eflags tracking
@@ -338,7 +341,7 @@ Nuff 说过，如果你的代码和这个偏离太多，那么它有可能会被
 在头文件里，有条件地定义 "static inline" 函数，或者宏，在代码里用这些东
 西。让编译器把那些"空操作"优化掉。
 
-一个简单的例子，不好的代码：
+一个简单的例子，不好的代码::
 
     dev = alloc_etherdev (sizeof(struct funky_private));
     if (!dev)
@@ -349,12 +352,14 @@ Nuff 说过，如果你的代码和这个偏离太多，那么它有可能会被
 
 清理后的例子:
 
-(头文件里)
+(头文件里)::
+
     #ifndef CONFIG_NET_FUNKINESS
     static inline void init_funky_net (struct net_device *d) {}
     #endif
 
-(代码文件里)
+(代码文件里)::
+
     dev = alloc_etherdev (sizeof(struct funky_private));
     if (!dev)
         return -ENODEV;
@@ -399,4 +404,3 @@ Kernel Documentation/process/coding-style.rst:
 
 Linus Torvalds's mail on the canonical patch format:
   <http://lkml.org/lkml/2005/4/7/183>
---
-- 
2.19.1.856.g8858448bb

