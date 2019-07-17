Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B919C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B6C21874
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563394821;
	bh=P8oL/f4xbCn40+xdfLgBcK3cfmpy7/usDss3cR5E6/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uPV1985ynnpyIDAAFQ0YyzS6qsdE5l98oPzd5ZKiy5Ko7lQV1Un3QJtSGUWwx883+
	 TTZD+ANvDY68QhxMyQiw02ZYbFcKXvI0cpSTYPLlNB5CsnYQeZi7gUkPwDeO9R1X4H
	 m5nqj+rYW10D7pJJxCkOgwjBoFv1t2gAfWBZSuNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfGQUUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfGQUUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:20:18 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.3-2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563394817;
        bh=P8oL/f4xbCn40+xdfLgBcK3cfmpy7/usDss3cR5E6/A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bZhvW+Uw3hoQH3qnF+ao529MLNEzHz68bAB6c1VUGbY7J9pFw2WqAnplqnmW6GQa3
         5OExiMJtPA1kpfKrOhhAuP/BiyNZh1ZGJNWv7B0I9TcMj0kWJ6ohV7H9+1vsU2tSNy
         l4uYHzLZUs6uKOh5NRMhPTSSlkxeyDotKIUB9Ua0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190717161703.GA5516@smile.fi.intel.com>
References: <20190717161703.GA5516@smile.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190717161703.GA5516@smile.fi.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/linux-platform-drivers-x86.git
 tags/platform-drivers-x86-v5.3-2
X-PR-Tracked-Commit-Id: 9af93db9e140a4e6e79cdb098919bc928a72cd59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22051d9c4a57d3b4a8b5a7407efc80c71c7bfb16
Message-Id: <156339481747.4204.7457557852123556903.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Jul 2019 20:20:17 +0000
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>, yurii.pavlovskyi@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Jul 2019 19:17:03 +0300:

> git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22051d9c4a57d3b4a8b5a7407efc80c71c7bfb16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
