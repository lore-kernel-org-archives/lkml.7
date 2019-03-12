Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699952087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCLDDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:03:30 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:42911 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbfCLDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:02:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMWPcRS_1552359733;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWPcRS_1552359733)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:02:13 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        TripleX Chung <xxx.phy@gmail.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 25/31] docs/zh_CN: update TripleX chung's email address
Date:   Tue, 12 Mar 2019 11:01:23 +0800
Message-Id: <20190312030129.47511-26-alex.shi@linux.alibaba.com>
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

Update the obslete email address to active one in Chineses docs.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: TripleX Chung <xxx.phy@gmail.com>
Cc: Li Yang <leoyang.li@nxp.com>
---
 .../translations/zh_CN/process/stable-api-nonsense.rst        | 4 ++--
 .../translations/zh_CN/process/stable-kernel-rules.rst        | 4 ++--
 .../translations/zh_CN/process/submitting-patches.rst         | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
index f11829429000..42d974e6dc35 100644
--- a/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_CN/process/stable-api-nonsense.rst
@@ -10,8 +10,8 @@
 译存在问题，请联系中文版维护者::
 
         英文版维护者： Greg Kroah-Hartman <greg@kroah.com>
-        中文版维护者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
-        中文版翻译者： 钟宇  TripleX Chung <zhongyu@18mail.cn>
+        中文版维护者： 钟宇  TripleX Chung <xxx.phy@gmail.com>
+        中文版翻译者： 钟宇  TripleX Chung <xxx.phy@gmail.com>
         中文版校译者： 李阳  Li Yang <leoyang.li@nxp.com>
 
 Linux 内核驱动接口
diff --git a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
index 3d5a10dfc1ae..fb048c42ae48 100644
--- a/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_CN/process/stable-kernel-rules.rst
@@ -8,8 +8,8 @@
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
 译存在问题，请联系中文版维护者::
 
-        中文版维护者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
-        中文版翻译者： 钟宇  TripleX Chung <triplex@zh-kernel.org>
+        中文版维护者： 钟宇  TripleX Chung <xxx.phy@gmail.com>
+        中文版翻译者： 钟宇  TripleX Chung <xxx.phy@gmail.com>
         中文版校译者：
             - 李阳  Li Yang <leoyang.li@nxp.com>
             - Kangkai Yin <e12051@motorola.com>
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 54d2d45e27df..47cdca62cfa2 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -8,8 +8,8 @@
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
 译存在问题，请联系中文版维护者::
 
-        中文版维护者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
-        中文版翻译者： 钟宇 TripleX Chung <triplex@zh-kernel.org>
+        中文版维护者： 钟宇 TripleX Chung <xxx.phy@gmail.com>
+        中文版翻译者： 钟宇 TripleX Chung <xxx.phy@gmail.com>
         中文版校译者： 李阳 Li Yang <leoyang.li@nxp.com>
                        王聪 Wang Cong <xiyou.wangcong@gmail.com>
 
-- 
2.19.1.856.g8858448bb

