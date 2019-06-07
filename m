Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36495C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDA2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559925916;
	bh=U8hghi4qvAMZLnnV6R80FVh4SMvLY8K7r/4vDSyo+Hs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y9r10teZprGI7Bfn/0sPbmReCEPplj80ZOyWGUWnb97S6FZZQwLHMYlebJ4/UTv4W
	 V7d6GaHHeuM34cld3c+YFMwEWXuO+3AM5hkU59SgcvmsQr/cJif3AtFdRJZmbiPqdS
	 y1LSvOYsMi+Yg9r2lI0dmguaYu3XcPz9hSaDuf8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfFGQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbfFGQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:45:12 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559925911;
        bh=U8hghi4qvAMZLnnV6R80FVh4SMvLY8K7r/4vDSyo+Hs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rnmvQNZrNvi+6Gd2tTWfpiAskOWWQIwPM2sVyI6mAm7J7gQKPUlhYZMLxQUQOJj32
         olfgvV6SQhlc4Ikhsr8XRAGGAmCU+mj4tHM5DH88rEVysOrQBZLfTmnk6qeydl1gOl
         Ab3B5GBm7KPweab2DaF5I6X1GmPdnbdjbedoOSps=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190606.150010.895828876779567389.davem@davemloft.net>
References: <20190606.150010.895828876779567389.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190606.150010.895828876779567389.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 720f1de4021f09898b8c8443f3b3e995991b6e3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e1d926369545ea09c98c6c7f5d109aa4ee0cd0b
Message-Id: <155992591156.2725.716978244148205783.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jun 2019 16:45:11 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 06 Jun 2019 15:00:10 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e1d926369545ea09c98c6c7f5d109aa4ee0cd0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
