Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122C4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04A22089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564533614;
	bh=NHbuxyEgLSoC499SN8BkNunymePONLRyhWu422VBgO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kvXK0gHuiO245QlX/+h5M0LfzKi1i5H7EE48WgeE922L6u2dHKmaAv+dG2fkQw2iS
	 YSMiJqp7tSG6RU+JsCclK9s8Xz+AZgku8HL+1WmvIfIERqFG5zSTYpuMKbREC3kAEH
	 ztUNh/PehKsv2+My+lJnXhqVe0fjp7AMWeAksc7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfGaAkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 20:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfGaAkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 20:40:13 -0400
Subject: Re: [GIT PULL] dax fix for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564533613;
        bh=NHbuxyEgLSoC499SN8BkNunymePONLRyhWu422VBgO4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dzz8sipVgdMN+nmkaVXM/Gpiw5lrM8TohMY8IIATGzAxmm45ZzmF+N0OjI8g+xuig
         Qq92IHbddQD2VumMKTHWPHF7lBqdBjDZoIJzVOEJRrcomk6YJbCXjaIDQvs+1ExakS
         +YH2RQxqgvjD1/5+TZqsnrQebij/v4IKbzb1mSL4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
References: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hJcRY3aop4jgH8NLsz1A8HH7sH6gnGs02Wy8A=p5o=jg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3
X-PR-Tracked-Commit-Id: 61c30c98ef17e5a330d7bb8494b78b3d6dffe9b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4010b622f1d2a6112244101f38225eaee20c07f2
Message-Id: <156453361310.6472.7034768044112756538.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Jul 2019 00:40:13 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 14:32:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm dax-fix-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4010b622f1d2a6112244101f38225eaee20c07f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
