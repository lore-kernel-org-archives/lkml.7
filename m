Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EE52146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfC0NCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:02:49 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:51555 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730457AbfC0NCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmL6qF_1553691751;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmL6qF_1553691751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 37/42] docs/zh_CN: redirect howto.rst link to Chinese version
Date:   Wed, 27 Mar 2019 21:01:43 +0800
Message-Id: <20190327130148.3258-38-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
References: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The howto doc is translated from latest version. Now it's time to
point the link to it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/8.Conclusion.rst     | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
index 32b4e617a451..c164edc34687 100644
--- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -9,12 +9,13 @@
 ========
 
 关于Linux内核开发和相关主题的信息来源很多。首先是在内核源代码分发中找到的
-文档目录。顶级:ref:`process/howto.rst <process_howto>` 文件是一个重要的起点
-:ref:`process/submitting-patches.rst <submittingpatches>` 和
-:ref:`process/submitting-drivers.rst <submittingdrivers>` 也是所有内核开发
-人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制记录的；
-“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档（尽管某些
-发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
+文档目录。顶级 :ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
+文件是一个重要的起点
+:ref:`process/submitting-patches.rst <submittingpatches>`
+和:ref:`process/submitting-drivers.rst <submittingdrivers>`
+也是所有内核开发人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制
+记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档（
+尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
 
 不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用http://lwn.net/
 作为来源；有关许多特定内核主题的信息可以通过以下网址的lwn内核索引找到：
-- 
2.19.1.856.g8858448bb

