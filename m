Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD58C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24203215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578079511;
	bh=eIkzej8kQCG0C5j5sDgqo6iczqY0gMrQNGNBYC/qlPA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hbl/wxLQWZbKW5s35oAege24bTu0bA3pEttBwqfdbizLhi4YicLN9vsVGsjqRzSnJ
	 vu2M6MWTAm/dgqd7QfSJngef5r/xHQVmXNjQP9A1bRoW3APNyOBF6eHd1ILMtUGcE/
	 IM08WPV60N1E2L6Jeo5H3DzL/tdlPGpCFYjLYiEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgACTZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgACTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:07 -0500
Subject: Re: [GIT PULL] sound fixes for 5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079507;
        bh=eIkzej8kQCG0C5j5sDgqo6iczqY0gMrQNGNBYC/qlPA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=glbpvJEQE76Z5O1o68On51rAp1zCXnS/3qOa+C5906FuLbYDCDDA0d3iIqPa2OhAa
         wuHs2kz9KdIrxvv0VXOWG/LJi9sdFKnmYr1PsEpYEinTewjrj9ebEMHiFYWqdyay5o
         PKQR66TcBKqGgfmKTGV+QgFZ1R8YJL3XWj6gU3Tg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblrlj6yy.wl-tiwai@suse.de>
References: <s5hblrlj6yy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblrlj6yy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc5
X-PR-Tracked-Commit-Id: 48e01504cf5315cbe6de9b7412e792bfcc3dd9e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e35d0165908ad2d2bdb76773ef77b551763eedbd
Message-Id: <157807950725.16643.6042970373475461519.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:07 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Jan 2020 09:10:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e35d0165908ad2d2bdb76773ef77b551763eedbd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
