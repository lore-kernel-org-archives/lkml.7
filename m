Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE76CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B632087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfCLDB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:01:58 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50217 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbfCLDB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:01:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMWLtS1_1552359714;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWLtS1_1552359714)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:01:54 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Coly Li <colyli@suse.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH v4 01/31] docs/zh_CN: add disclaimer file
Date:   Tue, 12 Mar 2019 11:00:59 +0800
Message-Id: <20190312030129.47511-2-alex.shi@linux.alibaba.com>
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

This a disclaimer file which will be included in Chinese files
as header. To reduce the same common contents copy.

Part of contents quoted from Federico Vaga's file:
    Documentation/translations/it_IT/disclaimer-ita.rst.
Thanks a lot!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/zh_CN/disclaimer-zh_CN.rst | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst

diff --git a/Documentation/translations/zh_CN/disclaimer-zh_CN.rst b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
new file mode 100644
index 000000000000..5934369b2606
--- /dev/null
+++ b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
@@ -0,0 +1,9 @@
+:orphan:
+
+.. warning::
+     此文件的目的是为让中文读者更容易阅读和理解，而不是作为一个分支。 因此，如果
+     您对此文件有任何意见或更新，请先尝试更新原始英文文件。
+
+.. note::
+     如果您发现本文档与原始文件有任何不同或者有翻译问题，请联系该文件的维护者，
+     或者请求时奎亮的帮助：<alex.shi@linux.alibaba.com>。
-- 
2.19.1.856.g8858448bb

