Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E032206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfC0NDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:03:36 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37633 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730026AbfC0NDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:03:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmpMYd_1553691747;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmpMYd_1553691747)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:27 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 27/42] docs/zh_CN: add CoC doc
Date:   Wed, 27 Mar 2019 21:01:33 +0800
Message-Id: <20190327130148.3258-28-alex.shi@linux.alibaba.com>
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

Translated code-of-conduct doc in Chinese.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/code-of-conduct.rst         | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/code-of-conduct.rst

diff --git a/Documentation/translations/zh_CN/process/code-of-conduct.rst b/Documentation/translations/zh_CN/process/code-of-conduct.rst
new file mode 100644
index 000000000000..bfa03a3a3720
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/code-of-conduct.rst
@@ -0,0 +1,67 @@
+.. _cn_code_of_conduct:
+
+贡献者契约行为准则
+++++++++++++++++++
+
+我们的誓言
+==========
+
+为了营造一个开放、友好的环境，我们作为贡献者和维护人承诺，让我们的社区和参
+与者，拥有一个无骚扰的体验，无论年龄、体型、残疾、种族、性别特征、性别认同
+和表达、经验水平、教育程度、社会状况，经济地位、国籍、个人外貌、种族、宗教
+或性身份和取向。
+
+我们的标准
+==========
+
+有助于创造积极环境的行为包括：
+
+* 使用欢迎和包容的语言
+* 尊重不同的观点和经验
+* 优雅地接受建设性的批评
+* 关注什么对社区最有利
+* 对其他社区成员表示同情
+
+参与者的不可接受行为包括：
+
+* 使用性意味的语言或意象以及不受欢迎的性注意或者更过分的行为
+* 煽动、侮辱/贬损评论以及个人或政治攻击
+* 公开或私下骚扰
+* 未经明确许可，发布他人的私人信息，如物理或电子地址。
+* 在专业场合被合理认为不适当的其他行为
+
+我们的责任
+==========
+
+维护人员负责澄清可接受行为的标准，并应针对任何不可接受行为采取适当和公平的
+纠正措施。
+
+维护人员有权和责任删除、编辑或拒绝与本行为准则不一致的评论、承诺、代码、
+wiki编辑、问题和其他贡献，或暂时或永久禁止任何贡献者从事他们认为不适当、
+威胁、冒犯或有害的其他行为。
+
+范围
+====
+
+当个人代表项目或其社区时，本行为准则既适用于项目空间，也适用于公共空间。
+代表一个项目或社区的例子包括使用一个正式的项目电子邮件地址，通过一个正式
+的社交媒体帐户发布，或者在在线或离线事件中担任指定的代表。项目维护人员可以
+进一步定义和澄清项目的表示。
+
+执行
+====
+
+如有滥用、骚扰或其他不可接受的行为，可联系行为准则委员会<conduct@kernel.org>。
+所有投诉都将接受审查和调查，并将得到必要和适当的答复。行为准则委员会有义务
+对事件报告人保密。具体执行政策的进一步细节可单独公布。
+
+归属
+====
+
+本行为准则改编自《贡献者契约》，版本1.4，可从
+https://www.contributor-covenant.org/version/1/4/code-of-conduct.html 获取。
+
+解释
+====
+
+有关Linux内核社区如何解释此文档，请参阅 :ref:`code_of_conduct_interpretation`
-- 
2.19.1.856.g8858448bb

