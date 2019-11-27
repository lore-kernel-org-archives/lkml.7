Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52DDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859A220835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574828413;
	bh=o6tJ+MZHpzs6KnmmJDSNGf9EvQHf9tNt3v/2+cah1AI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ulcCXeOYy/4/ekgOg0DuhCLwdJ1jB9S/tUcLlrNL6/ZOI45LbsQu4JeOdmroouxEX
	 BAIlDD/jtO8AYwlwgG5dFKlaB3UWR5g1IbQcTJ7gPGO6hsae/hzIzq6DlLxq5NTE+T
	 qQe+aQDTsqRkzIAx56TELYlFeYL0VAk/Wbcm1LrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfK0EUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbfK0EUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:20:11 -0500
Subject: Re: [GIT PULL] sound updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574828411;
        bh=o6tJ+MZHpzs6KnmmJDSNGf9EvQHf9tNt3v/2+cah1AI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v+3AoSetTZBdf6EqETdiwmk3bErvPLLjHtx4aFeSAHufIUnpaGcMf0ABNr73ehddD
         5TJMBHdEMm+oMGgG8/2BPm0fhNp9QlozF2nB2rQ3mg/YCi6gCVUXlSW3KvQN3ZK58Y
         /fh2llwUuGT9Dp5BnPw/qe/+6LghJNxEBJA5L6J8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hlfs3nhls.wl-tiwai@suse.de>
References: <s5hlfs3nhls.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hlfs3nhls.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.5-rc1
X-PR-Tracked-Commit-Id: bf2aa5cadd1c7bb91af4b5b1218e643cfffb5c9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f1b210a7f97f7e75c56174ada476fba2d36f340
Message-Id: <157482841129.9403.13617322704842526447.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 04:20:11 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 09:53:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f1b210a7f97f7e75c56174ada476fba2d36f340

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
