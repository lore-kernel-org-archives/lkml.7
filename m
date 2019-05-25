Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD3C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A947D20856
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558824618;
	bh=IZraUQl/lxNrRpgfWKsRMn7XymePaXQzWcDtelH5TAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rWPfV4rHaQORZFkiZbUW77BF/KMOGoVjGnEa8PF2AyQkI/IwBogNA4wL9BOxGuRaM
	 q5MCn+b/re12oWpLV8JsCcuNvn3PLvfmwjNpd+//suMePBsMGAL7smFWRPqC1NFxXR
	 6SxgRyIQWK1hf3o24SbVEaadnykXOTB2rgaaVyCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEYWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 18:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfEYWuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 18:50:17 -0400
Subject: Re: [GIT PULL] ext4 fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558824617;
        bh=IZraUQl/lxNrRpgfWKsRMn7XymePaXQzWcDtelH5TAw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c5lQI1IrBD9Uc7ZfgOvjYKSpbF/XCa+pC6lY89N2McXGqwNkmnVeRklGHTULlKA+0
         St1i5z7VpHD+v0KBWHAYsSEmmrBVBZIHJLpHj8JyRhLqmXQmmukkWbOSDJARelyFsm
         c80zJIpzlwYgJ0Zl/CW+oGhxYkboqMmF+jfZSg64=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190525210714.GA18163@mit.edu>
References: <20190525210714.GA18163@mit.edu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190525210714.GA18163@mit.edu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 tags/ext4_for_linus_stable
X-PR-Tracked-Commit-Id: 66883da1eee8ad4b38eeff7fa1c86a097d9670fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35efb51eee2241a970dcf70ed950f9db7e5351f7
Message-Id: <155882461695.1772.5098159217681638108.pr-tracker-bot@kernel.org>
Date:   Sat, 25 May 2019 22:50:16 +0000
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 May 2019 17:07:14 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35efb51eee2241a970dcf70ed950f9db7e5351f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
