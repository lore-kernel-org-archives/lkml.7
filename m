Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C46C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17B521871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554514811;
	bh=YXZ9FMEA2Est/x4K+nwdos5g0Bip3/NQVHQBzH/IG6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ewYir2tWOJWk6zVp3LuyKqRIVKsav5GqRTy0X9MzmAnr4DE2K/d7dgfsbkJeXUo3A
	 hKXteqiCSD+yUaj/bBwFRTFkRiVwBKF8jXMbXcmIUtINcmM6qMZ+tqFIGE4bxKSbni
	 WjbykYstv8xwK20m7+CeX1pyYXKjeEndJholwN1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDFBkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 21:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDFBkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 21:40:07 -0400
Subject: Re: [GIT PULL] VFIO fixes for v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554514806;
        bh=YXZ9FMEA2Est/x4K+nwdos5g0Bip3/NQVHQBzH/IG6w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1jm6oLTS2hvUUYA4M9ENrOGsNtRabXvQjo5FqBs/9bEn7QgEJWGKcjVyK3v6s5DT/
         B5MnOF6wmCyx74b0h2HLUaPc99Nggi0ZgOjU2OLam2gfVi+kMOtxujk4PHBdTYCSsY
         juXKpNKDcsfJxrTF8SK3zc00neNpx6fW80XmomJw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190405084648.67936128@x1.home>
References: <20190405084648.67936128@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190405084648.67936128@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.1-rc4
X-PR-Tracked-Commit-Id: 492855939bdb59c6f947b0b5b44af9ad82b7e38c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e28fb0fcb69dbedfe254939143198b46d83bfa1
Message-Id: <155451480634.21678.8306720368455112191.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Apr 2019 01:40:06 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Apr 2019 08:46:48 -0600:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e28fb0fcb69dbedfe254939143198b46d83bfa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
