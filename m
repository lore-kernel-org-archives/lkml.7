Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FABC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576610414;
	bh=YC2mwblfonfwCfIN4f23jCrobWP1I2pR9UzwrZsnwlE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=X3hzu1BT4xgxMXp9EiQo+OO8oWi5cmCzAReMaVG6/Cs4DHAB3744FfG10K0pao68t
	 Ycb2sgTbDtklYHL3wMwjB7UE7cMxcoVCrwo4vkcs7JJGgz1+mtLsbEqg4kWdPbGTAe
	 cZSrMIC29ScseJPyvgKd8nHSv2d1EOgt03gDTFt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfLQTUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLQTUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:20:13 -0500
Subject: Re: [GIT PULL] EFI fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576610412;
        bh=YC2mwblfonfwCfIN4f23jCrobWP1I2pR9UzwrZsnwlE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FrRcT6Su0VG39Lx1Fu0GVLr0uyDZWsZ88brFn12nZ1XBGiF0PCEgMbYnv9YVT978X
         DzxkmB2bhuLxaVQkCMmgVsx9VGjY5fxKdOn2uWjpNxkZg3lZHCkLC59gJw05qr3LLB
         kJpDyoVWpVBNf6merXt0u7zR1upwJNpBHiwdiE1U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191217110942.GA55641@gmail.com>
References: <20191217110942.GA55641@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191217110942.GA55641@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: a470552ee8965da0fe6fd4df0aa39c4cda652c7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a114a18c7dbc2b7ac5a1379a8dcced6095c52ead
Message-Id: <157661041253.14288.12273251815906584485.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Dec 2019 19:20:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Dec 2019 12:09:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a114a18c7dbc2b7ac5a1379a8dcced6095c52ead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
