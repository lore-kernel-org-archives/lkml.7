Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B72C4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1421881
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568767821;
	bh=sZzCZ/lTPuZ3JLJbvwi6BsJErXkWfxdOkQzXWEMY2jk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VcAKGYRGYkewAZsL5kbGPJDZuAlZT6G2ldl9DwlD3ULRAX5rbKM4MA2sTdpS4TL6u
	 vJdG6HK7WVmzC4gtY3j8BDUIOGiZJ4PpJkDBVajMl9avqZqhtbcyizfAgrtAvHU2+L
	 GzLXoP3LGie99Em2jJNmfWbmPmqlEVAfoeR2CFPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfIRAuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfIRAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:50:18 -0400
Subject: Re: [GIT PULL] sound updates for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568767818;
        bh=sZzCZ/lTPuZ3JLJbvwi6BsJErXkWfxdOkQzXWEMY2jk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pUpp52rKTJc3rxcn+20b6wiw8jcrilnz9KAU3HLQPJJu8XpkmFfXvLxqozhHDLHxR
         s34MD3AF+MmHGiA5hm4pGRRGA63k3D5qDj+JNrezI5bS3/P9I9Fr5XEvsmC83MbPy3
         XL5sKpGvoFu8K8E9CWnv96DiweQkoHZkhnZbdQ04=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv9tsxy2h.wl-tiwai@suse.de>
References: <s5hv9tsxy2h.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv9tsxy2h.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc1
X-PR-Tracked-Commit-Id: 9bf9bf5440b99edfba496388c90b52ebcd9df715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ab8ad31601f29470eb895fd95e5c963e125aa1b
Message-Id: <156876781827.24504.13474401284409648002.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:50:18 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:47:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ab8ad31601f29470eb895fd95e5c963e125aa1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
