Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31DEC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CB22171F
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554573904;
	bh=iX8EdgMf+jBbU3O3JAYnel/lsPpDNzG00I4ZI9GlB+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MNNTcjr3xpiRDsCtzYQl1U+pDe6+JOFxYqtkl+iGpNUAyPrWTCfcFiIalZEuIFJKD
	 agjkEOmf8QakUWYV5EXMdUTvgL144tPSqbzQ9EGaIXc0R0xMj6wVNx3WwW+7CanU3H
	 HPKaUnpf+Q8lILg9f1B7GfAd3dF35TzLB8qasP9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDFSFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfDFSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 14:05:02 -0400
Subject: Re: [GIT PULL] RTC fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554573901;
        bh=iX8EdgMf+jBbU3O3JAYnel/lsPpDNzG00I4ZI9GlB+4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jw9AMSJ30CKMLbMQTgNHkOxO/dyva/pGSQH2FYWKYuVh8pSsb6mS5gJGs0/GcaFaK
         QyquuuJE+ri/LgBE2xggcCaCwc6o4dt906dODH1Skiv8qDsoCwSo4SttuLcDvxg2k9
         bFvbIoY+MS3EUIFDBrnRpmYbny8EFFwooMW29nv8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190406120653.GA10170@piout.net>
References: <20190406120653.GA10170@piout.net>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190406120653.GA10170@piout.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
 tags/rtc-5.1-2
X-PR-Tracked-Commit-Id: 882c5e552ffd06856de42261460f46e18319d259
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be76865df56f22f29ab20e671143761d78ed09c8
Message-Id: <155457390190.9604.10012674085188233392.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Apr 2019 18:05:01 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Apr 2019 14:06:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be76865df56f22f29ab20e671143761d78ed09c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
