Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C96BC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2881E21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576865713;
	bh=lcRGPNpDf2zgoqD2r8PCWWBpNHG4ZZvTk5gpT8Nmw0k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hnFxVTromWlSxzriaqfvhG2mrPsJAYfZhqCozqM9mySnwcwan4a12HkYqt0M+kONr
	 oDICNbrAAsThWJUnuRZdQCkHl9qroO6R8bUR3Kd9m49ch2HuEO0pZ4iMN8yAF9DEVH
	 iW+MTzMRSbiFW0aUfMuyPoVYvvDQ1uHChUo2qJYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLTSPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbfLTSPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:15:11 -0500
Subject: Re: [GIT PULL] USB fixes for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576865711;
        bh=lcRGPNpDf2zgoqD2r8PCWWBpNHG4ZZvTk5gpT8Nmw0k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jgqsE1BCJ9c+bh8dqOS66ipOV+uHDrKDGrCgon169w1cmI0hz/X5+aYSsHDmJ4oJ/
         WAmyYDldNqM+OAmZD15iHyxg815fGKnVOBN1RcYa6Z2XnMvulMd6/QHI1Q/G4Qjryo
         ZdGeU4WVLGERJ84IBh5pTg4jbO7bTND5d3diuvls=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220070730.GA2190076@kroah.com>
References: <20191220070730.GA2190076@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220070730.GA2190076@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc3
X-PR-Tracked-Commit-Id: 6056a0f8ede27b296d10ef46f7f677cc9d715371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7181aba1463909b99a7c5807e5eae40d93d36366
Message-Id: <157686571119.29164.14383555882728834493.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:15:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 08:07:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7181aba1463909b99a7c5807e5eae40d93d36366

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
