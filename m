Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A50C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE4C2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556648709;
	bh=LqvNSaqK1WCL32tALCNxWJmWvUwjqG3fUpuCGxNsohQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Bn0urDibRzWAMGYCxi5GQWlaAhw8x8Rh5vJy8stOMreaCe7M2Vw7rnTppP7yX6JpI
	 H2z/tOS6Zvh8rUepUYIszgxH6Ipaa9zogp1MmhBfreiqsSYqCL0NI2WkaTjnlIpAk+
	 FbyRiHsYb0d+1wQKmnq8ptyWQYETV8Mjo5r+neYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfD3SZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfD3SZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:04 -0400
Subject: Re: [GIT PULL] USB fixes for 5.1-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556648703;
        bh=LqvNSaqK1WCL32tALCNxWJmWvUwjqG3fUpuCGxNsohQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y1SpNZ0onvRMW22xH53gGzKRNKsSPZmqTBdBXD281kvs4skSspLkDDjJl4TsdlY7y
         QepiWJ0gBFV/ezCyGO1LiMaZg+dRsYopxQSwB9Jve5JDWZnY/09UfZdm6+Xb+w/J0E
         TdJ1lMxPYfrXuwn6/MsshIQ/2Vbs2ExTf34hxpvA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190430143711.GA24385@kroah.com>
References: <20190430143711.GA24385@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190430143711.GA24385@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc8
X-PR-Tracked-Commit-Id: c114944d7d67f24e71562fcfc18d550ab787e4d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf3bd966dfd7d9582f50e9bd08b15922197cd277
Message-Id: <155664870385.13312.15799676714491879491.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Apr 2019 18:25:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Apr 2019 16:37:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf3bd966dfd7d9582f50e9bd08b15922197cd277

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
