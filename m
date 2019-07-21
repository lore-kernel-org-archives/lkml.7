Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6BC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFBF205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563730531;
	bh=/S//mateIPhyQjzfkcmvtqohiRSJ0nruDIMdJzdGzbY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ERKyjPvkpEODUBfCfd6MULd2s7+07Sxfz3JvyRXvcVOjMcdXkCDhxgAxBBmWAyR3A
	 Of1RwR6+ZDxu8lIm3vZ/sbZLUO4k1Uc8pz3ggu3u14arvVPqaJ34d9f3/OU8tc+PMo
	 KOcgrjCy4XmPjKQWoygfou0gYamTAlSIfsTh8uAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGURfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 13:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGURfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 13:35:25 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563730525;
        bh=/S//mateIPhyQjzfkcmvtqohiRSJ0nruDIMdJzdGzbY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VUV9Xi+lGNL48kD9kSaagWc84itXwABsATnMzM1IrtPNuVQAhH9AdYr4Qa6RY+Gbx
         ew3Ubbmgb5cR1+5NeUws4xEN886k453tavTqEYTnTjp63ANRFvOT5/XAybeq3/fadG
         kXAZMnOP+nIcxJRySl0A5Gn0+uZMYpv1LiiEemKc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLTAAT1hEPkxD=BUvmovvA+rdsZdbVfQM6=1m9bvaEysQ@mail.gmail.com>
References: <CAL_JsqLTAAT1hEPkxD=BUvmovvA+rdsZdbVfQM6=1m9bvaEysQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLTAAT1hEPkxD=BUvmovvA+rdsZdbVfQM6=1m9bvaEysQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.3
X-PR-Tracked-Commit-Id: e2297f7c3ab3b68dda2ac732b1767212019d3bdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7bf0a0f3703bc145368b9ced02749bf75fc718d
Message-Id: <156373052497.21043.9914828581045231482.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jul 2019 17:35:24 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 20:37:56 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7bf0a0f3703bc145368b9ced02749bf75fc718d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
