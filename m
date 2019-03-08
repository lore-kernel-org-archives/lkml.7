Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB964C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCF82171F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070126;
	bh=jU2GFsNk65DUxjn5IZL7acvFviNkU3o+dkezPO9X2Os=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ss8eW3Iro95O8o6t/BjolHAVVeBbvwxK0qADjsQfRl6e+kimEbW2LqxHXA7wnyzSH
	 HQuq7ig8hW6QUBDx8Fiv7soeZgdjc9MMierE07m5QW+zWntMSBt451kpZoIo9nKkTc
	 JWx38gSuEczccKNVkE4isbqRMuVStfeSyxhUtH7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCHSfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfCHSfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:19 -0500
Subject: Re: [GIT PULL] EDAC updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070119;
        bh=jU2GFsNk65DUxjn5IZL7acvFviNkU3o+dkezPO9X2Os=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=btPyWA1BXM0bzXQ8UXfa40WYzX20kcyRlpsojW+LlyNAc0W5WEIHMN6iUitE625Lt
         PuGG2RhvHzUWO5bKcyeaJd2bnaE+Vfk2HivZ6mLOZzq6YfsQtAnzp7DA/OhZIw6993
         VU1s/Bkq8cA34ZI3UalqOSNrRMxvf7RnirkJz7Xw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305102156.GD9073@zn.tnic>
References: <20190305102156.GD9073@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305102156.GD9073@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
 tags/edac_for_5.1
X-PR-Tracked-Commit-Id: 580b5cf50ca8f4781961382d54959683341b3126
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b37b8c48d2c2d8553f116ec2a75d21056f1fb35
Message-Id: <155207011911.7904.17915615656049419423.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:19 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 11:21:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b37b8c48d2c2d8553f116ec2a75d21056f1fb35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
