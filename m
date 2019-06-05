Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5999C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA482075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559768720;
	bh=cyQH3GYnfeiQJO/PytW37b9r+gkZcksyIemUtq3gam4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PBg5W0EPFc6qC/H8jRmJYk8KlsJsaH/4f0ZPJxXHc4mpoRmSchOLshbNstdalm2RV
	 JpHlY1s6PuYMR68iOZH+ZHcRuE5MbuYle2qBIU+xQvxvxUFrJn9B97xgkYFHvWFGr/
	 6aBNU4+6baEcIHDvTauawMxXNfL1PbhYAiYL0wCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFEVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfFEVFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:05:11 -0400
Subject: Re: [GIT PULL] pstore fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559768711;
        bh=cyQH3GYnfeiQJO/PytW37b9r+gkZcksyIemUtq3gam4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c0r9KV9DPXyc7zmK7wCcDa3t3CRRuWXRdOBRcil7p4IdBU51piXtEatOsUYpuHzQk
         vFDBFwjwuxaa4YM0ODWA1JzY4TrJbCgjSiK+VoJw9fuag+rZONWPTtXT0ddHqTjh/J
         kfZGRUme+3uge00DBFDzHU/TpcV4a2g4fntZItC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <201906042018.72255CAF94@keescook>
References: <201906042018.72255CAF94@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <201906042018.72255CAF94@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/pstore-v5.2-rc4
X-PR-Tracked-Commit-Id: 8880fa32c557600f5f624084152668ed3c2ea51e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47358b647550d99d68b0d6c546355ea96e010efa
Message-Id: <155976871093.18999.4118784503291051346.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jun 2019 21:05:10 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>, stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Jun 2019 20:20:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47358b647550d99d68b0d6c546355ea96e010efa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
