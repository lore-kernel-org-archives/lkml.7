Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C88C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 17:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A681720869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 17:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573319709;
	bh=CHAMDvomMycCVovfDjJci7gQrU4YFUKl1RQe9jX8loM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DghvXshCMeaBj90wvPIFrnB/gXx8fXinTPbT3QInRAv/Dagd1ZIBJRMFaAwxHFBgA
	 zqaCsPDm65y3BHeGk44cly+K/HxaSATXSZs9pfulG3oFB18hIA7KtH2O+qy+g/X0ZX
	 d/0zOfXeJpQUXtOHCitZR4qQPuwTg9jA92hHv0vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfKIRPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 12:15:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfKIRPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 12:15:06 -0500
Subject: Re: [GIT PULL] Btrfs fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319706;
        bh=CHAMDvomMycCVovfDjJci7gQrU4YFUKl1RQe9jX8loM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KPvWL385y1KbO1SEcfduauVvPRq/58FlAzG1Hk0uxqytNDmpspJBsq1RELiP+3hNS
         oneoMKq/YMZNucJ4E6EgjYO48zhqXUDIxX/Bc2WlMBT6xaXbGLe2Zu61f54rmbEdoS
         /4pjr019c+E1IdssfG6O1vjEn5oZYwUCs0+T0gIA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1573307154.git.dsterba@suse.com>
References: <cover.1573307154.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1573307154.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc6-tag
X-PR-Tracked-Commit-Id: a5009d3a318e9f02ddc9aa3d55e2c64d6285c4b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00aff6836241ae5654895dcea10e6d4fc5878ca6
Message-Id: <157331970634.2485.6390832820143405110.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Nov 2019 17:15:06 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  9 Nov 2019 16:07:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.4-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00aff6836241ae5654895dcea10e6d4fc5878ca6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
