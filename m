Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBA8208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897102;
	bh=OTvU8SqEucTB/0gzLzn2dxUGuQMmF2dARxLmXL77Pgo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=S02U4EdRFo83xXq4ryP0MZ6s5SR/aGxD4vX47NDxIaERXKT7MF3QyvbhC16j/NvfA
	 6zluPx0DN66/llcfrkgsdCZBHkaW+KrlUq7H3I7z4wqC0Zb5QH3zpxxnnklAGOAI/U
	 s5G/Uikwlg06d/fXA7HwsZhNr/wxMXAjia4WfRsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCFSaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfCFSaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:15 -0500
Subject: Re: [GIT PULL] y2038: A build fix for compat mode
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897015;
        bh=OTvU8SqEucTB/0gzLzn2dxUGuQMmF2dARxLmXL77Pgo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xex6wCX4qvzyxbGnkzPOCtRTd/X+xbxpUmmDhHQR+Yj56Ph0WKTOhZRwVDKNVkBS1
         q58rOnrUnuGrEpxu5oavxMz0+hC3RAadvub1DnQXOxXvYoQnkwK1w/OfPF6tK/e9lJ
         kSat3S/tvfB3039HfzSHnzKpcNQtzdabimZzpjts=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0gCmN3hAmV-YaX_a1p-DpyMtVKADN2YwhSxi=wPiyyjg@mail.gmail.com>
References: <CAK8P3a0gCmN3hAmV-YaX_a1p-DpyMtVKADN2YwhSxi=wPiyyjg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0gCmN3hAmV-YaX_a1p-DpyMtVKADN2YwhSxi=wPiyyjg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground into
X-PR-Tracked-Commit-Id: 7e89a37c477c4caacde7b511c64720e20104945f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78e10b5e5a849fdfd910dd7b0170a1c2ca0f3483
Message-Id: <155189701545.14612.62994410066713449.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:15 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laura Abbott <labbott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:04:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground into

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78e10b5e5a849fdfd910dd7b0170a1c2ca0f3483

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
