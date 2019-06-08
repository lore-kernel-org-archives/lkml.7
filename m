Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DFCC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57025216F4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560022212;
	bh=6ARa66tKQ+fGJeogV72BkWlpIYpf71/phJWjxlcJuSA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tvsgjvRAZEnNf99ihkU5KH751Xt2OL5AardZHReWG2wRp4Z8/YQLWEvXX9EumGDYh
	 NSrH4qFdjTJBkQFInTNHZSZts06+toTEjvDguWEZD8ST8q3XSA0EIEl3f0yU4G2tjC
	 p8em60coRDTmS8Gc3AsWX9tVKYt8pXbFvegXgPx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfFHTaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfFHTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:30:10 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560022209;
        bh=6ARa66tKQ+fGJeogV72BkWlpIYpf71/phJWjxlcJuSA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=K0Dc08ePxaEcm0Wz1sFxFlQwrpsbA3KTXj/1+oto2XzR29NXeAlZwKwBChkqWj8rk
         KC0yFI6TCDK0KXmaWR7+K0Gy0F2yeCHvqxcPz9WxxUlLsNZxSadiv83P9PD03RY4ag
         pvNrlCz55HAwWyqJGejftKjHfUK9SIja86lMjmT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559973926.2787.5.camel@HansenPartnership.com>
References: <1559973926.2787.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559973926.2787.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: cc8f52609bb4177febade24d11713e20c0893b0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b02caa319cf73ae89aced8714066a3a5bbe648b
Message-Id: <156002220983.30045.16302787382855794612.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Jun 2019 19:30:09 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Jun 2019 23:05:26 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b02caa319cf73ae89aced8714066a3a5bbe648b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
