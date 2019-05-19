Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CDCC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D251720657
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558287935;
	bh=VvvVnhVZcpXecSIhYg4ACmmNbBt/VrKiEi34AGviMRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YT3YlEYabDJQwYSnap3mqg7cbjEWaFb2cC9vAxKL2uHp5dq3p3mlMlEM3VYhldCjk
	 gruWBWDBX7Gw8+DcXQTAxBXKT8Mv9P0XP3G0imyh5dU58vCw65+Dhr79LKIdJZIUdx
	 mc7KF/l8l5Wp3A3oh3hyMHi83bTjJHpOrXi5GGtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfESRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfESRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:45:23 -0400
Subject: Re: [GIT PULL] EFI fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558287922;
        bh=VvvVnhVZcpXecSIhYg4ACmmNbBt/VrKiEi34AGviMRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M7A0XTugxtW/6SATIxyCJJNRaZOowZlL8E1u4+4Sj1EZW1drkX4tzouhdJJplZahY
         n6KdMw7O5N2SKQ1Ew+SFrGkFDznGKWJVqdB/YS0VuZ+8Y6XyPo491wWZ1NDql8JXKY
         Uhr7I31NhXKVITdq6FjHxmUC1dBGnt4lekEIM/rE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190518091726.GA47721@gmail.com>
References: <20190518091726.GA47721@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190518091726.GA47721@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 efi-urgent-for-linus
X-PR-Tracked-Commit-Id: f8585539df0a1527c78b5d760665c89fe1c105a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39feaa3ff4453594297574e116a55bd6d5371f37
Message-Id: <155828792287.9186.2637617430225993607.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 17:45:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 11:17:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39feaa3ff4453594297574e116a55bd6d5371f37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
