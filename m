Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3412C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18A720644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEHH5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:57:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:44831 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfEHH5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:57:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 00:57:01 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2019 00:56:59 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        David Sterba <dsterba@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp\@01.org" <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [LKP] [btrfs]  302167c50b:  fio.write_bw_MBps -12.4% regression
References: <20190203081802.GD10498@shao2-debian>
        <87h8alqong.fsf@yhuang-dev.intel.com>
Date:   Wed, 08 May 2019 15:56:59 +0800
In-Reply-To: <87h8alqong.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Fri, 26 Apr 2019 14:14:11 +0800")
Message-ID: <87o94dl6pg.fsf@yhuang-dev.intel.com>
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
>> FYI, we noticed a -12.4% regression of fio.write_bw_MBps due to commit:
>>
>>
>> commit: 302167c50b32e7fccc98994a91d40ddbbab04e52 ("btrfs: don't end the transaction for delayed refs in throttle")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git pending-fixes
>>
>> in testcase: fio-basic
>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	nr_task: 8t
>> 	disk: 1SSD
>> 	fs: btrfs
>> 	rw: randwrite
>> 	bs: 4k
>> 	ioengine: sync
>> 	test_size: 400g
>> 	cpufreq_governor: performance
>> 	ucode: 0xb00002e
>>
>> test-description: Fio is a tool that will spawn a number of threads or processes doing a particular type of I/O action as specified by the user.
>> test-url: https://github.com/axboe/fio
>>
>>
>
> Do you have time to take a look at this regression?

Ping

Best Regards,
Huang, Ying
