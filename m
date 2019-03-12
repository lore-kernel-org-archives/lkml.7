Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE249C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BA120643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfCLD2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:28:09 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42052 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbfCLDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMWPgeE_1552361131;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWPgeE_1552361131)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:31 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v4 07/31] docs/zh_CN: rename SubmittingPatches for html links
Date:   Tue, 12 Mar 2019 11:24:36 +0800
Message-Id: <20190312032501.62056-8-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

renamed:    Documentation/translations/zh_CN/process/SubmittingPatches
 -> Documentation/translations/zh_CN/process/submitting-patches.rst

For htmldoc links. And will change the doc format to rst.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: TripleX Chung <xxx.phy@gmail.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../zh_CN/process/{SubmittingPatches => submitting-patches.rst}   | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/translations/zh_CN/process/{SubmittingPatches => submitting-patches.rst} (100%)

diff --git a/Documentation/translations/zh_CN/process/SubmittingPatches b/Documentation/translations/zh_CN/process/submitting-patches.rst
similarity index 100%
rename from Documentation/translations/zh_CN/process/SubmittingPatches
rename to Documentation/translations/zh_CN/process/submitting-patches.rst
-- 
2.19.1.856.g8858448bb

