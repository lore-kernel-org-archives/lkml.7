Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570C72073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575394222;
	bh=ov6uYvmyeKZThHZpYr+zuN/valNM2WOp+h5tx8ytMZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PpgFzfQmXsxKGVlRo5obE696MMXkjC7AiLtOBdjcmAnTmukPQ2e9x9sd4fBJiQMo1
	 ysL9InmBzePyO5Daqfiz7N4wZeqTgV5mynIcd/BOjIdRbT7cH2F2RtWz1bnDAMFAfs
	 6gYWU5ZnGlHRsIJFcAXMIpKRBl+mD+74ACTzmsnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfLCRaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfLCRaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:30:19 -0500
Subject: Re: [GIT PULL] dmi update for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575394218;
        bh=ov6uYvmyeKZThHZpYr+zuN/valNM2WOp+h5tx8ytMZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XdXV9ZfG9hW0VXuaUsOzMhEhiKtNT2vz3IUvIC34tEWl0eZcfANCNE+qQkpEsMp1E
         tJvBGNKE7526KWvp7BnN7H0T4K8Fz5U/nLDQqORznHzywvB+TFQ6ANOKDrOLtRicpE
         /kL/C6gdWrSHexb8hEBiCJyPaQEaVv5gVmYBfbTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203113938.4fb05398@endymion>
References: <20191203113938.4fb05398@endymion>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203113938.4fb05398@endymion>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git
 dmi-for-linus
X-PR-Tracked-Commit-Id: 7c2378800cf7ac87e2663afa7f39d102871f0c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dff2a1c9b7cc83529119eb04cef1d7b68e11352
Message-Id: <157539421889.1633.515262804046240070.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 17:30:18 +0000
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 11:39:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dff2a1c9b7cc83529119eb04cef1d7b68e11352

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
