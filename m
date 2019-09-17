Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBAC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38978216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568682021;
	bh=Bgps2yMxmqydBp1CbD3+qBxQrNIlxi8PcB20B9QBo80=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CGD6x0Fibuv6jrIWwgVecIXMV5kHhXH2PfrOdUFAmo6oNWjZgI5MHVt8PQBnJ0oB1
	 0NRAoR7NuQqlRwV+Hc10BaUivj6Lm/8QMb58fgZE741wR9iQKCEkMLYcVXH80gKzGe
	 KCq5LiFZwn6gyUiydc9BmjXWfyBmWpKQb8e2631E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfIQBAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 21:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733128AbfIQBAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:00:18 -0400
Subject: Re: [GIT PULL] core/headers change for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568682017;
        bh=Bgps2yMxmqydBp1CbD3+qBxQrNIlxi8PcB20B9QBo80=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VfMpUmXBb/oRXR0MmTU8ciAxNEnQlCcXCZ3zuWbRxMcJY6fr4KB1pqfNTRMPpp2AB
         +82tMZHPiGSbd+10NZ3+4myqBWSPBNGL+y8f8sIFzS7WTRYJja8ODaMTTAbMpgE6mu
         zSLKff6m7fslZsaNawKoK5TTS8bgZGIGcEhcGX8g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190916111101.GA55216@gmail.com>
References: <20190916111101.GA55216@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190916111101.GA55216@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-headers-for-linus
X-PR-Tracked-Commit-Id: e8e4eb0fbeda570b16464208aebf5caccfb6eb95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a480222f4c7cdafad22540f44487f009e359dfb8
Message-Id: <156868201771.3683.2079398764626033242.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 01:00:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:11:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a480222f4c7cdafad22540f44487f009e359dfb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
