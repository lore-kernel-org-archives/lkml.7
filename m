Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A85EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB739206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570557615;
	bh=Zny/HnbAxFHT+uTu3gIjuufkIPQtw4WdhZzjsc7dSqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wrKDBPa8hM299ggVqBpcCviktPU+nUec7UVoJWDVKRcpBZFkAOHm5VnYQUXxEERN/
	 +ZGQ+ah++lMHPJPVfehMcTA3n+MiqiFaT1rU7JFQUhL0GnEwNpW7D/96kFvS4GMfz8
	 mNxyA+3qUp4Blm5m4bUlCoY7QFHuOFAvFLEzMLF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfJHSAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfJHSAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:00:12 -0400
Subject: Re: [GIT PULL] SELinux fixes for v5.4 (#1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570557611;
        bh=Zny/HnbAxFHT+uTu3gIjuufkIPQtw4WdhZzjsc7dSqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bCQjwCWs47fBZn4nOPnNaYdTdfmLP1aGies2FezU2SzmEnVy9qOtPQW4MDqfn5i8a
         VZ76NNOLv1p72qgMkiFQa3ejdE9sGkQhytEtcYz5xUAo+A33zFi3KLlnX89Kwz9MRo
         r/NaWd/SUO+WMvwOcqJcC9dUOVQAnKRWhRKJ44zM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhR6KFR+1F1eWyYEHnRfJyYhUP7RYf6=FsZOX=_m24btbg@mail.gmail.com>
References: <CAHC9VhR6KFR+1F1eWyYEHnRfJyYhUP7RYf6=FsZOX=_m24btbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhR6KFR+1F1eWyYEHnRfJyYhUP7RYf6=FsZOX=_m24btbg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 tags/selinux-pr-20191007
X-PR-Tracked-Commit-Id: 2a5243937c700ffe6a28e6557a4562a9ab0a17a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ef459167adb5d7cf76df403b4fcf79347056824
Message-Id: <157055761155.21274.2978117862183960301.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Oct 2019 18:00:11 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Oct 2019 18:51:56 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git tags/selinux-pr-20191007

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ef459167adb5d7cf76df403b4fcf79347056824

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
