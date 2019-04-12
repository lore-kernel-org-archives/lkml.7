Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD822171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083031;
	bh=3oMFdjuYL+labyYLfDP6+m7x14e3DgoHiAhnlGrHGHQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k0j8FoyJ1OcbJsaEiS3D8W00AFavneMZWurWgw9KOefAR8szY+Z46OdXRqMT6+cmp
	 LANgFdSFln8tQuW7l7OV8rm91L0CweA5MP8Lc6a1Za/keSGThWwP+czeEXkQGi2SSa
	 4RL40sDOeHUNrZcC3q2ewdtOjYCtS9IAAVhUi9R8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfDLPaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfDLPaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:07 -0400
Subject: Re: [GIT PULL] clang-format for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083006;
        bh=3oMFdjuYL+labyYLfDP6+m7x14e3DgoHiAhnlGrHGHQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ES3cQ7KYfdOYge4QCiRGeHO/w9A18/Doi1xH/dyjVOSA+OuZ50b4GTYUVNUCHNa+n
         hkhh6nJeW68CLdyLcTNl3COqP1O0ucg00BdISVnyonQgUxdtsgSrQ19kkexHjX9nh9
         YZ4wZKfxJp4KbKmDPU1LnmacjqOKVtkPGosrn1p8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412110003.GA14630@gmail.com>
References: <20190412110003.GA14630@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412110003.GA14630@gmail.com>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git
 tags/clang-format-for-linus-v5.1-rc5
X-PR-Tracked-Commit-Id: f16628d6e8c6616b071ffe775908b95e07404cab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e72d95d993de920a81cd71027d3bb9c22cd0b4e
Message-Id: <155508300688.31973.5710118967708631635.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:06 +0000
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 13:00:03 +0200:

> https://github.com/ojeda/linux.git tags/clang-format-for-linus-v5.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e72d95d993de920a81cd71027d3bb9c22cd0b4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
