Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E42085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070162;
	bh=KaS3uO0b3qJPQVJ6WdgDyZS4ak1aUnVqOHKyui8phhg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wIZJ6Jq76WuXFE7EHjf+D5EbUWIpPpX07iRIO19wpad3oMTLeScbPp3w0u/QiZD99
	 FWCi1CY5EDwL9yzHbnGRHqksgBfMM/209m0vyJ+J0OrzHAjaewBxEbEc8E8YvkcSt+
	 fiNSLtz2hOl6/PVjcP6E6QrwSqbcL+V70R26CMWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfCHSfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbfCHSf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:29 -0500
Subject: Re: [GIT PULL] MFD for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070128;
        bh=KaS3uO0b3qJPQVJ6WdgDyZS4ak1aUnVqOHKyui8phhg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J5jDxAFVK0zh3ICGcc8r7349n5ZIyLRqsd2q7QuCVZfff4HqaW5L6IiDqtM/yv0IK
         yS6ZVPeCunehTjHD1brmTmEk29ApEiO3lXQHKzFoM0lDMfWROs7jjgkW7Ju/XH/aHU
         8OUa67WrPlgPyAOUCGWUT+bHs46FYviQURgl5HaQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307093828.GD4634@dell>
References: <20190307093828.GD4634@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307093828.GD4634@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.1
X-PR-Tracked-Commit-Id: d2d833e0bf2bad221a955626b942b38312630894
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf2e8c544cd3b33e9e403b7b72404c221bf888d1
Message-Id: <155207012868.7904.14709984273964971493.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:28 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 09:38:28 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf2e8c544cd3b33e9e403b7b72404c221bf888d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
