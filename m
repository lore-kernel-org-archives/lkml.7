Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F021D2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553289614;
	bh=56k4PUmxf0eR/jJMtE7fG+LoZOecB5iKy58be7Vrl4g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ImwDlq+Cc7yZkI18Bz5EUEYnx9e4NQ1JhFHod+CGmhG9V3veQuM5+f875Cr8wtcbk
	 TOdqcwnQ0jkq7CUkP2wnJCSPgIGHNcGPaH5PDE/LMPkLxNSUShdRgRe6S37oABcVcD
	 SxweEgesuy0bbq38hnru3kaRh4r86lpJA9BAN3yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfCVVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCVVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:20:12 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553289611;
        bh=56k4PUmxf0eR/jJMtE7fG+LoZOecB5iKy58be7Vrl4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GYUwHfSfpbRitcaChhjmUm59AB33OwG2l5rfspGERABM4ov7AxV7RRmxrMOjsGf9j
         w/u9OIfYQTJz1PumuWvlCTasYEaOplkzYYGYixHLptr+q0aXZuWclQcPg0ApPYt9oo
         SLdC1qu6tFJxOVMei3+vP9zxAxXBUHWhNieNcUEQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h7ecrb2hz.wl-tiwai@suse.de>
References: <s5h7ecrb2hz.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h7ecrb2hz.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.1-rc2
X-PR-Tracked-Commit-Id: 667a8f73753908c4d0171e52b71774f9be5d6713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcacc4864f03e138a8b757ce75142b602d7f4389
Message-Id: <155328961151.19902.16543580859214749573.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 21:20:11 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 11:57:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcacc4864f03e138a8b757ce75142b602d7f4389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
