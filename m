Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E93C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E61D21670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695517;
	bh=99SpozWSmz3j36MYseE/9sfo6OneKKzvGyjGIZ2MP/E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RxkV8fGtTU/yn7Ja7WPBsaxk1u2w5olruLFqlq48f037vN2d+Kl38dzoGC2iPSZ+q
	 Q3MQvyYYwmOlaQ9nfom5IbyV3w6LogisgrynFuY6Cj7TPDyDnzKgK5TC6UFxQ3pvpB
	 TbmAaAIpmw4+a7LhU1rfkZZOCaVriN0tW5eoKGxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfGISFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfGISFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:14 -0400
Subject: Re: [GIT PULL] sound updates for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695514;
        bh=99SpozWSmz3j36MYseE/9sfo6OneKKzvGyjGIZ2MP/E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TAe8LPWA1mcBxuPA+zLMDyBTsSeAmCR3QfDRkcWoYf+YyFTrRp3YEBv9Z/IuEJr9B
         PA0xzxgeA0GrcbldLFnhiNPpsm/5KubJE54mKHW5bxlQXFhiGrjqeCyrno6KfBDIsR
         G2TffqISg+++HOgMEbDgu3xRQM5HDK1SKygoJMpI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ha7dntgg7.wl-tiwai@suse.de>
References: <s5ha7dntgg7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ha7dntgg7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc1
X-PR-Tracked-Commit-Id: 0dcb4efb1095d0a1f5f681c2b94e98b009cc5d77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cdd5f9186bbe80306e76f11da7ecb0b9720433c
Message-Id: <156269551427.14383.17767776329103236283.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:14 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 16:45:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cdd5f9186bbe80306e76f11da7ecb0b9720433c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
