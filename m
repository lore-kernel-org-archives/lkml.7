Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79E6C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8284B2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561529707;
	bh=Qb7S7VmlTrT6/A7/IDJyeqlcu5dCbxmCOwSP5d27DvI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oDiF3SqR96c116ZOy/alcXacTD8V7eP8NkRP1NSF0NTKoWYwxo2LGeunKhahdxvZr
	 aRuNBTAIAg2YEL5pnpSWiK1w2m+bOlhZs/iBSGNK6P+sSrtIl3apVFbM+SE6X7ldpp
	 JeOOwWpeQmac7I5mtzn1dyub3qwzjY9CKuChiAIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfFZGPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZGPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:15:05 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8482085A;
        Wed, 26 Jun 2019 06:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561529704;
        bh=Qb7S7VmlTrT6/A7/IDJyeqlcu5dCbxmCOwSP5d27DvI=;
        h=From:To:Cc:Subject:Date:From;
        b=k6tN/2D42TQF3XWlBDNaoyAISLiYPFNyHa+vPlFEQ3ypXFYM23S9+0I1dUsOxbOJL
         u0TdxWJpGo9+/r1BHAPb0l4VCbtx3lgBD4uMtzTBcC11dL0u+MpEGwocwAbyIcCS/2
         LrS4CFfbJ5TgZRBClUAmt1khuq0TE7m/vXC9J5+8=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky fixup gcc unwind for v5.2
Date:   Wed, 26 Jun 2019 14:14:23 +0800
Message-Id: <1561529663-29852-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Only one bugfix for v5.2, please pull.

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.2-fixup-gcc-unwind

for you to fetch changes up to 19e5e2ae9c883f5651eaaeab2f258e2c4b78fda3:

  csky: Fixup libgcc unwind error (2019-06-26 13:45:48 +0800)

----------------------------------------------------------------
arch/csky fixup for 5.2

Only 1 fixup patch for rt_sigframe in signal.c

----------------------------------------------------------------
Guo Ren (1):
      csky: Fixup libgcc unwind error

 arch/csky/kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)
