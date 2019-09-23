Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3A5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6320B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569265528;
	bh=4i1mDkQpn+NxkorEyO1huigSz3zIiOzOMCYXV3BOc2s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Gb4lupHM3ldBd89y0RH25e4P9thGEDrcpa5ThV6Et6oTNshU/kwJtgysxhI1o6p+d
	 TRvoxBPLx+qX2tbR9HPG7d3L8uWPj4YdHmfkfZx6o8FiEnMkXhTpEjpuctPXJOJjde
	 iaeYCklHmRhIcJUHLxbKpAo6KAZyLKiIcfK+FAoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbfIWTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733093AbfIWTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:05:25 -0400
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569265524;
        bh=4i1mDkQpn+NxkorEyO1huigSz3zIiOzOMCYXV3BOc2s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xS9DWXUOuw8o+nWWg+sw2hjcVdhp37fQDMgWonnsVO6sfxNZTv1B/bl6vRGseeN9P
         mMX8sjvea818/HH2yAGKnhKROTGChRBTh5blCpOpQzDGDXQnwBJzbAY7my1s1uK5PT
         qpHqTkrpplf3IaMC7gROdO+lCKgqldrJFMnHtjxc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git
 tags/safesetid-bugfix-5.4
X-PR-Tracked-Commit-Id: 21ab8580b383f27b7f59b84ac1699cb26d6c3d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b5fb415442eb3ec946d48afe8c87b0f2fd42d7c
Message-Id: <156926552481.25044.1975414003602724525.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Sep 2019 19:05:24 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 Sep 2019 10:41:06 -0700:

> https://github.com/micah-morton/linux.git tags/safesetid-bugfix-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b5fb415442eb3ec946d48afe8c87b0f2fd42d7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
