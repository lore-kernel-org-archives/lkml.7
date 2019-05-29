Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA91C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428F520657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfE2ImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:42:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:26211 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2ImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:42:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 01:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,526,1549958400"; 
   d="scan'208";a="179507821"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga002.fm.intel.com with ESMTP; 29 May 2019 01:42:22 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <rong.a.chen@intel.com>
Cc:     David Sterba <dsterba@suse.com>, <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs]  c8eaeac7b7:  aim7.jobs-per-min -11.7% regression
References: <20190513025004.GG31424@shao2-debian>
Date:   Wed, 29 May 2019 16:42:22 +0800
In-Reply-To: <20190513025004.GG31424@shao2-debian> (kernel test robot's
        message of "Mon, 13 May 2019 10:50:04 +0800")
Message-ID: <87blzl7itt.fsf@yhuang-dev.intel.com>
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
> FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
>
>
> commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve delalloc metadata differently")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> in testcase: aim7
> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
> with following parameters:
>
> 	disk: 4BRD_12G
> 	md: RAID0
> 	fs: btrfs
> 	test: disk_rr
> 	load: 1500
> 	cpufreq_governor: performance
>
> test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

Here's another regression, do you have time to take a look at this?

Best Regards,
Huang, Ying
