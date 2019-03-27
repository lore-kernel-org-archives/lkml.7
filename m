Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E08C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7133E206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfC0NDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:03:20 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36280 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730008AbfC0NDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:03:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmt4aX_1553691748;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmt4aX_1553691748)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:28 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 29/42] docs/zh_CN: link the CoC into process/index
Date:   Wed, 27 Mar 2019 21:01:35 +0800
Message-Id: <20190327130148.3258-30-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
References: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let it appears in html links.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/process/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index 19cc3fae8256..ba9fd19b87d7 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -23,6 +23,7 @@
    :maxdepth: 1
 
    howto
+   code-of-conduct
    submitting-patches
    coding-style
    development-process
-- 
2.19.1.856.g8858448bb

