Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348572147A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfCYHTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:19:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729788AbfCYHTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:19:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E9E4AE0E;
        Mon, 25 Mar 2019 07:19:47 +0000 (UTC)
Date:   Mon, 25 Mar 2019 08:19:48 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: Re: [tip:ras/core 2/2] drivers/ras/debugfs.c:9:5: error:
 redefinition of 'ras_userspace_consumers'
Message-ID: <20190325071948.GA14468@zn.tnic>
References: <201903250644.2Nyq4fRf%lkp@intel.com>
 <5988.1553471781@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5988.1553471781@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 07:56:21PM -0400, Valdis Klētnieks wrote:
> On Mon, 25 Mar 2019 06:41:49 +0800, kbuild test robot said:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras/core
> > head:   56baf8bd6c92819b1d89210fbfac2c6327a1271b
> > commit: 56baf8bd6c92819b1d89210fbfac2c6327a1271b [2/2] ras/debugfs: Fix -Wmissing-prototypes warnings
> > config: x86_64-randconfig-x003-201912 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> 
> OK.  Now to figure out why gcc-7.3 on Debian complains and gcc-9.0.1 on Fedora
> is perfectly happy with the patch, or if there's something I didn't expect in
> that randconfig, or if there's some other skew between what the test robot tree
> has in it, and next-20190318 (the last linux-next I built, which didn't
> complain...)

Ok, commit is gone from tip until this has been figured out.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
