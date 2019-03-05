Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A29FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029302133F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCEHAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:00:55 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41989 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfCEG6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 01:58:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TM.WBFL_1551769113;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM.WBFL_1551769113)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 14:58:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        harryxiyou@gmail.com, corbet@lwn.net, leoyang.li@nxp.com
Cc:     colyli@suse.de, fengguang.wu@intel.com, shawn.guo@linaro.org,
        lizefan@huawei.com, Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v2 07/27] docs/zh_CN: rename SubmittingPatches for html links
Date:   Tue,  5 Mar 2019 14:57:54 +0800
Message-Id: <20190305065815.157964-8-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190305065815.157964-1-alex.shi@linux.alibaba.com>
References: <20190305065815.157964-1-alex.shi@linux.alibaba.com>
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

