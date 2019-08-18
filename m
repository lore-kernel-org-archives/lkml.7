Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2BFC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D6021873
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566161109;
	bh=nYiLMgUrXGKIpXN2ehblBaOOx9yD7IfxQF1a+juTTUI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sE9FSQGepHzv1c7yszA/N7HAjmrPxDDgc17rxcNwhINXw8K6Flv7/TnEHSeyCZR6w
	 hmUCwfon/6mvcBISMRYYyDyIkgcVwW9xPA6p4nPE4yaztIDeoFRXrFLWvrrT2v02vF
	 b8cZ5fx5ihxJoy1cz5pY9auQUeGWssUhbztrHqIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHRUpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 16:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfHRUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:45:08 -0400
Subject: Re: [GIT PULL] MTD fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566161107;
        bh=nYiLMgUrXGKIpXN2ehblBaOOx9yD7IfxQF1a+juTTUI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZEvFmxHRpUyBPi726JonFvYLQMhXCxkzKlkJxmRiPvLlVHU3rWAyKUN0MjUKsT0JE
         1ql8chb9VQLM2sCw5TG6jEFFYYfiwgN56iwQUbwICReaBdAutq+1jWfOiUH2Bw0fE2
         iHs3OC3/fIkdcvZhJawDoVvdBvGTCTAWCjXMuceA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <260502461.69486.1566157514722.JavaMail.zimbra@nod.at>
References: <260502461.69486.1566157514722.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <260502461.69486.1566157514722.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
 tags/fixes-for-5.3-rc5
X-PR-Tracked-Commit-Id: 834de5c1aa768eb3d233d6544ea7153826c4b206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6825e5a6c45dbd473f8b2993a065bbea15347632
Message-Id: <156616110763.8960.15932184598951681488.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 20:45:07 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 21:45:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6825e5a6c45dbd473f8b2993a065bbea15347632

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
