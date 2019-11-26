Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3DEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D23204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574746812;
	bh=sBK/YsLtKanUDnDdM39zTec/KpZoHAb9ooAh9Bpl5G0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GqFrUYW5EGUkZQRpcG7sQgsdRPirkxZegRMMHKwVFgJkYCs+D4VlYStSY8PMiz3cf
	 fmrSMLw9JqgsMkM8fxasPXpKVXSTKXv8Yussc/UX3RJ/f0PCjlTC1jnlR926TybEP9
	 ySbUc+MPzUpJOL3j1zeuvGxiSezMJuVbOiX5EsF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfKZFkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:40:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfKZFkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:40:08 -0500
Subject: Re: [GIT PULL] regulator updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574746808;
        bh=sBK/YsLtKanUDnDdM39zTec/KpZoHAb9ooAh9Bpl5G0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rRVQGfSPf4b0VjfteObeJOijJADPKagzebDGSfRNGEGgH56agD63mo8pyWW3TK3ef
         cX9Khn1vbNOsn7KjKNdjrbpemQxVYMH7RjxaMgHy2huSwRq5UYb6SQkFNDxPzCTzEA
         URJyoWuNIraDdAi7unxkZ+z9v+P0UCMCarNL5vgg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125132049.GC4535@sirena.org.uk>
References: <20191125132049.GC4535@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125132049.GC4535@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.5
X-PR-Tracked-Commit-Id: a21da94f617bce0771144ea8093b6987184b38d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d873a0cd21dbe2502873feb4b12e3e0ee9a78ac9
Message-Id: <157474680803.3611.6518459029849248865.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 05:40:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:20:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d873a0cd21dbe2502873feb4b12e3e0ee9a78ac9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
