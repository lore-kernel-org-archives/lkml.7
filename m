Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DAFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B46206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfC0NDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:03:34 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49704 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731513AbfC0NDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:03:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TNmt4bn_1553691753;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmt4bn_1553691753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        James Morris <james.morris@microsoft.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 40/42] docs/zh_CN: redirect the submitting-patches to Chinese doc
Date:   Wed, 27 Mar 2019 21:01:46 +0800
Message-Id: <20190327130148.3258-41-alex.shi@linux.alibaba.com>
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

Now we have latest Chinese version submitting-patches.rst, it's time to
use it in other docs.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: James Morris <james.morris@microsoft.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/5.Posting.rst          | 11 ++++++-----
 .../translations/zh_CN/process/8.Conclusion.rst       |  6 +++---
 Documentation/translations/zh_CN/process/howto.rst    |  4 ++--
 .../zh_CN/process/stable-kernel-rules.rst             |  2 +-
 .../translations/zh_CN/process/submit-checklist.rst   |  2 +-
 .../translations/zh_CN/process/submitting-drivers.rst |  2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/5.Posting.rst b/Documentation/translations/zh_CN/process/5.Posting.rst
index 425b805c85a1..66b33fe58f3d 100644
--- a/Documentation/translations/zh_CN/process/5.Posting.rst
+++ b/Documentation/translations/zh_CN/process/5.Posting.rst
@@ -12,7 +12,7 @@
 内核开发社区已经发展出一套用于发布补丁的约定和过程；遵循这些约定和过程将使
 参与其中的每个人的生活更加轻松。本文件将试图合理详细地涵盖这些期望；更多信息
 也可在以下文件中找到
-:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`,
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`,
 :ref:`Documentation/process/submitting-drivers.rst  <submittingdrivers>`
 和 :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
 
@@ -145,7 +145,7 @@ bug搜寻人员想知道补丁是否负责他们正在追查的问题，想知
 其传递给diff。
 
 上面提到的标签用于描述各种开发人员如何与这个补丁的开发相关联。
-:ref:`documentation/process/submitting-patches.rst <submittingpatches>`
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 文档中对它们进行了详细描述；下面是一个简短的总结。每一行的格式如下：
 
 ::
@@ -155,7 +155,8 @@ bug搜寻人员想知道补丁是否负责他们正在追查的问题，想知
 常用的标签有：
 
  - Signed-off-by: 这是一个开发人员的证明，他或她有权提交补丁以包含到内核中。
-   这是开发来源认证协议，其全文可在:ref:`documentation/process/submitting-patches.rst <submittingpatches>`
+   这是开发来源认证协议，其全文可在
+   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
    中找到，如果没有适当的签字，则不能合并到主线中。
 
  - Co-developed-by: 声明补丁也是由另一个开发人员和原始作者一起创建的。当多
@@ -167,7 +168,7 @@ bug搜寻人员想知道补丁是否负责他们正在追查的问题，想知
  - Tested-by: 声明指定的人已经测试了补丁并发现它可以工作。
 
  - Reviewed-by: 指定的开发人员已经审查了补丁的正确性；有关详细信息，请参阅
-   :ref:`documentation/process/submitting-patches.rst <submittingpatches>`
+   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 
  - Reported-by: 指定报告此修补程序修复的问题的用户；此标记用于提供感谢。
 
@@ -209,7 +210,7 @@ bug搜寻人员想知道补丁是否负责他们正在追查的问题，想知
  - 将副本发送到相关邮件列表，或者，如果没有其他应用，则发送到Linux内核列表。
 
  - 如果您正在修复一个bug，请考虑该修复是否应进入下一个稳定更新。如果是这样，
-   stable@vger.kernel.org应该得到补丁的副本。另外，在补丁本身的标签中添加
+   stable@vger.kernel.org 应该得到补丁的副本。另外，在补丁本身的标签中添加
    一个“cc:stable@vger.kernel.org”；这将使稳定团队在修复进入主线时收到通知。
 
 当为一个补丁选择接收者时，最好知道你认为谁最终会接受这个补丁并将其合并。虽然
diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
index c164edc34687..2bbd76161e10 100644
--- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -11,13 +11,13 @@
 关于Linux内核开发和相关主题的信息来源很多。首先是在内核源代码分发中找到的
 文档目录。顶级 :ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
 文件是一个重要的起点
-:ref:`process/submitting-patches.rst <submittingpatches>`
-和:ref:`process/submitting-drivers.rst <submittingdrivers>`
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
+和 :ref:`process/submitting-drivers.rst <submittingdrivers>`
 也是所有内核开发人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制
 记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档（
 尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
 
-不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用http://lwn.net/
+不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用 http://lwn.net/
 作为来源；有关许多特定内核主题的信息可以通过以下网址的lwn内核索引找到：
 
         http://lwn.net/kernel/index/
diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index c876c3ad7f4b..83429c9cbcf4 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -95,7 +95,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     范。大多数维护者只会接收符合规定的补丁，很多人也只会帮忙检查符合风格
     的代码。
 
-  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+  :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
   :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
 
     这两份文档明确描述如何创建和发送补丁，其中包括（但不仅限于)：
@@ -328,7 +328,7 @@ MAINTAINERS文件中可以找到不同话题对应的邮件列表。
 这几行。将你的评论加在被引用的段落之间而不要放在邮件的顶部。
 
 如果你在邮件中附带补丁，请确认它们是可以直接阅读的纯文本（如
-:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 文档中所述）。内核开发者们不希望遇到附件或者被压缩了的补丁。只有这样才能
 保证他们可以直接评论你的每行代码。请确保你使用的邮件发送程序不会修改空格
 和制表符。一个防范性的测试方法是先将邮件发送给自己，然后自己尝试是否可以
diff --git a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
index fb048c42ae48..fba361f2ddfd 100644
--- a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
@@ -33,7 +33,7 @@
   - 没有“理论上的竞争条件”，除非能给出竞争条件如何被利用的解释。
   - 不能存在任何的“琐碎的”修正（拼写修正，去掉多余空格之类的）。
   - 必须被相关子系统的维护者接受。
-  - 必须遵循Documentation/process/submitting-patches.rst里的规则。
+  - 必须遵循Documentation/translations/zh_CN/process/submitting-patches.rst里的规则。
 
 向稳定版代码树提交补丁的过程：
 ------------------------------
diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
index 9ee1cb4cdab6..c931273e1487 100644
--- a/Documentation/translations/zh_CN/process/submit-checklist.rst
+++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
@@ -12,7 +12,7 @@ Linux内核补丁提交清单
 的事情。
 
 这些都是在
-:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+:ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 和其他有关提交Linux内核补丁的文档中提供的。
 
 1) 如果使用工具，则包括定义/声明该工具的文件。不要依赖于其他头文件拉入您使用
diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index 3be51d998c80..72c6cd935821 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -22,7 +22,7 @@
 兴趣的是显卡驱动程序，你也许应该访问 XFree86 项目(http://www.xfree86.org/)
 和／或 X.org 项目 (http://x.org)。
 
-另请参阅 Documentation/process/submitting-patches.rst 文档。
+另请参阅 Documentation/Documentation/translations/zh_CN/process/submitting-patches.rst 文档。
 
 
 分配设备号
-- 
2.19.1.856.g8858448bb

