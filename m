Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E443C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B2D2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570127416;
	bh=UBjhMnDknMo9MBM+b7Q1nXNP29xUGsrYmOuL34RiEus=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZCZswqmeXREU4heXU/dh5BfQZ5JGoW4ukEUVXxPDSnGwTUGazUh4+3zLnrYZ3PEfg
	 I3M5oMFdEilID5r3DPgCs6detR+z2ygMApY6TyRWN2UZH0uOvA7CdIKGrXIr/yVN8u
	 8MsAbLn5PZvExIiUpxigTkd/cWckEcZvIqsKLL7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfJCSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388727AbfJCSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:30:14 -0400
Subject: Re: [GIT PULL] kgdb changes v5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570127414;
        bh=UBjhMnDknMo9MBM+b7Q1nXNP29xUGsrYmOuL34RiEus=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XJRaODP7UK2oVyVg5fcd8lali/Uv/uxeYkQGBmtI6MO8ywUGg1YjCEZUBGl+ZxNz/
         x80UHBM9C5oeB1YYZ6jcJPCVJJRqvKKX90BfgVhfGYCD/PF8En1kZv5Kr/LTte7/A5
         Z1Z9CqT244wkBJxH5fQhQOT7ktFmR9S+CuU26yAk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
References: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191003155606.o5y5vmnszyzotbvw@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.4-rc2
X-PR-Tracked-Commit-Id: 086bf301f541eb4acfb5dadae7b1b207ad1b95a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1053cd122b23519322c8256ca24487e3b9695ce
Message-Id: <157012741398.22675.8973403667311156197.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Oct 2019 18:30:13 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 3 Oct 2019 16:56:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1053cd122b23519322c8256ca24487e3b9695ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
