Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F62C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB15B2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561137916;
	bh=cVr8RHH4fR79XsiW4yOcmmrwTj7oE+uYrLd/XHiv70U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FkHG3lpM6hgZRm+x8+YqLXB939Biy2RE6eOMxY6eYu+jt+50CMmFQA6X4oobci4GO
	 BVCIo9+mLoN3gq+SgceASe0nMObVouSk7CebyMA5i44tsbEfBNdLrFdbaaUC3L0Xvk
	 xMU6C7cP2JiEw314xLqkQMCDiG3M6rfHbrVxoYf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFURZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFURZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:25:06 -0400
Subject: Re: [GIT PULL] USB fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561137906;
        bh=cVr8RHH4fR79XsiW4yOcmmrwTj7oE+uYrLd/XHiv70U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b7MMVpKYqf2JqwsXgPBnIUHRtEQM2ueUC1RQ15c02GoHVwYSHP0WC3H67GmJT7Kr4
         3R1BHx8ipWTUsPbmJQyHvJavULBflFuxrLfG9appHbUw3XmdZMinzF9y3LwHHvLtN2
         ZHOqhOdJT8cjxTPfhi5L5Z/5sHo/czA1B/01DX84=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190621081026.GA27919@kroah.com>
References: <20190621081026.GA27919@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190621081026.GA27919@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc6
X-PR-Tracked-Commit-Id: d28bdaff5e260852621d45edd3af017cc5d16925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf24242189b935826a88feedb64761cbf483e42c
Message-Id: <156113790614.2072.16145479994062048162.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jun 2019 17:25:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jun 2019 10:10:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf24242189b935826a88feedb64761cbf483e42c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
