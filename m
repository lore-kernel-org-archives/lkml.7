Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E412C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AD72087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564854321;
	bh=NuvhDskiUO3Cqrv4KT/gyJyunjSZIICCm7dnpPla604=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RorB1Wiu5/4VV1QKtb8nN/BgLTeR563pDtRZuHFzXL0HqG1bs6fPtXJa9s5CKrIAb
	 e6L+k2mrityN896KYCPV+LTvskkbbLjO64Hpu/D4VAJ7p41SVQLtisrEYDiaOVgzo7
	 z/cdmfvOS/tNPLsx/pbXKguEP6KoayzVV2wGtJlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHCRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 13:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfHCRpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 13:45:11 -0400
Subject: Re: [GIT PULL] RISC-V updates for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564854310;
        bh=NuvhDskiUO3Cqrv4KT/gyJyunjSZIICCm7dnpPla604=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=No2IP/WaqekDnNBAwQ7Prvr668hp1g8r/wgIh8IUea+QUiltYnxI5Ig16hcyEORcH
         8IvN7G/2J3TadwJmt5W3GSpdejv1ZfWh6MvoIL9GJ1As8IVZ4kGhbjUhvTthjggLUy
         dnwfdQ9CNj0l/3tgU3gWjglDowDdalVsJzGlTGX4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1908030720490.3783@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1908030720490.3783@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1908030720490.3783@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.3-rc3
X-PR-Tracked-Commit-Id: b7edabfe843805b7ab8a91396b0782042a289308
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 616725492ec7519643d5638de02a92a28200d03f
Message-Id: <156485431046.24028.8435420942001719867.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Aug 2019 17:45:10 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Aug 2019 07:22:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/616725492ec7519643d5638de02a92a28200d03f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
