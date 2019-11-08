Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20906C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6E1206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235722;
	bh=d1C4mgO/HKSMG9rD9o/4sdqLcCwbFaGI+JCz9cfdufA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ODOLCWc//6VTzg7oFjd7mjXsFB0Fk7chIi95KLLxySeVRZS4k2BrDqZgxQmW8JoVV
	 4ON4rdCx2RHnKOex8BU5RxYgRs/6WymqvTh4yEmQN9pdLfLK06MoNTZJHqytq79owp
	 vVhQ5sR9xSgxsB/8GLiKzNGvzhyWWR8RG1WFNdaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfKHRzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfKHRzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:07 -0500
Subject: Re: [GIT PULL] sound fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235707;
        bh=d1C4mgO/HKSMG9rD9o/4sdqLcCwbFaGI+JCz9cfdufA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F6Cp/1pXHsF8acbI0FwrxKiHlvKmmPSNnudC634JDoQQfwUD8kFziwA+gs0wW7Rou
         UnJdUCzT4Ibjcg12M1SPisYvLVTcE06jc2TiAEwnkAv0LT/IrcOR9LlOeS5SnMJJD3
         3dKnWsLFe2cOCaV6cnrygRIouG4Vl/QI20lgAKnQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h5zjuaihj.wl-tiwai@suse.de>
References: <s5h5zjuaihj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h5zjuaihj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc7
X-PR-Tracked-Commit-Id: df37d941c4b5aee9259ab4e34de8bfda384f7681
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ac2a114b1144a5d5f9043e67c769f21a4512c2a
Message-Id: <157323570733.12598.15586352132728332128.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:07 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 08 Nov 2019 09:18:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ac2a114b1144a5d5f9043e67c769f21a4512c2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
