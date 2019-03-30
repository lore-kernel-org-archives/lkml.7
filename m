Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BE9C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870CF218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553967012;
	bh=EyKqNWXveJrVL5RVtA3bwZ6dKrtjdVnYU+NV7wFZf1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MoWH+aJbrjuyQTHjKCPIhMFaBpZZ9S08xep8bycRPDE+nZm0lMrkYtjjoMZDamdUI
	 3gj0YsfzZKHRcmpZtjq3qXyu7XNvrzTrqFQxqRXsfd18ydqx3s3DSSEruf56fJwAHE
	 Gy5punnN3/6TOapNgiFR1a64u+cu1jgQ3eVYV/FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfC3RaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbfC3RaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:30:11 -0400
Subject: Re: [GIT PULL] security: yama fix for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553967010;
        bh=EyKqNWXveJrVL5RVtA3bwZ6dKrtjdVnYU+NV7wFZf1s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0x9aS1dUuH+0wx6dCg1zAnpzfEbpEibJejJUZXpJYb6XHCoG4QA2cOgkn1qTv5MX1
         zvHkrPkU+1O8Eo5Ql0HJg25yVV5uWR1fy28VZJmEqNehHW6B9+kkOyMHKRGc/sORx/
         QP5pkFK90x4zl2Gni6w9tUrCxQ5CgyTugrpgRSM0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.LRH.2.21.1903300509370.689@namei.org>
References: <alpine.LRH.2.21.1903300509370.689@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.LRH.2.21.1903300509370.689@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 fixes-v5.1
X-PR-Tracked-Commit-Id: 1aa176ef5a451adc0546d5aaa3fb107975c786b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2623c4fbe2ad1341ff2d1e12410d0afdae2490ca
Message-Id: <155396701060.21865.9531580107142815993.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 17:30:10 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 05:10:48 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2623c4fbe2ad1341ff2d1e12410d0afdae2490ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
