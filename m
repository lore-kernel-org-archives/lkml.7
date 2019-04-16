Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B09C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2BA2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfDPC2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:28:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:22461 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfDPC2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:28:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TPQZvt6_1555381713;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TPQZvt6_1555381713)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 10:28:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     kernel-doc@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] docs/zh_CN: redirect CoC docs to Chinese version
Date:   Tue, 16 Apr 2019 10:28:24 +0800
Message-Id: <20190416022825.187932-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That gives more natural reading experience for Chinese.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/code-of-conduct-interpretation.rst            | 2 +-
 Documentation/translations/zh_CN/process/code-of-conduct.rst    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
index a1daec0482e2..c323ce76e0cb 100644
--- a/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_CN/process/code-of-conduct-interpretation.rst
@@ -8,7 +8,7 @@
 Linux内核贡献者契约行为准则解释
 ===============================
 
-:ref:`code_of_conduct` 准则是一个通用文档，旨在为几乎所有开源社区提供一套规则。
+:ref:`cn_code_of_conduct` 准则是一个通用文档，旨在为几乎所有开源社区提供一套规则。
 每个开源社区都是独一无二的，Linux内核也不例外。因此，本文描述了Linux内核社区中
 如何解释它。我们也不希望这种解释随着时间的推移是静态的，并将根据需要进行调整。
 
diff --git a/Documentation/translations/zh_CN/process/code-of-conduct.rst b/Documentation/translations/zh_CN/process/code-of-conduct.rst
index 4054daafedf1..99024df058e9 100644
--- a/Documentation/translations/zh_CN/process/code-of-conduct.rst
+++ b/Documentation/translations/zh_CN/process/code-of-conduct.rst
@@ -69,4 +69,4 @@ https://www.contributor-covenant.org/version/1/4/code-of-conduct.html 获取。
 解释
 ====
 
-有关Linux内核社区如何解释此文档，请参阅 :ref:`code_of_conduct_interpretation`
+有关Linux内核社区如何解释此文档，请参阅 :ref:`cn_code_of_conduct_interpretation`
-- 
2.19.1.856.g8858448bb

