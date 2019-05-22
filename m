Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1ABC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F920879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558540827;
	bh=N0WVeHOTeB0jd1jw9N//sPls+adLRYdyorBLC5cLqco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=P2KLeKFDnfkdgwcXE20WaFaRzGIxbXgD0fT5oG1KhynIDJ57J2uIc9YPM4lDHqv/H
	 OcD3M5dkkEbYyMBfQIm2ScwRxNo9LM+hkXmlFZ17TZF//NTpexQrpePkGjvQt6f7NQ
	 sF3JMWmCVwdGN2Yd9U0yWz8yCjHnHb5AcriFqreU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfEVQAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfEVQAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:00:19 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558540818;
        bh=N0WVeHOTeB0jd1jw9N//sPls+adLRYdyorBLC5cLqco=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SIEG9iTud3AGTmbTSUM4E2wafL7WqarkyalVr3wJ8IkxtbcSwsmn6Jd4TO1icMoZ6
         UhOOWPK3sTSxUjfvNdBSHwkUgYdAuR7CEidOvV5IYciNT/RzIU5YT90f/BrqzvOQkf
         Lk2rqmUeBzWyF2zCeXu8uhxX2tG532sFpSA6BxmA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190521.224313.1147278917444675944.davem@davemloft.net>
References: <20190521.224313.1147278917444675944.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190521.224313.1147278917444675944.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master
X-PR-Tracked-Commit-Id: ad70411a978d1e6e97b1e341a7bde9a79af0c93d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f75b6f303bd80249a56cce9028954b4f731270e3
Message-Id: <155854081883.3461.17819670011507912290.pr-tracker-bot@kernel.org>
Date:   Wed, 22 May 2019 16:00:18 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 May 2019 22:43:13 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f75b6f303bd80249a56cce9028954b4f731270e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
