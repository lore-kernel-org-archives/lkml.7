Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D26C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA226206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 04:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xstKaU3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfHUENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 00:13:31 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:47150 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfHUENX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 00:13:23 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7L4CeQA002060;
        Wed, 21 Aug 2019 13:12:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7L4CeQA002060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566360761;
        bh=ITTy2JaYsvB5fhZRvaY4vqzdeTClwZEtTVpr/IcMcII=;
        h=From:To:Cc:Subject:Date:From;
        b=xstKaU3lqSmOGLGJD015uRb12PJzIbbFuHUXMu7kBkBT2h69LXhomvUiNJz1Vx5w2
         Y6/oWa/c2SqMVU4L+Y661Sbv2MuOT/Bhx9N27FiyJpFrWzwVqsLR/WameVMQhj6Pp/
         opdwVsNjAm/orhWWsu6K6WfjWsq7JLiZEZ7Z20sVeovZvBa5P/8nObnZFA+rTcB9xP
         vfi4vySswOs67OObuh35ygrXziVv/IVx4wH9f9/Pyv4f8x+hwhwThHd/jXCVE7ORK6
         BSLMxwGY5zfXTxWKpeiXiedjB+aAnTkEZfjS8Gx7Z2HbCQre5ly2vwwBvdamCqyO9X
         r5NlEsw8XtAkQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] video/logo: various fix and cleanups of drivers/video/logo/Makefile
Date:   Wed, 21 Aug 2019 13:12:33 +0900
Message-Id: <20190821041237.23197-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
  - Fix commit log

Masahiro Yamada (4):
  video/logo: remove unneeded *.o pattern from clean-files
  video/logo: do not generate unneeded logo C files
  video/logo: simplify cmd_logo
  video/logo: move pnmtologo tool to drivers/video/logo/ from scripts/

 drivers/video/logo/.gitignore               |  1 +
 drivers/video/logo/Makefile                 | 36 ++++-----------------
 {scripts => drivers/video/logo}/pnmtologo.c |  0
 scripts/.gitignore                          |  1 -
 scripts/Makefile                            |  2 --
 5 files changed, 8 insertions(+), 32 deletions(-)
 rename {scripts => drivers/video/logo}/pnmtologo.c (100%)

-- 
2.17.1

