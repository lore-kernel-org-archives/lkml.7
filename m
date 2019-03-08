Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29DC10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB0520684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070184;
	bh=VYx4oLeJtm4KmGrBtjxY+ch5Dug4i8+tlW3IhtG4RXk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BUpWTPgQn7A3wOzKx4NZTgsE0OU94B869IKLf9qgy+VLpYefTS24zYXUSTllXaAG0
	 7OaH1HVTkFcWOZ9SSKN6smNXnxM63C9pd60S0kwyVAz/gBwjSRs1shg1x2S0/m+t+e
	 DV2Z+INn/pro/5EpZEtYNRgTV4VUvpQHf1d6vn78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfCHSf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfCHSfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:20 -0500
Subject: Re: [GIT PULL] RAS updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070120;
        bh=VYx4oLeJtm4KmGrBtjxY+ch5Dug4i8+tlW3IhtG4RXk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AwWlSnoVAADMotlug8oU6Ig2zIOzGG8KyJxkJbXts6WT/fSBjQiHAMLOX1nGpuNh4
         83VKcgql+DtTpUfrdTZ+mGTbU9ifdiOe6qr7QAgAdmLSWj2h8iEYBfyyFcPU0/3yGl
         k7GFIaODILwBQIm8Ewci23mbiiCwaABOpEToFpe8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305141645.GF9073@zn.tnic>
References: <20190305141645.GF9073@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305141645.GF9073@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus
X-PR-Tracked-Commit-Id: 41f035a86b5b72a4f947c38e94239d20d595352a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e13284da944df29ab08e8a9d2a50fc0ad1d858ab
Message-Id: <155207012004.7904.500834822075477681.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 15:16:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e13284da944df29ab08e8a9d2a50fc0ad1d858ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
