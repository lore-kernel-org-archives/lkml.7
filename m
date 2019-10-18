Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61863CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363CD2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571418307;
	bh=eg+k+ce0XER7XI/I/KPGrFNclSMdQKs+qO/mCLbpx/w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kzK05nILVVT3iejgv8a6+tOnv10+vTFs1lO7c0Zm0EDj2T/ItCPg8EN6f3BP/fSU6
	 IGn8+RfOoIe0ul7Qm3W3kLbeNMnu00kVPOvbbvaXQ74uLOfdWK4zIhBxu43NGeEzwy
	 N/0pDDI/C062bKOTHq6TyADQYvn2FyfVgB+0AMYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409392AbfJRRFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405269AbfJRRFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:05:05 -0400
Subject: Re: [GIT PULL] sound fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571418305;
        bh=eg+k+ce0XER7XI/I/KPGrFNclSMdQKs+qO/mCLbpx/w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VRrgPq5v5DxlsNqjRwSqEPpA71G67Pt6T5Zn8aW5VyM3OrMcRf5PBOgKSS37AAIvv
         WxVtWmgie8rmsYLGWoCgVteBQcvdHLqYsHCn8wJMB8JNoooOIsIA3v2Z2MiH3xrK+H
         b/AfauPc+cNvlF7wyeWxFfmz21DSBBVCFAbzGZj8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h7e52gyii.wl-tiwai@suse.de>
References: <s5h7e52gyii.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h7e52gyii.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc4
X-PR-Tracked-Commit-Id: 94989e318b2f11e217e86bee058088064fa9a2e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f93393a15f0f19e7fef35fcf1e6b6ffc351108d
Message-Id: <157141830505.1926.15033851465209301535.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Oct 2019 17:05:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 12:04:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f93393a15f0f19e7fef35fcf1e6b6ffc351108d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
