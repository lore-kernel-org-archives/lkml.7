Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111AC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6372077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfDZGOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 02:14:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:31371 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfDZGOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 02:14:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 23:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,396,1549958400"; 
   d="scan'208";a="340963864"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga006.fm.intel.com with ESMTP; 25 Apr 2019 23:14:12 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp\@01.org" <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [LKP] [btrfs]  302167c50b:  fio.write_bw_MBps -12.4% regression
References: <20190203081802.GD10498@shao2-debian>
Date:   Fri, 26 Apr 2019 14:14:11 +0800
In-Reply-To: <20190203081802.GD10498@shao2-debian> (kernel test robot's
        message of "Sun, 3 Feb 2019 16:18:02 +0800")
Message-ID: <87h8alqong.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Josef,

kernel test robot <rong.a.chen@intel.com> writes:

> Greeting,
>
> FYI, we noticed a -12.4% regression of fio.write_bw_MBps due to commit:
>
>
> commit: 302167c50b32e7fccc98994a91d40ddbbab04e52 ("btrfs: don't end the transaction for delayed refs in throttle")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git pending-fixes
>
> in testcase: fio-basic
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
>
> 	runtime: 300s
> 	nr_task: 8t
> 	disk: 1SSD
> 	fs: btrfs
> 	rw: randwrite
> 	bs: 4k
> 	ioengine: sync
> 	test_size: 400g
> 	cpufreq_governor: performance
> 	ucode: 0xb00002e
>
> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
> test-url: https://github.com/axboe/fio
>
>

Do you have time to take a look at this regression?

Best Regards,
Huang, Ying
