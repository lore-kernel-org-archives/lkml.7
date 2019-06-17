Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A19C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3004D208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560814509;
	bh=jrDbJSj1l+QKbJqYxevvzNKpDjm3U21oYvoFhSEewz4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zAiLHFEt0OjGYZ02qCrQWS4ASkCVdG64hXNaxXFCtKrOuLtq5P5XHcASKihKIJDMz
	 tZIrUeXcMtxxfvPk+arQ0azTt/uRGLI6jaS5S5+o4bu4bt5MBRsxWklucI7ZgOXEQh
	 QRe+cwACNm8Xnt8wscosspjkE0Jqj2vJbvRSt3i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFQXfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 19:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFQXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:35:06 -0400
Subject: Re: [GIT PULL] RISC-V patches for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560814505;
        bh=jrDbJSj1l+QKbJqYxevvzNKpDjm3U21oYvoFhSEewz4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RZRNMiqQkw64ZR5oA69fW9xkstwUQI3BaEBF8Yn0gMUm5ScpJpEwHMq9KYty5hACk
         Lg9btKcvDyG4VgjocpyhPNMKLxMwm/NkFaKWqG/jXmA+4hvqKZNUVrVV3lTfCYo2jZ
         Wqw4muTyq/N9abG4zU3rF+9/aXKUtZLD9ivFDUDY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1906170846340.30717@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv-for-v5.2/fixes-rc6
X-PR-Tracked-Commit-Id: 259931fd3b96e4386b361b7f80c1d89b266234c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb7c825bf74755a9ea975b7a463c6d13ffa7f447
Message-Id: <156081450530.13377.16512075624141973247.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jun 2019 23:35:05 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jun 2019 08:54:30 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-v5.2/fixes-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb7c825bf74755a9ea975b7a463c6d13ffa7f447

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
