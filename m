Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0BC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277DC207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552241122;
	bh=PztkmH7IMHY2oZ4di8DhxydCrr3mH2AFqCLrg1h6BUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EEMdGuDNGzQFXV/k3CGnizCvYWQD1VKWGywf0b5D8zSCWqfao4VLCMBIWBMPEN8Jz
	 ccaOjf9ZdvWFCnWikzNX0L/mKr493J3m7O29xeZeS8YpKpvbzX2zHTk4jd9jXHtvtH
	 aSOhfpeKJyM69kcBrnfeqWGh72JvsXWkXWa+nKao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfCJSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfCJSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:05:15 -0400
Subject: Re: [GIT PULL] Devicetree for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552241115;
        bh=PztkmH7IMHY2oZ4di8DhxydCrr3mH2AFqCLrg1h6BUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wahhMh5obyoT1sNsE5o4Guu44ajRPZhqo5t8I1wNugJemi6u2cOYX730hjxZvZx9J
         uY9KetkfBBnKF56bKtqiC/lOMEq+imc/KxUBoERkD8agw07XOJQdZNknTY6o7CbIx/
         9bTHlDzH1OVHLuYD6AlxGcan+9v8BsFRdi4sJoFk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAL_JsqLkW7OYJEaONK3Uh9Ly0iXaaOMpwKPgP8EpdBCc9i3UJA@mail.gmail.com>
References: <CAL_JsqLkW7OYJEaONK3Uh9Ly0iXaaOMpwKPgP8EpdBCc9i3UJA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAL_JsqLkW7OYJEaONK3Uh9Ly0iXaaOMpwKPgP8EpdBCc9i3UJA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-for-5.1
X-PR-Tracked-Commit-Id: 935665c1a117f34662549f01e1c9bc5ea7132556
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 065b6c4c913d3986c2118acb7e7fb364ce4fb625
Message-Id: <155224111507.12168.14824564284095575465.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 18:05:15 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 14:37:47 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/065b6c4c913d3986c2118acb7e7fb364ce4fb625

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
