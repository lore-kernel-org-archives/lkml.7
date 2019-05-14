Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A29C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4BF20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557856224;
	bh=ekdsKgf6vb4yWaZGzMHVU6cmwiDeEtGXgOWr+9O9SFk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qA+9uWFoDvMdUH4lvv3Ah4p5spH7d1myqEs/kqEz4eQB5LqL1NMc7cjFP/7fGZ3dB
	 toT3H3D0+OMxiOmZWU2GdP5s6YO5OWFw9rpFFCO88cg1FzMaZgw9mkxO352f5GK3uU
	 ZisTdHlHKuIm5egbsOcU+GfKPx14vVjnm6t/3kJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfENRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfENRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:50:18 -0400
Subject: Re: [GIT PULL] Backlight for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557856217;
        bh=ekdsKgf6vb4yWaZGzMHVU6cmwiDeEtGXgOWr+9O9SFk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M51I9Rv9bUOhYYlNwWzGsdEwOS0SwSf7IpbSHXkWJegkgjmGf4DWvFQgbb5DyC99K
         EU7rlxRzOHnoKe7Sd0M504J6qAc8Fa9HyylY07LK549JCGXPmYAkveNRTrF9Y766ly
         MBeEgZmkX2ojQfffqXTYTNNaMRwAEg6iiX9Y5cwY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514104133.GN4319@dell>
References: <20190514104133.GN4319@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514104133.GN4319@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git
 tags/backlight-next-5.2
X-PR-Tracked-Commit-Id: 8fbce8efe15cd2ca7a4947bc814f890dbe4e43d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0654264c4806dc436b291294a0fbf9be7571ab6
Message-Id: <155785621772.23900.3860716418450619063.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:50:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 11:41:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0654264c4806dc436b291294a0fbf9be7571ab6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
