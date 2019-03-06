Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC629C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B627208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551909617;
	bh=USLjqtBY3foGnG6eLWpiyQKvOLcHcy69KDqUY5YJJF4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZjSlJvX7mKUERQN/ks3udn2YkytJjObtVVwL/qzU3F5oyLualSSY8UsN0pQdaEQuQ
	 KFlr/XMHwstQGkDmQqt4WsO87WvjWTSmmmH37apeB1F6JEkDuM3zweQ9dJJ41HVRvl
	 Rnv8ErC9knzLVbyn9xh9F8ekHlRDi9fTRsLrwRug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfCFWAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFWAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:00:14 -0500
Subject: Re: [GIT PULL] Device properties framework updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551909613;
        bh=USLjqtBY3foGnG6eLWpiyQKvOLcHcy69KDqUY5YJJF4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xof6SryZ2S4ZFozVjv1g+Ofpm75nXtETqxE6n7oJNcNTce+qZQ+HlXBbaSaUR0GNR
         GK1FCQudVze9o6n/TyuNU00orc5h0bnb2T4BQyIbQc9n7vLq5Z3AKbJGh2attLqpe/
         fqV+CV29Xq5F481N+mDtCr207yPF/mCvvVbLmMS4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jP3p-fnqyVLmA=Saq9MSUdhCuKpkG_NkT+0AKSNU2sOQ@mail.gmail.com>
References: <CAJZ5v0jP3p-fnqyVLmA=Saq9MSUdhCuKpkG_NkT+0AKSNU2sOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jP3p-fnqyVLmA=Saq9MSUdhCuKpkG_NkT+0AKSNU2sOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.1-rc1
X-PR-Tracked-Commit-Id: 344798206f171c5abea7ab1f9762fa526d7f539d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 542d0e583b7b366527175b2b5fc0aad262fa33b0
Message-Id: <155190961368.11982.14471870149424981853.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 22:00:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 14:24:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/542d0e583b7b366527175b2b5fc0aad262fa33b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
