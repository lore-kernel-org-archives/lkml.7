Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CDC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FCA218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562260206;
	bh=wUPuiCtsjKFMCYJwXnPf2S8IohnAIH4M9GvNy802eGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2h0mRCgeiMXSNSM2l7b+O6xNo7eHvZIzhhG4pksiTOcnT6X4cETQIeAvmELg74g9R
	 nVOFejeuWfYqhM7CNYpn3TQVEyxOFCi/7ROTPgnNENYXZcsr0pHRoX3GgkPnNkMLJl
	 6lVgKMPM9z9pkYdrjEmjVTUGyjl9tpexzwn+Iqz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGDRKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 13:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfGDRKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 13:10:04 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562260204;
        bh=wUPuiCtsjKFMCYJwXnPf2S8IohnAIH4M9GvNy802eGE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=peCfyuGT1OBXfWgwjeYY+MMupoOFhIrCFvqS5ylBKRre+Yjtt8HmLPOIRuXScHdeE
         eMLLoTwCrPY5C7chTTEtyj0iOQcZXV0oSlFrMJPIa1W+hHl37cAnq6sXBDZPM9e7Rl
         1wL0Hf5dlWXdahdiLJDOMI5aAHCNI2CgWKmcSMXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h8ste2kn4.wl-tiwai@suse.de>
References: <s5h8ste2kn4.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h8ste2kn4.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2
X-PR-Tracked-Commit-Id: 3450121997ce872eb7f1248417225827ea249710
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c212ddaee2fd21e8d756dbc3c6119e3259b38fd0
Message-Id: <156226020401.21087.4911880582513267664.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jul 2019 17:10:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Jul 2019 11:50:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c212ddaee2fd21e8d756dbc3c6119e3259b38fd0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
