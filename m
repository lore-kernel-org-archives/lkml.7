Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D70C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A0A21743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 03:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565408109;
	bh=OOXbXwHQTreQVAz2Vek7YgFKOXX2vpVL5mYcPg9BRLY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=P8FQoOkqqufluItipCvIXc2F/TQSUuke4OCFq7yF3kmTPCTwrR9uGpZAH8iZkJcqo
	 7uG/y4OF6DnC6G2pC5MUFdKCspJ+Y4qS+MgokVhH2ifDDlndIolQVLCLqLgiNM+pVC
	 8mggWyhV7GMjpnsGGpT+qbGWZ/+icuyx/K7Dt6PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfHJDfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 23:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHJDfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 23:35:07 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565408106;
        bh=OOXbXwHQTreQVAz2Vek7YgFKOXX2vpVL5mYcPg9BRLY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kbf4vfjRjJN/lW/9hZJMiIUbVwsALNl4SyUKvGFCRxNkVJmzf/WwxxIeoVTdzngXi
         DovJHuzgMMpM/m8P9WzfH1CXz1EM3Xnuvn41al+NVC1PyTpDtaOga94VEZOn8/IYUC
         IJFUKLWyOUlreaCdf6hSSggTyFFtlF+GSoQmCxkY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQGV+CFP6o3_iQNH3x6boXWH=2JN8j7WPJbtyi=eF6=dg@mail.gmail.com>
References: <CAK7LNAQGV+CFP6o3_iQNH3x6boXWH=2JN8j7WPJbtyi=eF6=dg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQGV+CFP6o3_iQNH3x6boXWH=2JN8j7WPJbtyi=eF6=dg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.3-3
X-PR-Tracked-Commit-Id: c07d8d47bca1b325102fa2be3a463075f7b051d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 451577f3e3a9bf1861218641dbbf98e214e77851
Message-Id: <156540810686.11925.17753605303438094862.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 03:35:06 +0000
To:     Masahiro YAMADA <masahir0yamad@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 11:10:22 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/451577f3e3a9bf1861218641dbbf98e214e77851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
