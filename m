Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23508C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53E920644
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556821209;
	bh=749fKGYLowajUpAlZ7zn/XSRU7uF2Oswdp3HhTL8JRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mAIVQyvcqqd8lVrjdA1hBkMtx2e6QEdFiJatGfWiCc55pWbFrt4Ek8aR3p+uaT36X
	 cmGCTUj1/9OGUfllFaUH/vEi00rZOf8THroqLsIpFAm3iRGutlhIe4H3ll4oXFKKav
	 hyi/We67TyIUgeYGK4N56W3weHl6vyfHe6MpP6Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBSUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfEBSUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:20:03 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556821203;
        bh=749fKGYLowajUpAlZ7zn/XSRU7uF2Oswdp3HhTL8JRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GROTZyEllIurPgWjYOIRT03JT5PEhSU+lCwqrcOhZn8jANmcc/ltxD0bEyg3xTT59
         n+O1yUb86R1RTYcEh1mBYLYvwN+DXUzlaS76wrzlwMX5RBIJpBij2cbJA+sjJUWOE5
         EXSQxoXHf5blz56Rvm8wiMWinbtTDl5bMnvDN92E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190502.112229.169709368531678908.davem@davemloft.net>
References: <20190502.112229.169709368531678908.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190502.112229.169709368531678908.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: 4dd2b82d5adfbe0b1587ccad7a8f76d826120f37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea9866793d1e925b4d320eaea409263b2a568f38
Message-Id: <155682120306.31369.9008264982480707260.pr-tracker-bot@kernel.org>
Date:   Thu, 02 May 2019 18:20:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 May 2019 11:22:29 -0400 (EDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea9866793d1e925b4d320eaea409263b2a568f38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
