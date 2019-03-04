Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905C320835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCDD6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:58:11 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43853 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfCDD6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:58:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TLtryTT_1551671887;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TLtryTT_1551671887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Mar 2019 11:58:07 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-kernel@zh-kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, harryxiyou@gmail.com, corbet@lwn.net
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Coly Li <colyli@suse.de>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 01/20] docs/zh_CN: add disclaimer file
Date:   Mon,  4 Mar 2019 11:57:24 +0800
Message-Id: <20190304035744.155203-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
References: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This a disclaimer file which will be included in Chinese files
as header. To reduce the same common contents copy.

Most of contents quoted from Federico Vaga's file:
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
 Documentation/translations/zh_CN/disclaimer-zh_CN.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst

diff --git a/Documentation/translations/zh_CN/disclaimer-zh_CN.rst b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
new file mode 100644
index 000000000000..0de5dfb069ca
--- /dev/null
+++ b/Documentation/translations/zh_CN/disclaimer-zh_CN.rst
@@ -0,0 +1,11 @@
+:orphan:
+
+.. warning::
+   The purpose of this file is to be easier to read and understand for Chinese
+   speakers and is not intended as a fork. So, if you have any comments or
+   updates for this file please try to update the original English file first.
+
+.. note::
+   If you find any difference between this document and the original file or a
+   problem with the translation, please contact the maintainer of this file,
+   or get help from Alex Shi <alex.shi@linux.alibaba.com>
-- 
2.19.1.856.g8858448bb

