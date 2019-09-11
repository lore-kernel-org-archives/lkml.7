Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D626C49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717302171F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfIKCfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:35:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfIKCfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:35:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D703B4870870CF8B1570;
        Wed, 11 Sep 2019 10:35:06 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 11 Sep 2019 10:34:57 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/2] KVM: arm/arm64: Two minor tracing changes
Date:   Wed, 11 Sep 2019 02:33:34 +0000
Message-ID: <1568169216-12632-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes two very minor tracing changes in KVM arm/arm64.
See patches for details.  Thanks!

Zenghui Yu (2):
  KVM: arm/arm64: vgic: Use the appropriate TRACE_INCLUDE_PATH
  KVM: arm/arm64: Print the EC hex value with its exact width

 virt/kvm/arm/trace.h      | 2 +-
 virt/kvm/arm/vgic/trace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.19.1


