Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FD1208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070187;
	bh=OqckIFBFxid9J3JqppzsFkGthSiXSR7IViAMobmrNzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sGPfo3eIFjylMAVJPzsiVinbjgnmXTzcY+Je6BMH3kpSOFPTwcmad58SuMy628uBI
	 fxH7l3gb+8gT2te/4BZbE8zzCql0reJO0REHqFcKrLNkL411iiYBsRBba8nTHjRy/N
	 NSaaDNCc31o/Y/OGkr163yHayOjcPSBoDlis3wvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfCHSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:36:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfCHSfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:25 -0500
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.1 branch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070125;
        bh=OqckIFBFxid9J3JqppzsFkGthSiXSR7IViAMobmrNzc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LtmNYQdOe00c3vzkY6X9efFtR05y3oYWH76MKL4U/30RG3LAqB3rjXv3nzw7dwdeR
         YXemhv52nZTTetNEqfSqypbzmRGWfvo8VQVkUyCLQvnn1483756YMUP/iOew7fRw38
         VP9SKUWJJA4zBb+iF/PIP3dCT9NEBCrpq/TPMCqk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306021731.GA25368@localhost.localdomain>
References: <20190306021731.GA25368@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306021731.GA25368@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
 stable/for-linus-5.1
X-PR-Tracked-Commit-Id: 22cb45d7692ab502dd47dc5a607b3af240ee1e37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4ff63b437e29d305dfc17eed69559354ad48167
Message-Id: <155207012523.7904.6270739269403098770.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:25 +0000
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 21:17:32 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4ff63b437e29d305dfc17eed69559354ad48167

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
