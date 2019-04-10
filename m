Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC69C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B2206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbfDJPYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:24:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56574 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbfDJPYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:24:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B7C374;
        Wed, 10 Apr 2019 08:24:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB0CC3F59C;
        Wed, 10 Apr 2019 08:23:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, julien.thierry@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        andrew.murray@arm.com, eric.auger@redhat.com,
        zhengxiang9@huawei.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/2] kvm: arm: Unify stage2 mapping for THP backed memory
Date:   Wed, 10 Apr 2019 16:23:50 +0100
Message-Id: <1554909832-7169-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554909297-6753-1-git-send-email-suzuki.poulose@arm.com>
References: <1554909297-6753-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series cleans up the handling of the stage2 huge mapping for THP.
Applies on top of [1]


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-April/645324.html

Suzuki K Poulose (2):
  kvm: arm: Clean up the checking for huge mapping
  kvm: arm: Unify handling THP backed host memory

 virt/kvm/arm/mmu.c | 127 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

-- 
2.7.4

