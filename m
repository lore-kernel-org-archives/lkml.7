Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7F7C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F352084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560892091;
	bh=f1qkhoLuLB/QxV1lYY3zfF+PaNhLE33O0S+nrthnJoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v4n7NP9gmCBlySpWT2Q/BijYuVTudj/JDbKxS+MM9u8KrCdxhYMoCqchPDCp08dBC
	 TDAYvxycTPIcWT7OE3zt9p5kW221jXbCuN2amk5eh/eI2mIpYdNP1etktZdDUeqjM/
	 B/2zlpdpM63Ac0HjmHBGvAZgyK/4fXNNU+n2ssr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfFRVIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:08:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730786AbfFRVFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bceu1mvy2zCFsjrQ11vSq11tdmHlo+ilRmW7GORFzE8=; b=WBpTFrH+Fw9DNhU5G0LyMaeAHA
        2npPgV69hn0AU0jyl1FL9EusO0o/MEn2i+Z8seaf948gh6s8WAO+p5pOSpohLM7GYRV59sxMSRlb5
        AYKLHhDbohMGG9CqmDuiypEseF1cMkBJlyUwnlz0xkEjaSL2aRKAN9TVwsXLlIJG2ICZWq5eSPWLt
        cy/ag8f2YjhtxkRQfsqhwDgk2UCzvpsRBa8DeHV288F2wzsOQ6NtAirjNokH5JVftofl0NeJvIyP/
        0H4zauK+aIknwM/hSpRIglht9PYY/QeqTncTcck5r+6N0kNrr2YQm9LVH/Of+7EffVtbwLq8mdRdU
        ceIbtZHA==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdLIc-0006yx-CU; Tue, 18 Jun 2019 21:05:50 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdLIa-0002Cw-3f; Tue, 18 Jun 2019 18:05:48 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH v1 17/22] docs: add arch doc directories to the index
Date:   Tue, 18 Jun 2019 18:05:41 -0300
Message-Id: <361595adad058766dd3429db996dd78b5e234621.1560891322.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560891322.git.mchehab+samsung@kernel.org>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that several arch documents were converted to ReST,
add their indexes to Documentation/index.rst and remove the
:orphan:  from them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/arm/index.rst    |  2 --
 Documentation/arm64/index.rst  |  2 --
 Documentation/ia64/index.rst   |  2 --
 Documentation/index.rst        | 10 ++++++++++
 Documentation/m68k/index.rst   |  2 --
 Documentation/riscv/index.rst  |  2 --
 Documentation/s390/index.rst   |  2 --
 Documentation/sparc/index.rst  |  2 --
 Documentation/xtensa/index.rst |  2 --
 9 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index bd316d1a1802..9c2f781f4685 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -1,5 +1,3 @@
-﻿:orphan:
-
 ================
 ARM Architecture
 ================
diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 018b7836ecb7..96b696ba4e6c 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 ARM64 Architecture
 ==================
diff --git a/Documentation/ia64/index.rst b/Documentation/ia64/index.rst
index a3e3052ad6e2..ef99475f672b 100644
--- a/Documentation/ia64/index.rst
+++ b/Documentation/ia64/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 IA-64 Architecture
 ==================
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 2f9bf37b8989..82cd9528dff0 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -116,7 +116,17 @@ implementation.
    :maxdepth: 2
 
    sh/index
+   arm/index
+   arm64/index
+   ia64/index
+   m68k/index
+   powerpc/index
+   riscv/index
+   s390/index
+   sh/index
+   sparc/index
    x86/index
+   xtensa/index
 
 Filesystem Documentation
 ------------------------
diff --git a/Documentation/m68k/index.rst b/Documentation/m68k/index.rst
index f3273ec075c3..aa121cfcbbd9 100644
--- a/Documentation/m68k/index.rst
+++ b/Documentation/m68k/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =================
 m68k Architecture
 =================
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index c4b906d9b5a7..e3ca0922a8c2 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================
 RISC-V architecture
 ===================
diff --git a/Documentation/s390/index.rst b/Documentation/s390/index.rst
index 1a914da2a07b..4602312909d3 100644
--- a/Documentation/s390/index.rst
+++ b/Documentation/s390/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =================
 s390 Architecture
 =================
diff --git a/Documentation/sparc/index.rst b/Documentation/sparc/index.rst
index 91f7d6643dd5..71cff621f243 100644
--- a/Documentation/sparc/index.rst
+++ b/Documentation/sparc/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==================
 Sparc Architecture
 ==================
diff --git a/Documentation/xtensa/index.rst b/Documentation/xtensa/index.rst
index 5a24e365e35f..239c5f0a5c67 100644
--- a/Documentation/xtensa/index.rst
+++ b/Documentation/xtensa/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===================
 Xtensa Architecture
 ===================
-- 
2.21.0

