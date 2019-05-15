Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AA8C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940E20843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557971371;
	bh=Oi6pljO7qro9G22/ILfgQPC40WJKRUY6nGH93SqfQqQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HpDrLv33JwyovKZyAq1B5NEQfTzwSX0rnU8DwcRkvtoQdjsR5jBYHLOBmbRii0Fmr
	 Mokm0+3xWiaLK+c9r/UEyqMYCde7D2BDhkhZEohyo+u6EYpjAVeNs428fNBY6xwOqf
	 x1NwCA0Se0DqircnYl73t9Tk5x8njv3ix+O/wL4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfEPBqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfEOXyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 19:54:21 -0400
Subject: Re: [GIT PULL] ktest: Updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557964216;
        bh=Oi6pljO7qro9G22/ILfgQPC40WJKRUY6nGH93SqfQqQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Mz3KQNTuc9Qg+df9b3fMIOfTByoLMorAKrK5/Hh7S2sipKM8ZRgjhhuBDZbbgYmf3
         mz9PMb1LdBY5FoiLrnRVdebvl9IHEAKVpvfxdBEEwBUYy0qNy8rTj90DQX7fhx/5Ib
         e5qS3O1QF23ry7FGfUNJjkkS9E6kgd3sFDM6Y9o4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190515135602.2a6e6012@oasis.local.home>
References: <20190515135602.2a6e6012@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190515135602.2a6e6012@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.2
X-PR-Tracked-Commit-Id: d20f6b41b7c2715b3d900f2da02029dbc14cd60a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b06ed1e7a2fa9b636f368a9e97c3c8877623f8b2
Message-Id: <155796421651.28278.7215838280159174377.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 23:50:16 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "John Warthog9 Hawley" <warthog9@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 13:56:02 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b06ed1e7a2fa9b636f368a9e97c3c8877623f8b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
