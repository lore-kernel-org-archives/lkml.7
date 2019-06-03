Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A8FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3230526844
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559600713;
	bh=dTUGkJSVTozYywG98oQ7TpLBN1ASPRBmgOklgTgAJTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rnL+ddxjZTcNsCBEU+3Dr+BmHVcAEMJGF8CMRXjobxwCEaNt5PsAP0K4hkD/NUkbA
	 PvLTO3b3uWPUsAgCXtAsUwT8tH1vl3lJh537IMHpfl774Yowvpzdcj8TCC94GDu6al
	 XsQW+bxyqBjTOzgEoTUjhVJ9/fd9NzoAdOjB/RKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFCWZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCWZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:25:12 -0400
Subject: Re: [GIT PULL] ARC updates for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559600711;
        bh=dTUGkJSVTozYywG98oQ7TpLBN1ASPRBmgOklgTgAJTU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kSEFUShfyyjPX/f02IU8gtejvqzOoxtjQXZYuEy4L4x/PFyo4nxUAzRhTsP8oMbBY
         R6WcHkKZ/IC1cIaszzf5jWYoRp45FCOwONdQFpkSzJx6Kon2mGhxvKUgi8EfPuV9BF
         qM9KOmdEWd2lQTFR2HaF3RjmcSmkzobK5MV6/EKc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e1a01d01-fccc-fab8-7022-9a18bb4d8f10@synopsys.com>
References: <e1a01d01-fccc-fab8-7022-9a18bb4d8f10@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <e1a01d01-fccc-fab8-7022-9a18bb4d8f10@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.2-rc4
X-PR-Tracked-Commit-Id: 46e04c25e72f002d0d14be072300c2dd827d99b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 788a024921c48985939f8241c1ff862a7374d8f9
Message-Id: <155960071152.7954.12243155776656459408.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jun 2019 22:25:11 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jun 2019 14:04:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/788a024921c48985939f8241c1ff862a7374d8f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
