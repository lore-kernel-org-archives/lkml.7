Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA5BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD91C20881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 04:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575261643;
	bh=wwZFYqm4Y+zx4fQ/TSY+/ZflzjzvfREUctnUhqPREZ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kz60iRdVAzQPAjQ2phdTWGmmHuDPZ2ArNsMS+CGjujiiPJdFj8ueUdWr2K7+MVHjd
	 dB/6R13rsleoo7QN2uUjmplUu+XVhIA/QsdPd2Tm/ClpU4UsM++GydEzsVAGrGPEyz
	 z7vh31gBuxJ/H8u5jS1knto+tz5laDbJbQFOGsAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfLBEkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 23:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfLBEkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 23:40:17 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575261616;
        bh=wwZFYqm4Y+zx4fQ/TSY+/ZflzjzvfREUctnUhqPREZ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oLD1plyV+Rp8gmpU39brxT9uCLqnaXmG2lpz2VCPRlVKOWvzZd7UL9Lp36rOyp40+
         3sVPtITmPnGVqr+fD9lduMIxpE1VyRtZRILtVMcM5FEx7a2u0Uy3lGvZZsi/rvauM9
         Xz3fGaQ3qSH6fVGYgv4D4V40Jp69FcqKRoLDVOvc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201.160518.50010694947236666.davem@davemloft.net>
References: <20191201.160518.50010694947236666.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201.160518.50010694947236666.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: c5d728113532c695c894c2a88a10453ac83b0f3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3bfc5dd73c6f519ff0636d4e709515f06edef78
Message-Id: <157526161693.3812.2918811189399153354.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 04:40:16 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Dec 2019 16:05:18 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3bfc5dd73c6f519ff0636d4e709515f06edef78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
