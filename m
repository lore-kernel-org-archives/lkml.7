Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CC8C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC3D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfFKAwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:52:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:27128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbfFKAwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:52:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 17:52:13 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2019 17:52:11 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>, <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [btrfs]  c8eaeac7b7:  aim7.jobs-per-min -11.7% regression
References: <20190513025004.GG31424@shao2-debian>
        <87blzl7itt.fsf@yhuang-dev.intel.com>
Date:   Tue, 11 Jun 2019 08:52:11 +0800
In-Reply-To: <87blzl7itt.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Wed, 29 May 2019 16:42:22 +0800")
Message-ID: <87v9xdymdg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Josef,
>
> kernel test robot <rong.a.chen@intel.com> writes:
>
>> Greeting,
>>
>> FYI, we noticed a -11.7% regression of aim7.jobs-per-min due to commit:
>>
>>
>> commit: c8eaeac7b734347c3afba7008b7af62f37b9c140 ("btrfs: reserve
>> delalloc metadata differently")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: aim7
>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz with 384G memory
>> with following parameters:
>>
>> 	disk: 4BRD_12G
>> 	md: RAID0
>> 	fs: btrfs
>> 	test: disk_rr
>> 	load: 1500
>> 	cpufreq_governor: performance
>>
>> test-description: AIM7 is a traditional UNIX system level benchmark
>> suite which is used to test and measure the performance of multiuser
>> system.
>> test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/
>
> Here's another regression, do you have time to take a look at this?

Ping

Best Regards,
Huang, Ying
