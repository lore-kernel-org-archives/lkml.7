Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C41206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574368206;
	bh=fLqpfbhK5NxWQC09H+TpqZ1OT3CBYKdbsF12naOftO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lFrsJezJ0nFyDv9ypQJxA54gjaugm+I5nD19blCtXtEhnXtcZNxalNQjSj5GZ5fd3
	 ox/NTl7TarTwEiGPAYcJIusxDWM+1gVtEGMDFw3V7M1bMKBlKhPPCk2VzudV+2l0hz
	 cTiTZrV8sDjgJKTjmM/tw+MjwiBnFPAdyXJtR5YE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUUaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:30:05 -0500
Subject: Re: [GIT PULL] GPIO fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574368205;
        bh=fLqpfbhK5NxWQC09H+TpqZ1OT3CBYKdbsF12naOftO4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TVvuCft3XNMAxb2Sn643UwH6TNBaXm5U91tZS5F6L9FjCVozcrHpTJ7UOL+c1MZNN
         srphtbrZdEtPZnxUXkbKjt940d00UWQT8v0Z/d4H3JUPowU53991Dd1pU5nCza8i+T
         HGr0qj+Zq6Z2WRkgsdrmzonz5zmGgI5cBk467NW0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbfVvxAUEeGApGx7jhagkOrNY7_G=ch4kzUE5YCD_N3ZA@mail.gmail.com>
References: <CACRpkdbfVvxAUEeGApGx7jhagkOrNY7_G=ch4kzUE5YCD_N3ZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbfVvxAUEeGApGx7jhagkOrNY7_G=ch4kzUE5YCD_N3ZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.4-5
X-PR-Tracked-Commit-Id: cbdaa5e7bd90db9980ff6187baea9d49fc4de960
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cec353f6c2c9ff003332a41ed37b55df88dfa9a5
Message-Id: <157436820500.3070.10997266497098964682.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Nov 2019 20:30:05 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 08:11:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.4-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cec353f6c2c9ff003332a41ed37b55df88dfa9a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
