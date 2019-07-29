Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A82070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfG2FJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:09:09 -0400
Received: from mail.coding4coffee.org ([5.9.171.142]:41484 "EHLO
        mail.coding4coffee.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfG2FJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:09:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.coding4coffee.org (Postfix) with ESMTP id 6288EDAF;
        Mon, 29 Jul 2019 07:09:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at coding4coffee.org
Received: from mail.coding4coffee.org ([127.0.0.1])
        by localhost (mail.coding4coffee.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id kHIT8exP3m3L; Mon, 29 Jul 2019 07:09:05 +0200 (CEST)
Received: from coding4coffee.org (x2f7fde8.dyn.telefonica.de [2.247.253.232])
        by mail.coding4coffee.org (Postfix) with ESMTPSA id 3206FDA4;
        Mon, 29 Jul 2019 07:09:05 +0200 (CEST)
From:   Fabian Mewes <architekt@coding4coffee.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabian Mewes <architekt@coding4coffee.org>
Subject: [PATCH v2] MIPS: Kconfig: remove HAVE_LATENCYTOP_SUPPORT
Date:   Mon, 29 Jul 2019 07:08:34 +0200
Message-Id: <20190729050834.22827-1-architekt@coding4coffee.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <77754e88-ff5d-2021-60f5-80417d61763c@cogentembedded.com>
References: <77754e88-ff5d-2021-60f5-80417d61763c@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE_LATENCYTOP_SUPPORT was removed all together in da48d094ce5d7
("Kconfig: remove HAVE_LATENCYTOP_SUPPORT"). This commit removes
a leftover in the MIPS Kconfig.

Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
---
v1..v2: specify commit's summary enclosed in ("")

 arch/mips/Kconfig |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd..4958734 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3069,10 +3069,6 @@ config STACKTRACE_SUPPORT
 	bool
 	default y
 
-config HAVE_LATENCYTOP_SUPPORT
-	bool
-	default y
-
 config PGTABLE_LEVELS
 	int
 	default 4 if PAGE_SIZE_4KB && MIPS_VA_BITS_48
-- 
2.11.0

