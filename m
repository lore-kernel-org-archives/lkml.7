Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E31EC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6EA2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfEVJ0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:26:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59474 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbfEVJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:26:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09683286|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.046806-0.00376795-0.949426;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.EbUMnSP_1558517196;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EbUMnSP_1558517196)
          by smtp.aliyun-inc.com(10.147.40.233);
          Wed, 22 May 2019 17:26:36 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>
Subject: [PATCH 0/5] Add pmu hardware sampling support
Date:   Wed, 22 May 2019 17:25:27 +0800
Message-Id: <cover.1558516765.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add hardware sampling support for csky-pmu, and
also add some properties to pmu node definition. perf can record
on hardware event with this patch applied.

Guo Ren (1):
  csky: Fixup some error count in 810 & 860.

Mao Han (4):
  csky: Init pmu as a device
  csky: Add reg-io-width property for csky pmu
  csky: Add pmu interrupt support
  dt-bindings: csky: Add csky PMU bindings

 Documentation/devicetree/bindings/csky/pmu.txt |  38 +++
 arch/csky/kernel/perf_event.c                  | 401 +++++++++++++++++++++++--
 2 files changed, 418 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

-- 
2.7.4

