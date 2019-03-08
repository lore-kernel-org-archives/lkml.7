Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A565C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EEA20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfCHDKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:10:50 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57167 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbfCHDKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:10:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TMDnmbq_1552014615;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMDnmbq_1552014615)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Mar 2019 11:10:15 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        harryxiyou@gmail.com, corbet@lwn.net
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Bryan Wu <bryan.wu@analog.com>, Li Zefan <lizefan@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fengguang Wu <fengguang.wu@intel.com>, Coly Li <colyli@suse.de>
Subject: [PATCH v3 13/31] docs/zh_CN: rename volatile-consider-harmful doc
Date:   Fri,  8 Mar 2019 11:09:00 +0800
Message-Id: <20190308030918.22337-14-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190308030918.22337-1-alex.shi@linux.alibaba.com>
References: <20190308030918.22337-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it available for html etc docs making.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bryan Wu <bryan.wu@analog.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Coly Li <colyli@suse.de>
---
 ...ile-considered-harmful.txt => volatile-considered-harmful.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/translations/zh_CN/process/{volatile-considered-harmful.txt => volatile-considered-harmful.rst} (100%)

diff --git a/Documentation/translations/zh_CN/process/volatile-considered-harmful.txt b/Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
similarity index 100%
rename from Documentation/translations/zh_CN/process/volatile-considered-harmful.txt
rename to Documentation/translations/zh_CN/process/volatile-considered-harmful.rst
-- 
2.19.1.856.g8858448bb

