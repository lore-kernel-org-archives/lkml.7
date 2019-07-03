Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFEC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524B5218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562142013;
	bh=2sAffZCJ8WeQ+hDqXJuWPpJrJZFJqACR7CD5i6C+7QM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZO+WmuBho7j/sEj7LzA+eZkj34q+jCexHspwsP7Kcc0cxJ5I0ItwANVno1+vhnwzD
	 xHFMXn4riapaZpGeJ2CuOHLdwyC28OCem9UwYqOK0428pjB65pIk7DKpb0MSyFuLCu
	 NlMeqyA0kJ1GD/DnRoHqL2iMqdfALNx1kgOVP8nw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGCIUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfGCIUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:20:05 -0400
Subject: Re: [GIT PULL] SMB3 fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562142004;
        bh=2sAffZCJ8WeQ+hDqXJuWPpJrJZFJqACR7CD5i6C+7QM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HmnCuzfuUOs2WH78Gx09BkQAnt9co8KeVPVOYv+a9CQ9Z54UgR9YtjsAslIKsuRlS
         8jaVecP+7s951De5Ckejw7uoWvagna8ij9AUeoWXadQL9GeYM8HxzWDtmqtpDGfnI9
         9FYamdB6cLVh4q10NS4qDiAgVX4LoEaVZYetEcrU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
References: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mteWJHa9k9skOn6by1M2CYGAU9LubUE-61TH0_3Nbgm1A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.2-rc6-smb3-fix
X-PR-Tracked-Commit-Id: 5de254dca87ab614b9c058246ee94c58a840e358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e692c3b721f30485a9124f93e27a0cb6569116c
Message-Id: <156214200438.4530.14523104438507610553.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jul 2019 08:20:04 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Jul 2019 23:54:00 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.2-rc6-smb3-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e692c3b721f30485a9124f93e27a0cb6569116c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
