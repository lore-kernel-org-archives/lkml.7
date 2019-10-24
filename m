Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F41CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F2E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571912720;
	bh=tXRmztpTH++++m+GX9hGSr6ayfLOEjEjKvJZKIyUfaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zTAvtMZ9ldvk9eXg6D/BIb1QkZe4Q3K9MMmJxPIaXQcLC3Sc+Kqj+L0nS0hWi7aJi
	 hW4jgEvaVJXWGY6eN7ndL5jnk8SokDJHx3SY2kUYo+aKIZQLU9VWIvrT486i9MDdl3
	 cr4QIZ8IiYejtkrqTtgVNElyaMc+08DPNLHGk6eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438768AbfJXKZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438721AbfJXKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:25:08 -0400
Subject: Re: [GIT PULL] sound fixes for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571912708;
        bh=tXRmztpTH++++m+GX9hGSr6ayfLOEjEjKvJZKIyUfaQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=acZgJ0+PVwmxGr9k+68mTRKl9TqXYncNNXq1IuGD1p6wOqesYrwnf4e7xzToWnLvw
         k62+KuJMTL3kjyaQIIRRP7afRaOxX+Hf7pqo5LtCA07ssMnXMRt5gSg1MSGEl/XF0V
         tOdrnm0ujV3zQRLMcqN1ZbANKpoVnwKWGNKsDIqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9seoczv.wl-tiwai@suse.de>
References: <s5hv9seoczv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9seoczv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc5
X-PR-Tracked-Commit-Id: 4750c212174892d26645cdf5ad73fb0e9d594ed3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f632bfaa33ed147ba9eade15f137fc32a13bd4b8
Message-Id: <157191270801.16083.3144518174117540644.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 10:25:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 08:48:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f632bfaa33ed147ba9eade15f137fc32a13bd4b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
