Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55BDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52DA2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfC0NCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:02:39 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43817 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730070AbfC0NCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmpMYo_1553691748;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmpMYo_1553691748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 30/42] docs/zh_CN: add CoC interpretation
Date:   Wed, 27 Mar 2019 21:01:36 +0800
Message-Id: <20190327130148.3258-31-alex.shi@linux.alibaba.com>
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

Translated CoC interpretation into Chinese

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../code-of-conduct-interpretation.rst        | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst

diff --git a/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
new file mode 100644
index 000000000000..39743a0ed0d3
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
@@ -0,0 +1,103 @@
+.. _cn_code_of_conduct_interpretation:
+
+Linux内核贡献者契约行为准则解释
+===============================
+
+:ref:`code_of_conduct` 准则是一个通用文档，旨在为几乎所有开源社区提供一套规则。
+每个开源社区都是独一无二的，Linux内核也不例外。因此，本文描述了Linux内核社区中
+如何解释它。我们也不希望这种解释随着时间的推移是静态的，并将根据需要进行调整。
+
+与开发软件的“传统”方法相比，Linux内核开发工作是一个非常个人化的过程。你的贡献
+和背后的想法将被仔细审查，往往导致批判和批评。审查将几乎总是需要改进，材料才
+能包括在内核中。要知道这是因为所有相关人员都希望看到Linux整体成功的最佳解决方
+案。这个开发过程已经被证明可以创建有史以来最健壮的操作系统内核，我们不想做任何
+事情来导致提交质量和最终结果的下降。
+
+维护者
+------
+
+行为准则多次使用“维护者”一词。在内核社区中，“维护者”是负责子系统、驱动程序或
+文件的任何人，并在内核源代码树的维护者文件中列出。
+
+责任
+----
+
+《行为准则》提到了维护人员的权利和责任，这需要进一步澄清。
+
+首先，最重要的是，有一个合理的期望是由维护人员通过实例来领导。
+
+也就是说，我们的社区是广阔的，对维护者没有新的要求，他们单方面处理其他人在
+他们活跃的社区的行为。这一责任由我们所有人承担，最终《行为准则》记录了最终的
+上诉路径，以防有关行为问题的问题悬而未决。
+
+维护人员应该愿意在出现问题时提供帮助，并在需要时与社区中的其他人合作。如果您
+不确定如何处理出现的情况，请不要害怕联系技术咨询委员会（TAB）或其他维护人员。
+除非您愿意，否则不会将其视为违规报告。如果您不确定是否该联系TAB 或任何其他维
+护人员，请联系我们的冲突调解人 Mishi Choudhary <mishi@linux.com>。
+
+最后，“善待对方”才是每个人的最终目标。我们知道每个人都是人，有时我们都会失败，
+但我们所有人的首要目标应该是努力友好地解决问题。执行行为准则将是最后的选择。
+
+我们的目标是创建一个强大的、技术先进的操作系统，以及所涉及的技术复杂性，这自
+然需要专业知识和决策。
+
+所需的专业知识因贡献领域而异。它主要由上下文和技术复杂性决定，其次由贡献者和
+维护者的期望决定。
+
+专家的期望和决策都要经过讨论，但在最后，为了取得进展，必须能够做出决策。这一
+特权掌握在维护人员和项目领导的手中，预计将善意使用。
+
+因此，设定专业知识期望、作出决定和拒绝不适当的贡献不被视为违反行为准则。
+
+虽然维护人员一般都欢迎新来者，但他们帮助（新）贡献者克服障碍的能力有限，因此
+他们必须确定优先事项。这也不应被视为违反了行为准则。内核社区意识到这一点，并
+以各种形式提供入门级节目，如 kernelnewbies.org 。
+
+范围
+----
+
+Linux内核社区主要在一组公共电子邮件列表上进行交互，这些列表分布在由多个不同
+公司或个人控制的多个不同服务器上。所有这些列表都在内核源代码树中的
+MAINTAINERS 文件中定义。发送到这些邮件列表的任何电子邮件都被视为包含在行为
+准则中。
+
+使用 kernel.org bugzilla和其他子系统bugzilla 或bug跟踪工具的开发人员应该遵循
+行为准则的指导原则。Linux内核社区没有“官方”项目电子邮件地址或“官方”社交媒体
+地址。使用kernel.org电子邮件帐户执行的任何活动必须遵循为kernel.org发布的行为
+准则，就像任何使用公司电子邮件帐户的个人必须遵循该公司的特定规则一样。
+
+行为准则并不禁止在邮件列表消息、内核更改日志消息或代码注释中继续包含名称、
+电子邮件地址和相关注释。
+
+其他论坛中的互动包括在适用于上述论坛的任何规则中，通常不包括在行为准则中。
+除了在极端情况下可考虑的例外情况。
+
+提交给内核的贡献应该使用适当的语言。在行为准则之前已经存在的内容现在不会被
+视为违反。然而，不适当的语言可以被视为一个bug；如果任何相关方提交补丁，
+这样的bug将被更快地修复。当前属于用户/内核API的一部分的表达式，或者反映已
+发布标准或规范中使用的术语的表达式，不被视为bug。
+
+执行
+----
+
+行为准则中列出的地址属于行为准则委员会。https://kernel.org/code-of-conduct.html
+列出了在任何给定时间接收这些电子邮件的确切成员。成员不能访问在加入委员会之前
+或离开委员会之后所做的报告。
+
+最初的行为准则委员会由TAB的志愿者以及作为中立第三方的专业调解人组成。委员会
+的首要任务是建立文件化的流程，并将其公开。
+
+如果报告人不希望将整个委员会纳入投诉或关切，可直接联系委员会的任何成员，包括
+调解人。
+
+行为准则委员会根据流程审查案例（见上文），并根据需要和适当与TAB协商，例如请求
+和接收有关内核社区的信息。
+
+委员会做出的任何决定都将提交到表中，以便在必要时与相关维护人员一起执行。行为
+准则委员会的决定可以通过三分之二的投票推翻。
+
+每季度，行为准则委员会和标签将提供一份报告，概述行为准则委员会收到的匿名报告
+及其状态，以及任何否决决定的细节，包括完整和可识别的投票细节。
+
+我们希望在启动期之后为行为准则委员会人员配备建立一个不同的流程。发生此情况时，
+将使用该信息更新此文档。
-- 
2.19.1.856.g8858448bb

