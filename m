Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D49ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1448620679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642130;
	bh=BnNP/S94t0ycyVIws48GAEBsgOMeY35JYl69u3+93fc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=y87rHfGH0OtHt5Jf7EW4OCmZc0tZHONE6fGDWQ4ED/3BK3++Qny42iZ8J2j/uWGc3
	 7tN6USYfB6kcDHbu+r7+TQDoVipaV4WklPSJ54edc8OI417YEgwVfEu5iyAoDNS+pe
	 EtgmJhhK4gvQHco4H/PMCBPZ/GFlqPeUYIM7XbdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbfJIR2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbfJIRYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110C2218DE;
        Wed,  9 Oct 2019 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641861;
        bh=BnNP/S94t0ycyVIws48GAEBsgOMeY35JYl69u3+93fc=;
        h=From:To:Cc:Subject:Date:From;
        b=SbeWUKDKwKqsp4Ni7++f16Zn6d/zQS8tkfkfeoMYWc8RfgjohPsV2jLfjmtbr8kLg
         sS7C/qBVtSVk9hywa/1C/kF7owDIALeYAy6NwpSDSxIVeAi4v/8qKsgxHE8kKC5gfX
         jvEluiNnT8vNbNXX6V8mDKPYCMOzW5VRIEp7qRPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zenghui Yu <yuzenghui@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.14 01/21] KVM: arm/arm64: vgic: Use the appropriate TRACE_INCLUDE_PATH
Date:   Wed,  9 Oct 2019 13:05:54 -0400
Message-Id: <20191009170615.32750-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zenghui Yu <yuzenghui@huawei.com>

[ Upstream commit aac60f1a867773de9eb164013d89c99f3ea1f009 ]

Commit 49dfe94fe5ad ("KVM: arm/arm64: Fix TRACE_INCLUDE_PATH") fixes
TRACE_INCLUDE_PATH to the correct relative path to the define_trace.h
and explains why did the old one work.

The same fix should be applied to virt/kvm/arm/vgic/trace.h.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/vgic/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic/trace.h b/virt/kvm/arm/vgic/trace.h
index 55fed77a9f739..4fd4f6db181b0 100644
--- a/virt/kvm/arm/vgic/trace.h
+++ b/virt/kvm/arm/vgic/trace.h
@@ -30,7 +30,7 @@ TRACE_EVENT(vgic_update_irq_pending,
 #endif /* _TRACE_VGIC_H */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../../virt/kvm/arm/vgic
+#define TRACE_INCLUDE_PATH ../../virt/kvm/arm/vgic
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.20.1

