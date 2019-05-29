Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA83C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1770421019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfE2D4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:56:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39640 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbfE2D4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:56:40 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4T3uDxh003771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 May 2019 23:56:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 30068420481; Tue, 28 May 2019 23:56:13 -0400 (EDT)
Date:   Tue, 28 May 2019 23:56:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        ltp@lists.linux.it
Subject: Re: [ext4] 079f9927c7: ltp.mmap16.fail
Message-ID: <20190529035613.GA6210@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        kernel test robot <rong.a.chen@intel.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org,
        ltp@lists.linux.it
References: <20190529025256.GB22325@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529025256.GB22325@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:52:56AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 079f9927c7bfa026d963db1455197159ebe5b534 ("ext4: gracefully handle ext4_break_layouts() failure during truncate")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Jan --- this is the old version of your patch, which I had dropped
before sending a push request to Linus.  However, I forgot to reset
the dev branch so it still had the old patch on it, and so it got
picked up in linux-next.  Apologies for the confusion.

I've reset the dev branch on ext4.git, and the new version of your
patch will show up there shortly, as I start reviewing patches for the
next merge window.

Cheers,

					- Ted

> <<<test_start>>>
> tag=mmap16 stime=1559078706
> cmdline="mmap16"
> contacts=""
> analysis=exit
> <<<test_output>>>
> mke2fs 1.43.4 (31-Jan-2017)
> mmap16      0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
> mmap16      0  TINFO  :  Formatting /dev/loop0 with ext4 opts='-b 1024' extra opts='10240'
> mmap16      1  TFAIL  :  mmap16.c:85: Bug is reproduced!
> <<<execution_status>>>
> initiation_status="ok"
> duration=8 termination_type=exited termination_id=1 corefile=no
> cutime=11 cstime=345
> <<<test_end>>>
