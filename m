Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F9E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566930911;
	bh=QNonnFB2XBEkrVyXZVSkrv5fxlEjqZVDCyNMphiBIqI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0vzwKwYwILoUyPyEBoNkZ6c/sY2lwchRo88N6aSfAsQZ3cbvSRkzA0oE5ULG/nD+/
	 u8ZBM2cGrYCRSYpaELptHLT7wv8ryebIfsLMZAndKKwhWGXUgdSC4CoC2TRtbpdRQ2
	 aMLyHwLjOjPr/oXY4iR81ogKaRt5YWAqOyzy6XkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfH0SfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0SfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:35:08 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566930908;
        bh=QNonnFB2XBEkrVyXZVSkrv5fxlEjqZVDCyNMphiBIqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vVFe3AuGYbYoh909zxe6Ai//S1qnxrVvRtIU2G813NzYNb6xwOcMLR4U7mITJNh9q
         m5oP2JTSjUQLMSrd/SSxMmLGOZkQRyjW2DmnHO9KMAae5fB9i9E5bXfVQXW3y4vMAR
         euhXEtBWSJjLVJ8bMw07HPyVd5fRveVSwSt3jnIc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd0grj6g3.wl-tiwai@suse.de>
References: <s5hd0grj6g3.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd0grj6g3.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc7
X-PR-Tracked-Commit-Id: 2fd2329393658514db074abd4f7dea8da1c20f81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0004654fb14859e49bab66aba881d64f605682a4
Message-Id: <156693090822.10894.12122796032643471390.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Aug 2019 18:35:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Aug 2019 11:36:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0004654fb14859e49bab66aba881d64f605682a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
