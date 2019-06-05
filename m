Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCA9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BD72067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559768716;
	bh=7Ogci9JEpKhj/65VAOrZPYvZYwcKZySIa0Yp5JMipFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kn9+uNHZP+fMeMThLc7O4LVKxvPGaT2H8uUFDwy11cDCofr+wptGNWFNtJ4YNqm/i
	 5hhZUVugNWhaSvqF3WNW7LL/oD/wAhdO9lPTG0cuHA8xjI/QW15oAi1FnZdBEhfMRN
	 Pl6JWEZjX3uTRtB0mE50UMYYmoWvQMIu8r9ZRNfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFEVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfFEVFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:05:12 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559768711;
        bh=7Ogci9JEpKhj/65VAOrZPYvZYwcKZySIa0Yp5JMipFg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xI03xAOurzcfeeoDES3cxGbkqgB7jMWZ3CoJ2y83fY+VgQyCcURFuNHOAMvCFwW3o
         FjYJoe4+rQWg59lLSFp+D3ePCROy9kBRhWGIiYnxBBzEGYXyPOQDIhEkY8KzA2p/F3
         x2z2hb4c+w+T7MoHFutDkXDvRTtXdyLpnNJQoTpc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5b4091c-b6bc-0eea-7f64-5334c80be8ed@linuxfoundation.org>
References: <c5b4091c-b6bc-0eea-7f64-5334c80be8ed@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5b4091c-b6bc-0eea-7f64-5334c80be8ed@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc4
X-PR-Tracked-Commit-Id: bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 156c05917e0920ef5643eb54c0ea71aae5d60c3d
Message-Id: <155976871161.18999.637200453870389630.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jun 2019 21:05:11 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jun 2019 10:53:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/156c05917e0920ef5643eb54c0ea71aae5d60c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
