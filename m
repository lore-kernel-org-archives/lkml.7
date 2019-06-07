Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19265C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86C920B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfFGL3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:29:55 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:50502 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfFGL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:29:54 -0400
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id MnVs200033XaVaC06nVsHX; Fri, 07 Jun 2019 13:29:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4C-0004FN-4d; Fri, 07 Jun 2019 13:29:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD4C-0003lH-38; Fri, 07 Jun 2019 13:29:52 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] KVM: arm/arm64: Always capitalize ITS
Date:   Fri,  7 Jun 2019 13:29:51 +0200
Message-Id: <20190607112951.14418-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All but one reference is capitalized.  Fix the remaining one.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/virtual/kvm/devices/arm-vgic-its.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
index 4f0c9fc403656d29..eeaa95b893a89b7a 100644
--- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
+++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
@@ -103,7 +103,7 @@ Groups:
 The following ordering must be followed when restoring the GIC and the ITS:
 a) restore all guest memory and create vcpus
 b) restore all redistributors
-c) provide the its base address
+c) provide the ITS base address
    (KVM_DEV_ARM_VGIC_GRP_ADDR)
 d) restore the ITS in the following order:
    1. Restore GITS_CBASER
-- 
2.17.1

