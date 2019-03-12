Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4FDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5323F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCLDCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:02:08 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58105 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfCLDCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:02:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TMWPcOD_1552359717;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWPcOD_1552359717)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:01:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v4 04/31] docs/zh_CN: add index file into process dir
Date:   Tue, 12 Mar 2019 11:01:02 +0800
Message-Id: <20190312030129.47511-5-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
References: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 .../translations/zh_CN/process/index.rst      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/index.rst

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
new file mode 100644
index 000000000000..03939e1a7b92
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -0,0 +1,53 @@
+.. raw:: latex
+
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/process/index.rst <process_index>`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
+.. _cn_process_index:
+
+与Linux 内核社区一起工作
+========================
+
+那么你想成为Linux内核开发人员？ 欢迎！ 不但从技术意义上讲有很多关于内核的知识
+需要学，而且了解我们社区的工作方式也很重要。 阅读这些文章可以让您以更轻松地,
+麻烦最少的方式将更改合并到内核。
+
+以下是每位开发人员应阅读的基本指南。
+
+.. toctree::
+   :maxdepth: 1
+
+   howto
+   submitting-patches
+   coding-style
+   email-clients
+
+其它大多数开发人员感兴趣的社区指南：
+
+
+.. toctree::
+   :maxdepth: 1
+
+   submitting-drivers
+   stable-api-nonsense
+   stable-kernel-rules
+
+这些是一些总体技术指南，由于缺乏更好的地方，现在已经放在这里
+
+.. toctree::
+   :maxdepth: 1
+
+   magic-number
+   volatile-considered-harmful
+
+.. only::  subproject and html
+
+   目录
+   ====
+
+   * :ref:`genindex`
-- 
2.19.1.856.g8858448bb

