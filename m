Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BFB20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552330833;
	bh=LZaetqao2ljTt3rzYPQH7BCfdi3t2+VPcx+gmwwkb9c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tnP0fe7NiLf4f0XIDAHRgMnI9N0VER4fDaFFXJW6fkLomf5Pugh2jVZz0OQP23Qxk
	 YCB+NHBWzHipOtVy71oNKTkgXSPf8N/xlvnaGH5NT31h533NbnyPEdCSVHFDOUn/y0
	 EJH4ryheU3tIP6r0rThy/4GvbEJN8+o57anyxEic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfCKTAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfCKTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:00:19 -0400
Subject: Re: [GIT PULL] pin control bulk changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552330819;
        bh=LZaetqao2ljTt3rzYPQH7BCfdi3t2+VPcx+gmwwkb9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eneRfLeDRlEJeOTc2kuQIuJ27xQTXd5Bo8bse4nW6ThHWZgxwumSIK2F8y6Bp4acV
         ZQyZRIFt6qnPGssVac6VbNkfDZDM0WYoRtzdEY/cbRD0pBmemS2nM1xzu8MUgwjZyl
         2bN3/HhaTL2nwBNFXXL9QjU32vv8DyzDwWMO1Sp0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkda_4oHv103MWt+D-cuKsXmu0ctSpZTjpKX3wAAVVwRSMA@mail.gmail.com>
References: <CACRpkda_4oHv103MWt+D-cuKsXmu0ctSpZTjpKX3wAAVVwRSMA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkda_4oHv103MWt+D-cuKsXmu0ctSpZTjpKX3wAAVVwRSMA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 tags/pinctrl-v5.1-1
X-PR-Tracked-Commit-Id: 9bc8fee96e9a4b8f17ba1544bf323f1ae6ded81d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf0240a755b8b3df51b0b857b03309a666611d58
Message-Id: <155233081902.15239.3949121434123076417.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Mar 2019 19:00:19 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 10:32:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf0240a755b8b3df51b0b857b03309a666611d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
