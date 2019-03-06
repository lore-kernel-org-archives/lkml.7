Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C649CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958D9208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897093;
	bh=YgbS39uKL5nvUDycdQdmgSCoI2MczBURWxYt+chj9Ys=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Txgh5bWwpWyJfPkohznbC9qupcMPDMMeZO27Y/x/EU8ofuJb/y6P7G609JXFqwRA5
	 g6HbXSu39O+1hc1Uo3hO+XlN1LXQZljzymqOHvcmotn0nrW0hnixKG7/pfmkSuW57f
	 YXFEBn8fVXIwKO0qRE7oGxS8n6Ub490CdMpVlDQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfCFSbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbfCFSaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:21 -0500
Subject: Re: [GIT PULL 6/6] ARM: SoC late updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897020;
        bh=YgbS39uKL5nvUDycdQdmgSCoI2MczBURWxYt+chj9Ys=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rsyYuUezhF4jv3h9E1aXQY7XoBNllqAlOjgHDtq8VBiJeaqZDCOveWzqVzhOO61Te
         GVl21xl28C3yiHpLJrFd9S3IKumeY4GKUBA1gIuLTt1U4k7b0MphFSS4dfscVh5bjo
         lsyKYHLvjSh2TOnTornNF+1d7BMSORdPLOCWREZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3Daeqb3hfYvR0P=mjyONZVavfMbK8As8X5G+n4+k6sSQ@mail.gmail.com>
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a3Daeqb3hfYvR0P=mjyONZVavfMbK8As8X5G+n4+k6sSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3Daeqb3hfYvR0P=mjyONZVavfMbK8As8X5G+n4+k6sSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late
X-PR-Tracked-Commit-Id: 2547635054af399303f8b91292ea121e13b84bb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afe6fe7036c6efdcb46cabc64bec9b6e4a005210
Message-Id: <155189702089.14612.9086012266956571743.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:20 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 16:38:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afe6fe7036c6efdcb46cabc64bec9b6e4a005210

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
