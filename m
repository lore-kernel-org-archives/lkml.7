Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7040EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4108B2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553289615;
	bh=ayaBnWDYrJhYMUIvFOaEKWFfqVvNlW5uzh1k3LUM9Jc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TyLW44+1tW+ed2ccHi/zUFZ2IF1OULrbwzJBUmGszP/6WzZTFDQAS/PsHd8jNSxKb
	 QM8J+W6WphylxWmHgvZZbIvPbgwhhx41op/O1bMORSF2xLwLd8bny4tE35Ub8pfFsb
	 kSN4noA4wMlRbedXTWqstvRz6VxRGdxqvLe3h4u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCVVUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfCVVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:20:12 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553289612;
        bh=ayaBnWDYrJhYMUIvFOaEKWFfqVvNlW5uzh1k3LUM9Jc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=utfCMduU7qkQVuH72X+aCtFXgAfrox9cuh4vu1Ly0miprV9U2SEN2V3aDd0VOGBxB
         Gw7b7am0SvfNpNTjjih41NTJRZz5Z2vPiMY4iBUfmVswWzuzNbH+EiZOcIQdrJ/UxR
         8FRMT4Py5qjojX5nijaYhDLhFPbE/fjpsMNUUFwE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
References: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h8bvcbhb.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-3
X-PR-Tracked-Commit-Id: 92edf8df0ff2ae86cc632eeca0e651fd8431d40d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ed1e96cafde5ba48638f486bfca0685dc6ddc9
Message-Id: <155328961210.19902.16718865326587161945.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 21:20:12 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ben@decadent.org.uk, christophe.leroy@c-s.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        malat@debian.org, mark.cave-ayland@ilande.co.uk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 23:58:08 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ed1e96cafde5ba48638f486bfca0685dc6ddc9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
