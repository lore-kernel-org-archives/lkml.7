Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE26206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257059;
	bh=51hM4CQqdV2f78d5jrbXdhcrvb2/VAEZ1wXCHPXBInw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=J2ydAsAhX0tet/nD5+1cJD5e8LUZhhTcJm2AHURMpJfzNUuzvSGE49E8mhmRA/toY
	 A4YplJj/tT3HkJZSvw0h/p50vAZI+hqQOjrmggBxV8d/7z5ltOnUqHAITirHWzckNl
	 WpYewC4Yns8bmms0aq1SG+iaRJhLpG1764BCZpRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfCJWa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfCJWaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:19 -0400
Subject: Re: [GIT pull] core udpate for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257019;
        bh=51hM4CQqdV2f78d5jrbXdhcrvb2/VAEZ1wXCHPXBInw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NAc3Vvii3VmIw+Uz+mNQSog5oFoTDr6hnQlcf2xvE38dLeHYD+9FLWM93PAsHEs+R
         Z9Tm0uKxoj2NWgFt17RYUL3JsbItkmeVtk+JkbHMloSg5dT7TTKCW58BKBjhaV3cjb
         Pomz+IANxkYkYkncFv+x2vpa60xD2GF2NzQkcvnI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-for-linus
X-PR-Tracked-Commit-Id: 11295055526308ee71d82dc97f0a9ca2dd61c3b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 077d3dafe63cb26653f2b171fa102dbefd242fa8
Message-Id: <155225701920.14748.1114245126266144868.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:19 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 12:33:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/077d3dafe63cb26653f2b171fa102dbefd242fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
