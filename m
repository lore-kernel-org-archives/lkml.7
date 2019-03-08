Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C552085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070211;
	bh=QU8QNv+dJ3unZs5te2gBhT27SXH1ctSWV//VIcCfAis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KQvAvJUH9xqRsmtRm7hZgdAKi47L1iioJOtDy1Ly1+4iRtshHyDsAJlOEh4IVFtCx
	 JEVZ6TmDl7u7th1wXrBIoWYdsAP5j7n7w6MUKY+W8Bw5lQTDRJZWgt7WBWFHzb6fEa
	 MK2uqx/2YApt4Dn3iESYVB7Mm9ZAjuV6p1eLQX9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfCHSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfCHSfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:18 -0500
Subject: Re: [GIT PULL] Bulk GPIO changes for the v5.1 kernel cycle
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070118;
        bh=QU8QNv+dJ3unZs5te2gBhT27SXH1ctSWV//VIcCfAis=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zsnmAM14A0F3BQJLbf5miqn+J6wO2/r1N/Rsrfc6XgaXl7y17Ss1caO/fvlPxlyYm
         OoH6yk9aFZimPu41esEQtQqirVOUWEKOQz4NToIqYID/9HdkPu2QVAtJuEw3Kwcrlv
         g61GpYOYafl9mAgfht0ryZGNCSulDADs6s7tobXo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYcT3zkSUo74i=WXS4AhHtKEDF2K8o1wttsZeGMK9cvCQ@mail.gmail.com>
References: <CACRpkdYcT3zkSUo74i=WXS4AhHtKEDF2K8o1wttsZeGMK9cvCQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYcT3zkSUo74i=WXS4AhHtKEDF2K8o1wttsZeGMK9cvCQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.1-1
X-PR-Tracked-Commit-Id: c378b3aa015931a46c91d6ccc2fe04d97801d060
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a422bf11bdb4b95fc78e175339e8eed501e9c13c
Message-Id: <155207011820.7904.6803497707115628424.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:18 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brian Masney <masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 10:35:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a422bf11bdb4b95fc78e175339e8eed501e9c13c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
