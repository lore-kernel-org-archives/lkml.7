Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211CC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD52184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562295308;
	bh=ubec7ywyoQorfw3Qnn+xnNovpvxUzVu/hsZbOEAwmt4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=baPL/nmVf4Soospi5yjVVZwSUzOpTdAj376J/Fx+Sf/5Ruir76RUS4JnrBGSUJu6Q
	 OslP31/5lptKrs080A03es1rPCEHrWUW7KoVXsMhBhjHHv/QcOnxUx7MWWtAczEwOO
	 z+YqWafoK8hgBMlfTP52ncEpOkfPFtzzJEpgmERk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfGECzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfGECzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:55:06 -0400
Subject: Re: [GIT PULL] ARM: SoC fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562295305;
        bh=ubec7ywyoQorfw3Qnn+xnNovpvxUzVu/hsZbOEAwmt4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mYyOIYgoyUrgQf/p+Rl6x2vgk/ax2wgo2e/5UccRRFSbeQeqibPaHFaFFTgBY23Vz
         Cek4BSZDPntaggYF77ssQxndK3mjCbiuoWpj9ORbWPycjSWzhu3Q+PKUWgvJ4w/q3+
         3fSpaahkmIG1ICiu10kElaZKpss+ED83lVcXd3So=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190705002223.wmc5ge5jszy4z6vc@localhost>
References: <20190705002223.wmc5ge5jszy4z6vc@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190705002223.wmc5ge5jszy4z6vc@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 2659dc8d225c956b91d8a8e4ef05d91b2e985c02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecbe5086adc2876b22c898987d8a20f932de87a9
Message-Id: <156229530529.12956.10924276549414473102.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jul 2019 02:55:05 +0000
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, olof@lixom.net, arm@kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, greg@linuxfoundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 4 Jul 2019 17:22:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecbe5086adc2876b22c898987d8a20f932de87a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
