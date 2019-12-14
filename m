Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D7C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493AF214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576361114;
	bh=MHVgBtKBuET2ugZK+j2xQ62Yk8FXUQ1ZTdXpWM6HcD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gHCiPruRocX+ImAFOq8ZusgPSzuxGQqWwMNMB3iDM2T9hGWw/qksPz0XBtA7aXykj
	 LD6ligXO+fcSvI93qZ1lkOY8zLH5DEX9c/JI4dktvA4tXKn1Tgypt1hh1HLVgIfu0K
	 tGIxJCwSv7i8LK8oUZhRY7oZ8rgjBIqdKaecOAEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLNWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfLNWFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:13 -0500
Subject: Re: [GIT PULL] 3 small SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361112;
        bh=MHVgBtKBuET2ugZK+j2xQ62Yk8FXUQ1ZTdXpWM6HcD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tM/ul0ajWCehzilWxwsdcYC3LYSvTB660LFFHxDr8zVotqS28fbBH4+3hfBpGus9o
         hfyeEG4Z3dNPGRLO0A9g2thCKbuAvrEFpWDxnXP0ygu2HGIn4rhFj/coMw9ZCMOv4U
         wX8493xp64E/fLDLd0Z8uYUMkZSSMa/bBT6dyVyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msFp3RCtV_YYJSewKRMQFMTMRkEN=wHDEs8MJza162S0A@mail.gmail.com>
References: <CAH2r5msFp3RCtV_YYJSewKRMQFMTMRkEN=wHDEs8MJza162S0A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msFp3RCtV_YYJSewKRMQFMTMRkEN=wHDEs8MJza162S0A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.5-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: d9191319358da13ee6a332fb9bf745f2181a612a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 103a022d6bc5962947f36414ac5c5d4d3d3aaea3
Message-Id: <157636111271.10255.13565333221787750981.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:12 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arthur Marsh <arthur.marsh@internode.on.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 23:56:33 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.5-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/103a022d6bc5962947f36414ac5c5d4d3d3aaea3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
