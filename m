Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4F8217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEJEEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbfEJEEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:04:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2DFFAD9C;
        Fri, 10 May 2019 04:04:13 +0000 (UTC)
Subject: Re: [btrfs] ddf30cf03f: xfstests.generic.102.fail
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     lkp@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <DSterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190510031904.GC31424@shao2-debian>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <05989d59-fa43-24f2-fd47-6099ec9273bd@suse.de>
Date:   Fri, 10 May 2019 12:04:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510031904.GC31424@shao2-debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/10 上午11:19, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: ddf30cf03fb53b9a0ad0f355a69dbedf416edde9 ("btrfs: extent-tree: Use btrfs_ref to refactor add_pinned_bytes()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Thanks for the info.

This explains why I have some unexpected ENOSPC error.
The cause is pretty aweful.

The offending patch relies completely btrfs_ref, but forgot that pinned
bytes can be minus, thus causing strange behavior.

I'll fix it soon.

Thanks for reporting again,
Qu

> 
> in testcase: xfstests
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: btrfs
> 	test: generic-quick2
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 vm-snb-4G-727 5.1.0-rc7-00188-gddf30cf
> MKFS_OPTIONS  -- /dev/vdb
> MOUNT_OPTIONS -- /dev/vdb /fs/scratch
> 
> generic/088 2s
> generic/089 14s
> generic/090 1s
> generic/091 19s
> generic/092 3s
> generic/098 4s
> generic/100 18s
> generic/101 0s
> generic/102- output mismatch (see /lkp/benchmarks/xfstests/results//generic/102.out.bad)
>     --- tests/generic/102.out2019-05-09 15:46:08.000000000 +0800
>     +++ /lkp/benchmarks/xfstests/results//generic/102.out.bad2019-05-10 09:32:39.267250059 +0800
>     @@ -1,21 +1,21 @@
>      QA output created by 102
>      wrote 838860800/838860800 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -wrote 838860800/838860800 bytes at offset 0
>     +wrote 109576192/838860800 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      wrote 838860800/838860800 bytes at offset 0
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/102.out /lkp/benchmarks/xfstests/results//generic/102.out.bad'  to see the entire diff)
> generic/103 1s
> generic/104 1s
> generic/105 0s
> generic/106 1s
> generic/107 1s
> generic/109 1s
> generic/120 16s
> generic/123  1s
> generic/124  4s
> generic/126  1s
> generic/129  6s
> generic/130 13s
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.1.0-rc7-00188-gddf30cf .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
> 
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
> 	bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
> 
> 
> 
> 
> Thanks,
> Rong Chen
> 
