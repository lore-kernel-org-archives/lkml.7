Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B1E20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070146;
	bh=Nbx/O9ozHTof+r8zknZ4SXXtthZnnU79PdTscGRBj/I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bvEpaPU0Lz0LhsOTS48f/Or01sHo10olgcFZajopydw30v7+FfAL/Q6C0k2rohXqp
	 MxSMAmvH2dt8Os7Bk9DvDZ2i5zPXZFQCNblAuOLE5McN3T762MLAipEyFCTL5d5KmK
	 HHyeo07OnRp1TWLGnn94lKrUJUMOZU/M7ftz+Pfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfCHSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbfCHSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:24 -0500
Subject: Re: [GIT PULL] power-supply changes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070123;
        bh=Nbx/O9ozHTof+r8zknZ4SXXtthZnnU79PdTscGRBj/I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lwwj3hXFGDfkNvCCv5Z+ks4LuG5qdLCxHLg11GYbGcrDJ32Gkl8aRWWprvBDGaDRp
         ZMbLuHQNh6d+pPJpA9MPb/i9ktcjDS9ayFOfsCNUdl8HGL8irvJC3bu/gbBbcXkmNY
         ks1y++wmfjDqxdTTSlqbvby3mcpsx7o0O1Fpf0KY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305220447.e3rb3yu544kcix7m@earth.universe>
References: <20190305220447.e3rb3yu544kcix7m@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305220447.e3rb3yu544kcix7m@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
 tags/for-v5.1
X-PR-Tracked-Commit-Id: 655ab0bc462d1ae2aa344b1ecf35ca1a3ed726dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1cabd3e0bd88d7ba9854cbb9213ef40eccad603b
Message-Id: <155207012351.7904.9110310174364226903.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:23 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 23:04:47 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1cabd3e0bd88d7ba9854cbb9213ef40eccad603b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
