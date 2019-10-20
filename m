Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC0FCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3512089C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 00:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571531707;
	bh=GI2CFO2+wdI/LWJsE+LLwcuFDoNsxrHW9n8uxnHxhx0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nwIMnaifPCduN2w0h36UZPQxtvDB7mH6VHIS1C7aZ8U/9rffdGSE3edSGdEzN/TLe
	 SB8jgdxAW4dC3hF6cXSmUcGvM8hqyODPxKX+buA+HyYoIQdeec910jezqHU8gMwKA8
	 03GPHR+QwJTD3Z1iXNmI82iBuiVW+kC+1PVF60PU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfJTAfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 20:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfJTAfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 20:35:05 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571531704;
        bh=GI2CFO2+wdI/LWJsE+LLwcuFDoNsxrHW9n8uxnHxhx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g1S3fiE/szOMpTyJyQ6z78J2/zh/jzGxWfHbeBG8w6JDRBsF9qo7LLacgdP/RrNjY
         PFYX6aQmoAe4bcZMGzQZVbseZj2THrMKfxqv+BgApMalQYxs+tSXp5pQUoSDWc2DwR
         NIvo5p9BFjtspM+ERP+/JYl5CBqqYZl4e/62iUh4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191019.123927.593477780203351647.davem@davemloft.net>
References: <20191019.123927.593477780203351647.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191019.123927.593477780203351647.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 2a06b8982f8f2f40d03a3daf634676386bd84dbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 531e93d11470aa2e14e6a3febef50d9bc7bab7a1
Message-Id: <157153170487.14932.5887104462724670524.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 00:35:04 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Oct 2019 12:39:27 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/531e93d11470aa2e14e6a3febef50d9bc7bab7a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
