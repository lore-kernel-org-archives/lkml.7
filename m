Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258FBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F3F217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628218;
	bh=ugqay8BEMhqxfTYOYOlMOv29oKO2IDJWEcZJTSqh9XA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kMH/17eS+lqG4D/DoIHeaBMI16eifGedODZzq/RNsAS6y+VLowKIyZ1yTSllO9p6Z
	 X4HZq1JBm+v4WNtahdV41BdWegvPLrnVSLPZ3fH+2o9nK7hfGmOQkVbJ84m7zbd84L
	 bv9CybPhAAjNv7xwXxR124N2XlxMm6PExzZmI1LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfKARKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbfKARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [GIT PULL] arm64: Fixes for -rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628206;
        bh=ugqay8BEMhqxfTYOYOlMOv29oKO2IDJWEcZJTSqh9XA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NPYjA+kLd/+WXxKj9xtdez21YHyEUJ4bD2Ooe0slsSUOxvbEqwTYRTI9Mum6jcwNC
         rJoVs2QaIK0kuJrd/qsEOrcONub0mfZjTQ2KZsZixIAJ6HiSIC15gvxX3jyo/yBr31
         +STfzgq3ClP83lr6C7FQ4uUecI/tF04E3VCTSyUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191101143240.GA3287@willie-the-truck>
References: <20191101143240.GA3287@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191101143240.GA3287@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1cf45b8fdbb87040e1d1bd793891089f4678aa41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d540c398db780271a81690eeb2bbc61876c37904
Message-Id: <157262820650.11375.14637444805249233372.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:06 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>, peterz@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Nov 2019 14:32:40 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d540c398db780271a81690eeb2bbc61876c37904

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
