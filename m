Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A7E2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070169;
	bh=Ae0+uVEyfEsTAcZNnUsRvQbPisrUm7A3cDVWcIpaEo0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WXfw4JqN2SGgxlP8Vmw9RGrumanLfKVkMM6i/ViVowPscS3Dvq01Ht8MCfAic4H6e
	 G55dsfzqSqbDSCmn4q+uFJ/nXlOrvweM/c9HZQjrJX+HdXP6ZlVoiZU7xoHw0tT/AY
	 FTzT3EuG/1zCTwxEiCHeiocqSEFLxzZmv1LqLvdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCHSgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfCHSf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:26 -0500
Subject: Re: [GIT PULL] (ibft) stable/for-linus-5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070126;
        bh=Ae0+uVEyfEsTAcZNnUsRvQbPisrUm7A3cDVWcIpaEo0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dV1a0vjEtLmrOD0bAEURQCOySq8JE9t5Ghx+FN8le66pk/Mp7IYi5geywETCuoxus
         4JC1gp2/tvW6SwDcgBCPqmsGjvl6p18HsqAdEPn0765YQQDLbqOFmmctekxDMmKBlS
         BuO3Tln8KREds/C7vvrJpIDfp5o9Lvg2eGccnV8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306021830.GB25368@localhost.localdomain>
References: <20190306021830.GB25368@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306021830.GB25368@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git
 stable/for-linus-5.1
X-PR-Tracked-Commit-Id: 8bd04c57fda62e3599f654aa43b521b326a95805
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 564e741171e92aaf095db403c5e9ed3b160e27e9
Message-Id: <155207012609.7904.17024555113363284988.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:26 +0000
To:     Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 21:18:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/564e741171e92aaf095db403c5e9ed3b160e27e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
