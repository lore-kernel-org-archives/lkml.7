Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69239C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424722146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfC0NE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:04:57 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42631 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730060AbfC0NCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmL6oa_1553691745;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmL6oa_1553691745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 21/42] docs/zh_CN: fix links failure in license-rules
Date:   Wed, 27 Mar 2019 21:01:27 +0800
Message-Id: <20190327130148.3258-22-alex.shi@linux.alibaba.com>
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

rST doc uses backquote `` to mark a link, which need a space before
and after the backquote sign in Chinese docs. Otherwise the link will be
translated as common context.

Use this patch to highlight this request.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/license-rules.rst   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/license-rules.rst b/Documentation/translations/zh_CN/process/license-rules.rst
index f70c8a238c3d..17ccba78962d 100644
--- a/Documentation/translations/zh_CN/process/license-rules.rst
+++ b/Documentation/translations/zh_CN/process/license-rules.rst
@@ -97,7 +97,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
       // SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
 
    例外只能与特定的许可证标识符一起使用。有效的许可证标识符列在异常文本文件
-   的标记中。有关详细信息，请参阅“许可证标识符”_一章中的“例外”
+   的标记中。有关详细信息，请参阅 `许可标识符`_ 一章中的 `例外`_ 。
 
    如果文件是双重许可且只选择一个许可证，则应使用OR。例如，一些dtsi文件在双
    许可下可用::
@@ -135,7 +135,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
 
       LICENSES/preferred/
 
-   此目录中的文件包含完整的许可证文本和`元标记`_。文件名与SPDX许可证标识
+   此目录中的文件包含完整的许可证文本和 `元标记`_ 。文件名与SPDX许可证标识
    符相同，后者应用于源文件中的许可证。
 
    例如::
@@ -165,7 +165,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
    - Usage-Guidance:
 
      使用建议的自由格式文本。该文本必须包含SPDX许可证标识符的正确示例，因为
-     它们应根据`许可标识符语法`_ 指南放入源文件中。
+     它们应根据 `许可标识符语法`_ 指南放入源文件中。
 
    - License-Text:
 
@@ -207,7 +207,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
 
       LICENSES/other/
 
-   此目录中的文件包含完整的许可证文本和`元标记`_。文件名与SPDX许可证标识
+   此目录中的文件包含完整的许可证文本和 `元标记`_ 。文件名与SPDX许可证标识
    符相同，后者应用于源文件中的许可证。
 
    例如::
@@ -222,7 +222,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
 
    元标签:
 
-   “其他”许可证的元标签要求与`优先许可`_的要求相同。
+   “其他”许可证的元标签要求与 `优先许可`_ 的要求相同。
 
    文件格式示例::
 
@@ -248,7 +248,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
 
       LICENSES/exceptions/
 
-   此目录中的文件包含完整的例外文本和所需的`例外元标记`_.
+   此目录中的文件包含完整的例外文本和所需的 `例外元标记`_ 。
 
    例如::
 
@@ -281,7 +281,7 @@ https://spdx.org/licenses/ 上的官方SPDX许可证列表中检索，并附带
    - Usage-Guidance:
 
      使用建议的自由格式文本。必须在文本后面加上SPDX许可证标识符的正确示例，
-     因为它们应根据`License identifier syntax`_指南放入源文件中。
+     因为它们应根据 `许可标识符语法`_ 指南放入源文件中。
 
    - Exception-Text:
 
-- 
2.19.1.856.g8858448bb

