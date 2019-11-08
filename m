Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EADC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED058206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235712;
	bh=LK9hwZt3VZD34A6IiTFJNZvFkBUGyeiapHGvJoTWu94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZRTuOhHDxZ1p8lVtu56V8pX0JTBSggh2dSV9dgohgi5iLsfcYDVdMrP6pJFJJQqdp
	 O9HR5evIOYFS7t+XMUsFReZXFJGj1NdmJHPsQN6fJz9ay1Wu4N6FO6UF3sxTDvh71m
	 f3yJHvhsZSQ48aDGAcFE1bNYMoyt8ihYYsmn/kGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfKHRzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbfKHRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:08 -0500
Subject: Re: [GIT PULL] arm64: Fix for -rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235708;
        bh=LK9hwZt3VZD34A6IiTFJNZvFkBUGyeiapHGvJoTWu94=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pheZ+s1Blf6seTLqZeoLwcIUBGt5PfktZzLZmFmJCRqIRCIIy03mF/bbCkFVPosnp
         mqMOWI4aODD91K88QoPbLwda5L6QF76EVmR/ELjjwv5AGoQBBSBzdD1iuEjPHPcyE9
         Dffa5QTB2fel1Ue644OAO0lpYWnnajwgtnpTzn1s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191108103231.GA19153@willie-the-truck>
References: <20191108103231.GA19153@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191108103231.GA19153@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 6767df245f4736d0cf0c6fb7cf9cf94b27414245
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e8ed26e6062e4f585fe831fba362eb567648881
Message-Id: <157323570813.12598.9228674931391309121.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:08 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel Mailing List 
        <linux-arm-kernel@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 10:32:31 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e8ed26e6062e4f585fe831fba362eb567648881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
