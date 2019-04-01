Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6508C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A95D20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfDAO3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:29:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:42600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbfDAO3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:29:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63EBCAC89;
        Mon,  1 Apr 2019 14:29:27 +0000 (UTC)
Subject: Re: [btrfs] 70d28b0e4f:
 BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     lkp@01.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoon Jungyeon <jungyeon@gatech.edu>,
        David Sterba <DSterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190401132427.GC9217@shao2-debian>
 <f3cef716-a1e3-2e84-0133-9a9c3fad2a74@suse.com>
 <7a6c000e-c523-382a-d13c-790809260e4e@intel.com>
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
Message-ID: <5b82b026-bdd7-f781-e661-f1afdc9cb97b@suse.de>
Date:   Mon, 1 Apr 2019 22:29:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7a6c000e-c523-382a-d13c-790809260e4e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/1 下午10:02,  Chen, Rong A  wrote:
> 
> On 4/1/2019 9:28 PM, Nikolay Borisov wrote:
>>
>> On 1.04.19 г. 16:24 ч., kernel test robot wrote:
>>> FYI, we noticed the following commit (built with gcc-7):
>>>
>>> commit: 70d28b0e4f8ed2d38571e7b1f9bec7f321a53102 ("btrfs:
>>> tree-checker: Verify dev item")
>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>
>>> in testcase: trinity
>>> with following parameters:
>>>
>>>     runtime: 300s
>>>
>>> test-description: Trinity is a linux system call fuzz tester.
>>> test-url: http://codemonkey.org.uk/projects/trinity/
>>>
>>>
>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
>>> 2 -m 2G
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>> log/backtrace):
>>>
>>>
>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>>>
>>> |                                                                                                       
>>> | 36b9d2bc69 | 70d28b0e4f |
>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>>>
>>> |
>>> boot_successes                                                                                        
>>> | 14         | 0          |
>>> |
>>> boot_failures                                                                                         
>>> | 2          | 14         |
>>> |
>>> IP-Config:Auto-configuration_of_network_failed                                                        
>>> | 2          |            |
>>> |
>>> BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
>>> | 0          | 14         |
>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>>>
>>>
>>>
>>>
>>> early console in setup code
>>> Probing EDD (edd=off to disable)... ok
>>> BUG: kernel reboot-without-warning in early-boot stage, last printk:
>>> Probing EDD (edd=off to disable)... ok
>>> Linux version 5.0.0-rc8-00196-g70d28b0 #1
>>> Command line: ip=::::vm-snb-quantal-x86_64-1415::dhcp root=/dev/ram0
>>> user=lkp
>>> job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-1415/trinity-300s-quantal-core-x86_64-2018-11-09.cgz-70d28b0-20190330-29362-1y6g0qb-2.yaml
>>> ARCH=x86_64 kconfig=x86_64-randconfig-s5-03231928
>>> branch=linux-devel/devel-hourly-2019032317
>>> commit=70d28b0e4f8ed2d38571e7b1f9bec7f321a53102
>>> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/vmlinuz-5.0.0-rc8-00196-g70d28b0
>>> max_uptime=1500
>>> RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/8
>>> LKP_SERVER=inn debug apic=debug sysrq_always_enabled
>>> rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on
>>> panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic
>>> load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8
>>> systemd.log_level=err ignore_loglevel console=tty0
>>> earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
>>> rcuperf.shutdown=0
>>>
>> Can this report be made useful by actually including output from serial
>> console? For example possible bug-ons or whatnot? dmesg.xz just contains
>> qemu's command line + some metadata about the test and :
>>
>> "BUG: kernel reboot-without-warning in early-boot stage, last printk:
>> Probing EDD (edd=off to disable)... ok"
>>
>> At least a stack trace would have been useful.
>>
>> <snip>
> 
> 
> Hi,
> 
> We usually use the tool ("bin/lkp qemu -k <bzImage> job-script") to
> reproduce it.  It seems no stack trace in the result:

So there is no regression at that commit right?

Just some false alert?

Thanks,
Qu

> 
> $ lkp qemu -k vmlinuz-5.0.0-rc8-00196-g70d28b0 job-script
> ...
> Formatting '/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-0', fmt=qcow2
> size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> Formatting '/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-1', fmt=qcow2
> size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
> exec command: qemu-system-x86_64 -enable-kvm -fsdev
> local,id=test_dev,path=/home/nfs/.lkp//result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/2,security_model=none
> -device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel
> vmlinuz-5.0.0-rc8-00196-g70d28b0 -append root=/dev/ram0 user=lkp
> job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-1415/trinity-300s-quantal-core-x86_64-2018-11-09.cgz-70d28b0-20190330-29362-1y6g0qb-2.yaml
> ARCH=x86_64 kconfig=x86_64-randconfig-s5-03231928
> branch=linux-devel/devel-hourly-2019032317
> commit=70d28b0e4f8ed2d38571e7b1f9bec7f321a53102
> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/vmlinuz-5.0.0-rc8-00196-g70d28b0
> max_uptime=1500
> RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/8
> LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on
> panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2
> prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err
> ignore_loglevel console=tty0 earlyprintk=ttyS0,115200
> console=ttyS0,115200 vga=normal rw ip=dhcp
> result_service=9p/virtfs_mount -initrd /home/nfs/.lkp/cache/final_initrd
> -smp 2 -m 2048M -no-reboot -watchdog i6300esb -rtc base=localtime
> -device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor
> null -serial stdio -drive
> file=/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-0,media=disk,if=virtio
> -drive
> file=/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-1,media=disk,if=virtio
> early console in setup code
> Probing EDD (edd=off to disable)... ok
> 
> Best Regards,
> Rong Chen
> 
> 
