Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC0EFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5784A21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573235709;
	bh=iEryZRpvUw/tQ8jgbh8KYrGH9hyKojtyeXyhEQRqsMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OV+PO//I4huSA1GG9VnLwLfSsS42aH/yJdH90+vik/XzOcII7K4WHKFpne8c/vNBP
	 tXMGYhOanWKePBLw8CdPDMcGGtwlnWKwoiDJTJy1XnX8Jvo/idVNhE0aomBGz1U3kP
	 XueNSk7iQ7J+cOruAobYQjpYHcpvLtD6Cws/WbYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfKHRzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:55:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfKHRzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:55:07 -0500
Subject: Re: [git pull] drm fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573235706;
        bh=iEryZRpvUw/tQ8jgbh8KYrGH9hyKojtyeXyhEQRqsMI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vinX63uovrS1KImGKp8dusDV9J4ZHxB5Fstv3VNAuTc9ReQ8gkY6uVz2yemVhDDlM
         248B5JdzDZb4iSk6uTHFIpwFo3xcuAJUaaCk4TI3gmUdk4iByEnbat+/dZo3/onx41
         +sIMx0GWVOljGw9H9oejGF8bfeboZArkFqJA/pV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzkQsv1s4ZXAyKDNVdXg_T0h4ZDODq68j4dLbACS_w4dw@mail.gmail.com>
References: <CAPM=9tzkQsv1s4ZXAyKDNVdXg_T0h4ZDODq68j4dLbACS_w4dw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzkQsv1s4ZXAyKDNVdXg_T0h4ZDODq68j4dLbACS_w4dw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2019-11-08
X-PR-Tracked-Commit-Id: ff9234583d4fb53d4bcf57916ddfb16c53c81c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efc61f7cbc283995bb1b3a5e925b8c7f79849f86
Message-Id: <157323570651.12598.15877507027094876707.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Nov 2019 17:55:06 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Nov 2019 16:57:59 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2019-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efc61f7cbc283995bb1b3a5e925b8c7f79849f86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
