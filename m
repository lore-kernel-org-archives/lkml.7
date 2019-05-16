Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D3C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3D2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558030826;
	bh=fSkzpF9V98nFOAyHVCnUkytPKbFO2R8+Oggq3O3BIdk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xSCwGyBrz3Ii060+L9ohgVpybHs9PpaZdZG20sNZxLbq6DshqgTEXgmS1qcsBlVIs
	 r/Fq8mnrrnsez6e3mytXSBwtb+siC3FaO12vvK6jfx/E3j++gamr9ksBM/BzPWmrSG
	 +uyXIJaBZz34hiatvDD6v/wTB80YOyYccstow4UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfEPSUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfEPSUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:20:23 -0400
Subject: Re: [GIT PULL] locking fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558030822;
        bh=fSkzpF9V98nFOAyHVCnUkytPKbFO2R8+Oggq3O3BIdk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pWRaBGcx3RGwenpQ2aoUeCTkJxj7PUG1UykSKpFtl1114P9AWwyuUK5i+yjeZzIfi
         erzbmNFjbjZxOodeXCYq4WBbaMElkoLqix94rzyauiH4sbNfrYXFN4JfHkxjPcppHe
         kFslnrHNVaCGBJuPOvAyz44Ur4C99GNEIF50SCOs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516160135.GA45760@gmail.com>
References: <20190516160135.GA45760@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516160135.GA45760@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: a9e9bcb45b1525ba7aea26ed9441e8632aeeda58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f57d7715d7645b7c3d1e7b7cb79ac7690fe2d260
Message-Id: <155803082273.23531.9745300198455976357.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 18:20:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 18:01:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f57d7715d7645b7c3d1e7b7cb79ac7690fe2d260

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
