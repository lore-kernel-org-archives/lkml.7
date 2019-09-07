Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A0C43140
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC8B21835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567876207;
	bh=aYcXLOxOn6Vq5mK3hc79BWRFLFT5aG9wBRLHuuBxzMk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wovtStLbfrWtpa5tzENsW+kWfnaPiBZli6MYj1AIUz/8h6ObpaKX5/ibnmW9ADV5O
	 8YPWqXCrYKXA3qCpQ8M2lFHUfn2AHH0+XUVWTOF4ZTwJnLouNmDOp4ugUNDziYaXR3
	 NyLDR1J+1zh+Qg58dPo45d70Yy/7Pn0wwmE9yXZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395126AbfIGRKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388342AbfIGRKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:10:06 -0400
Subject: Re: [GIT PULL] dmaengine late fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567876206;
        bh=aYcXLOxOn6Vq5mK3hc79BWRFLFT5aG9wBRLHuuBxzMk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N/NkGnFye+YPPV3PM1y/xDPOGl+rbOBqMNpDYTXBZhUkAVg6XIjDSActF/iIA5vQo
         A75QPq49JiNF8k/r+2qGGtBLeWEgUy9KLQV7rDSujoBq66cmdnwAYLNB3dFrnY/SsO
         78BzClIvd28Pv6cvmuUqLyrYKcyq0G2zX22Kg7WI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190907081234.GJ2672@vkoul-mobl>
References: <20190907081234.GJ2672@vkoul-mobl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190907081234.GJ2672@vkoul-mobl>
X-PR-Tracked-Remote: git://git.infradead.org/users/vkoul/slave-dma.git
 tags/dmaengine-fix-5.3
X-PR-Tracked-Commit-Id: cf24aac38698bfa1d021afd3883df3c4c65143a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3464ccd105b42f87302572ee1f097e6e0b432c6
Message-Id: <156787620592.5460.514855460056718529.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Sep 2019 17:10:05 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Sep 2019 13:42:34 +0530:

> git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-fix-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3464ccd105b42f87302572ee1f097e6e0b432c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
