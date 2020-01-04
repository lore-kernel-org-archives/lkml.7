Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA2CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 19:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2E222B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 19:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578164410;
	bh=PZf+xLu6PsEbluGFUFJPPRlLpvLjXMTAlR0UZyJOKQc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qB2D4sjHO5DNd8yLTXb1xgF/+Zvg4P4A7vDpjr0jzmfKJqblo7il57xCOJ5iQas3b
	 nNZeBvcMSIAxucCiqMsx/f2AuoYQmNFkT3zPb+foT8zgzjvDNgl3/Ces1cVMzqTCRF
	 75Jmq7B2aLiQISA7ODS2w+GTp7kl3QM0sQbIVfng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgADTAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 14:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgADTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 14:00:07 -0500
Subject: Re: [GIT PULL]: dmaengine fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578164406;
        bh=PZf+xLu6PsEbluGFUFJPPRlLpvLjXMTAlR0UZyJOKQc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x3fNZOGowWY9I6vV5uBrPOlP8/EO1Sgc5atIQldEbvPgQ7X6CFsWycVqe26UMRfE7
         V4VC9AkN2Ff9RRv4ZYVk4tbmpGceHSlag2Gedc6XdDaaKWpjogkA5aN4jgnjvnr/D9
         LJ2ALwuP7/Iq2BCMVHiG5D/q/E4BICc6Txb9e0Tc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200104173240.GH2818@vkoul-mobl>
References: <20200104173240.GH2818@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200104173240.GH2818@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.5-rc5
X-PR-Tracked-Commit-Id: b0b5ce1010ffc50015eaec72b0028aaae3f526bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5613970af3f5f8372c596b138bd64f3918513515
Message-Id: <157816440651.3477.5352482834548553661.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Jan 2020 19:00:06 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jan 2020 23:02:40 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5613970af3f5f8372c596b138bd64f3918513515

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
