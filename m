Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D4320661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551981059;
	bh=+dWOV4dHf7KqYajkAfzwHXIC4tZYpvuWInJU8t6SOxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qe9XRjb+qD3b0JTzcT1uci4Nn7XafhLZyPW8zpOO3uz/qC1S3+Njqdn+BUhPRORSu
	 2LMfDwaU+66dnYMpY/Pm+K6n89Ttpi5JFjB3EW/q0kz73Z48AZgUPuSXZM60Mrez4y
	 l+C1aZHCouctFKO0T+XMDmWdbjhtKPLTSykUjNQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfCGRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfCGRuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:03 -0500
Subject: Re: [GIT PULL] ext2 and udf fixes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551981003;
        bh=+dWOV4dHf7KqYajkAfzwHXIC4tZYpvuWInJU8t6SOxY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZHg9u+wpzs0FwR/Swr4qZ8LmCMdu8ka36HdRMijssaY+B7PMazD11QISScNjboRJp
         ViIJOqK5oiSDDXJZepCacGNycAZr3RqGuxDECv21eQq7/Dx8hWk5wejcYGacjb8L3g
         Jt0LibNbwA5p+CdfH1nS24qp5T72lNlHEIgRbl8I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301150859.GA15758@quack2.suse.cz>
References: <20190301150859.GA15758@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301150859.GA15758@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fs_for_v5.1-rc1
X-PR-Tracked-Commit-Id: 52b9666efd8b0874d334de718a7d561e7b0eb1cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9913f23f39f4aa74956587a03e78b758a10c314
Message-Id: <155198100308.21542.8386617478142938065.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 17:50:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 16:08:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9913f23f39f4aa74956587a03e78b758a10c314

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
