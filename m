Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72060C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AB8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yZXtmKjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfDRJjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:39:32 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:36071 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:39:32 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3I9d4A5017651;
        Thu, 18 Apr 2019 18:39:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3I9d4A5017651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555580344;
        bh=4ZkeAxX/fVLeD4HpbfnoFTyudDVq6PKwmbFelUetoWs=;
        h=From:To:Cc:Subject:Date:From;
        b=yZXtmKjGd+/KwpXOvPkNSasdPO92ZULXenyOw21ifA4V2UyPRBlt5RcLrcrVnGCuA
         8/ycVcPqOupwblU8TQqNLpgTj5QZr7ee5YfAsswzkFGharPMIuuV525SBAS9fOYkXm
         0uG9bSBPolYzkQrvPLnCapCShb1qyacW52RJ7IE4CsYBKPVfqWeWzs/aS5y0IWvRh8
         Yw1uBoxAHlNGnQBLMBIS0SIZmnu1Kf5LX+GTZVVJg88XhdYyv/Ph5oFTAyUy6FfUdp
         o/c72L5QBZcwq081tjcdBjD1F1RaMTSui7T9jqvIydqlQ4UUHtJLES1btdghW38ZPD
         EISj2M+uLsQUQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nickhu <nickhu@andestech.com>
Subject: [PATCH v2] nds32: remove unused generic-y += cmpxchg-local.h
Date:   Thu, 18 Apr 2019 18:38:56 +0900
Message-Id: <20190418093856.17852-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NDS32 is the only architecture that creates <asm/cmpxchg-local.h>,
which is not included by anyone.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix a typo in commit log

 arch/nds32/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 64ceff7ab99b..e8dbfbf8cc69 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -6,7 +6,6 @@ generic-y += bugs.h
 generic-y += checksum.h
 generic-y += clkdev.h
 generic-y += cmpxchg.h
-generic-y += cmpxchg-local.h
 generic-y += compat.h
 generic-y += cputime.h
 generic-y += device.h
-- 
2.17.1

