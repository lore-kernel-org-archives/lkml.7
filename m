Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73583C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85620643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCLD1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:27:32 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55517 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727012AbfCLDZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TMWPgeq_1552361134;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWPgeq_1552361134)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v4 12/31] docs/zh_CN: do rst format for email-clients.rst
Date:   Tue, 12 Mar 2019 11:24:41 +0800
Message-Id: <20190312032501.62056-13-alex.shi@linux.alibaba.com>
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

Make it readble as rst format.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/email-clients.rst           | 53 ++++++++-----------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/email-clients.rst b/Documentation/translations/zh_CN/process/email-clients.rst
index ec31d97e8d0e..e8641a5899e4 100644
--- a/Documentation/translations/zh_CN/process/email-clients.rst
+++ b/Documentation/translations/zh_CN/process/email-clients.rst
@@ -1,33 +1,24 @@
-﻿Chinese translated version of Documentation/process/email-clients.rst
+﻿.. _cn_email_clients:
 
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+.. include:: ../disclaimer-zh_CN.rst
 
-Chinese maintainer: Harry Wei <harryxiyou@gmail.com>
----------------------------------------------------------------------
-Documentation/process/email-clients.rst 的中文翻译
+:Original: :ref:`Documentation/process/email-clients.rst <email_clients>`
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
-译存在问题，请联系中文版维护者。
+译存在问题，请联系中文版维护者::
 
-中文版维护者： 贾威威  Harry Wei <harryxiyou@gmail.com>
-中文版翻译者： 贾威威  Harry Wei <harryxiyou@gmail.com>
-中文版校译者： Yinglin Luan <synmyth@gmail.com>
-		Xiaochen Wang <wangxiaochen0@gmail.com>
-		yaxinsn <yaxinsn@163.com>
-
-以下为正文
----------------------------------------------------------------------
+        中文版维护者： 贾威威  Harry Wei <harryxiyou@gmail.com>
+        中文版翻译者： 贾威威  Harry Wei <harryxiyou@gmail.com>
+        中文版校译者： Yinglin Luan <synmyth@gmail.com>
+        	       Xiaochen Wang <wangxiaochen0@gmail.com>
+                       yaxinsn <yaxinsn@163.com>
 
 Linux邮件客户端配置信息
-======================================================================
+=======================
 
 普通配置
-----------------------------------------------------------------------
+--------
 Linux内核补丁是通过邮件被提交的，最好把补丁作为邮件体的内嵌文本。有些维护者
 接收附件，但是附件的内容格式应该是"text/plain"。然而，附件一般是不赞成的，
 因为这会使补丁的引用部分在评论过程中变的很困难。
@@ -56,7 +47,7 @@ Linux内核补丁是通过邮件被提交的，最好把补丁作为邮件体的
 
 
 一些邮件客户端提示
-----------------------------------------------------------------------
+------------------
 这里给出一些详细的MUA配置提示，可以用于给Linux内核发送补丁。这些并不意味是
 所有的软件包配置总结。
 
@@ -64,8 +55,8 @@ Linux内核补丁是通过邮件被提交的，最好把补丁作为邮件体的
 TUI = 以文本为基础的用户接口
 GUI = 图形界面用户接口
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Alpine (TUI)
+~~~~~~~~~~~~
 
 配置选项：
 在"Sending Preferences"部分：
@@ -76,8 +67,8 @@ Alpine (TUI)
 当写邮件时，光标应该放在补丁会出现的地方，然后按下CTRL-R组合键，使指定的
 补丁文件嵌入到邮件中。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Evolution (GUI)
+~~~~~~~~~~~~~~~
 
 一些开发者成功的使用它发送补丁
 
@@ -89,8 +80,8 @@ Evolution (GUI)
 
 你还可以"diff -Nru old.c new.c | xclip"，选择Preformat，然后使用中间键进行粘帖。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Kmail (GUI)
+~~~~~~~~~~~
 
 一些开发者成功的使用它发送补丁。
 
@@ -118,13 +109,13 @@ display"，这样内嵌附件更容易让读者看到。
 并且希望这将会被处理。邮件是以只针对某个用户可读写的权限被保存的，所以如果你想把邮件复制到其他地方，
 你不得不把他们的权限改为组或者整体可读。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Lotus Notes (GUI)
+~~~~~~~~~~~~~~~~~
 
 不要使用它。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Mutt (TUI)
+~~~~~~~~~~
 
 很多Linux开发人员使用mutt客户端，所以证明它肯定工作的非常漂亮。
 
@@ -146,8 +137,8 @@ Mutt不自带编辑器，所以不管你使用什么编辑器都不应该带有
 它应该以默认设置的形式工作。
 然而，把"send_charset"设置为"us-ascii::utf-8"也是一个不错的主意。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Pine (TUI)
+~~~~~~~~~~
 
 Pine过去有一些空格删减问题，但是这些现在应该都被修复了。
 
@@ -158,8 +149,8 @@ Pine过去有一些空格删减问题，但是这些现在应该都被修复了
 - "no-strip-whitespace-before-send"选项也是需要的。
 
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Sylpheed (GUI)
+~~~~~~~~~~~~~~
 
 - 内嵌文本可以很好的工作（或者使用附件）。
 - 允许使用外部的编辑器。
@@ -168,8 +159,8 @@ Sylpheed (GUI)
 - 在组成窗口中有一个很有用的ruler bar。
 - 给地址本中添加地址就不会正确的了解显示名。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Thunderbird (GUI)
+~~~~~~~~~~~~~~~~~
 
 默认情况下，thunderbird很容易损坏文本，但是还有一些方法可以强制它变得更好。
 
@@ -191,13 +182,13 @@ Thunderbird (GUI)
   $EDITOR来读取或者合并补丁到文本中。要实现它，可以下载并且安装这个扩展，然后添加一个使用它的
   按键View->Toolbars->Customize...最后当你书写信息的时候仅仅点击它就可以了。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 TkRat (GUI)
+~~~~~~~~~~~
 
 可以使用它。使用"Insert file..."或者外部的编辑器。
 
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Gmail (Web GUI)
+~~~~~~~~~~~~~~~
 
 不要使用它发送补丁。
 
-- 
2.19.1.856.g8858448bb

