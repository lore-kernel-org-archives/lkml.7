Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BF5C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38238217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557419126;
	bh=cMgn8Ldf2kq31/30+LFxx6pY0NKNu6y9xgEg1VqFrro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H8F8gtfRgRhbKpYZXGnwZUCRRkRGE768LHgxuXPADj7qZRQR+pDtyW5ZTleAEszzF
	 xX5HHZPdvymlmVP3UQewk59erIp+Yqz16K5APhSNtVCxSPDedUqw9W44vgbvZLrFbp
	 tMXITQ9aK83Ky9htaayvsFRFFjNxbz1L8TMn3oT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEIQZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfEIQZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:25:18 -0400
Subject: Re: [GIT PULL] sound updates for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557419117;
        bh=cMgn8Ldf2kq31/30+LFxx6pY0NKNu6y9xgEg1VqFrro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SvdA85thU9HCq7uQri2+hJ8FQrIJjP4OARi5J+GCnUv9/I6ZWRE0q954nqLXoP1l7
         QU2IIE2s+qEiAKcT2h3Ankn3U6smvh8xX//HhHCktLaj3WaPIQflmW6QnybtXW+Y2V
         uFPB3+52nSZ63NwXdn6RsJ0XLT9iIw8asneFwahM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4l63psff.wl-tiwai@suse.de>
References: <s5h4l63psff.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4l63psff.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.2-rc1
X-PR-Tracked-Commit-Id: ed97c988bdc61ab6fb5d1f5f02a709844557b68f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e57ccca1ba33e1d92cc3bbf8b6304a46948844b0
Message-Id: <155741911748.30533.4760078998411083372.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 16:25:17 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 May 2019 17:18:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e57ccca1ba33e1d92cc3bbf8b6304a46948844b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
