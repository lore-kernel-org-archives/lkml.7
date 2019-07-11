Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E42C74A46
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C41721019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562820030;
	bh=BlEwBoMZiqlTzcxCh2VUi0xFZw2gJ1VGjZXrg2TFvYY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q6mpFtgjdIL/3WdkAj5/GI/qZf6w7UOQcmynHMlvWjRpHbIBzieMi3nqYe5MrgEQI
	 uj1QTv7HchG96QNOex7POQcjzayW4l8IYAUTuuW2mrtunzat/nBKfLGiGv7VsylUvr
	 Nnbg7L/vbzaS1W1p2cfqF0KbUwsGt8uaDZnxgIQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfGKEkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 00:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfGKEkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:03 -0400
Subject: Re: [GIT PULL] afs: Miscellany for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820002;
        bh=BlEwBoMZiqlTzcxCh2VUi0xFZw2gJ1VGjZXrg2TFvYY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vq4GaLVMaq7bCnq4NiAJiRLf/PcD3bcRO7eE5sdJEYjXvSYHmjKYoPpm1j/UUcY17
         vLFVWwFH+HuyIDjfGx/O57HbnThk0Ed6GGBe8BMTrl/82MGtFF8p5ouD4lT2L1+DDw
         VjxUcFLrsmGDDRQsEHxPe1FWoO3WUxCVKKlzdrQg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <29485.1562363139@warthog.procyon.org.uk>
References: <29485.1562363139@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <29485.1562363139@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20190628
X-PR-Tracked-Commit-Id: 1eda8bab70ca7d353b4e865140eaec06fedbf871
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8dda9957e3a1c871dfbabf84c4760f9b26032442
Message-Id: <156282000248.18259.11105783387466270234.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        jmorris@namei.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 05 Jul 2019 22:45:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190628

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8dda9957e3a1c871dfbabf84c4760f9b26032442

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
