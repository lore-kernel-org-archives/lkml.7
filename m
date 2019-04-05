Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913CCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D432206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554429314;
	bh=on9IqATf/L/xlgukEDSlD2aZlZ4dQ/8c3AfLE6yRcyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zSz7iyCK/PFVKw+Dsv0gcfTuPWyFeEBXmQZPE0ewOg4b3RY9J/bmCceT7MRWkwnkh
	 HN3p0Bd6vtIBBjj75aO36/8lvMemY/iyzHlqV+G+EvYsIc43i5RAQ7lXNEORM5l+uE
	 KMX41u/ToZ/L5sAF9dxJ8OtaX2vdawY8SxNMBpas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfDEBzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbfDEBzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:55:08 -0400
Subject: Re: [GIT PULL] Power management material for v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554429308;
        bh=on9IqATf/L/xlgukEDSlD2aZlZ4dQ/8c3AfLE6yRcyg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZixwNwk7hhbciLCsQbpRhnAGwJF8cf2jRxBeyImurReRc18CsT3hYmSf0VBgLW19V
         zNDtpUkjNa2v/b9L1h0m1YEST5/u2DbJjx+hxLoXqQ/XOKDn0yyLo7DdXWYC4sboZb
         Da1P2LkbVaZodQc3yA1dg4q4hbl9e/sRxbhz/dJk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gC4WmXra1RXCxQ8-xa2xfx6PaSost_sf9XUL4wTVeRNQ@mail.gmail.com>
References: <CAJZ5v0gC4WmXra1RXCxQ8-xa2xfx6PaSost_sf9XUL4wTVeRNQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gC4WmXra1RXCxQ8-xa2xfx6PaSost_sf9XUL4wTVeRNQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc4
X-PR-Tracked-Commit-Id: 58b0cf8e2418c05ed277c83b5529bd0568bfcc78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20ad549488d53cb6742770b49e324a3396022da2
Message-Id: <155442930821.31474.13864366337396334272.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 01:55:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Apr 2019 22:32:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20ad549488d53cb6742770b49e324a3396022da2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
