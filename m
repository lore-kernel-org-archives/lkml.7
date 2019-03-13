Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E562087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCMNw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:52:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46899 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbfCMNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMdk0th_1552485029;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdk0th_1552485029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v5 19/31] docs/zh_CN: rename stable_api_nonsense.txt as stable-api-nonsense.rst
Date:   Wed, 13 Mar 2019 21:49:49 +0800
Message-Id: <20190313135001.260905-20-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
References: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make it available in html etc doc making

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
 .../process/{stable_api_nonsense.txt => stable-api-nonsense.rst}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/translations/zh_CN/process/{stable_api_nonsense.txt => stable-api-nonsense.rst} (100%)

diff --git a/Documentation/translations/zh_CN/process/stable_api_nonsense.txt b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
similarity index 100%
rename from Documentation/translations/zh_CN/process/stable_api_nonsense.txt
rename to Documentation/translations/zh_CN/process/stable-api-nonsense.rst
-- 
2.19.1.856.g8858448bb

