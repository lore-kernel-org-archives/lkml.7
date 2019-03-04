Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A04820663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCDSV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:21:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39958 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfCDSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:21:26 -0500
Received: by mail-pg1-f193.google.com with SMTP id u9so3650985pgo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5qqT4ZRf/LnelivIm5A7ePD1SDllKAfmDoHjg3x74hA=;
        b=X2oHyNPsqLxStKZOli4HY5OLRXn6aVEwbpr+9lWTNhmGrfg6+JIW4WUibeUmoSHdUp
         qQb6WcpSjAObq+dniNbrumTF7FD7BbTcr5IrDWREsj9OSOtv1+jAGeak7JeftDa+hhMq
         fWzHWPCz/FWSshgyuimUXAOv9qZWngssNQKbIbCkgeIcNblJ+BDnyQdARAKnBCOf3DYL
         M5OO0X19Xw1qGtFQWwkE4y/58H+vYFYyS3TgVlgsdOLomc3ks450EwvEiAQOwj51BO97
         KpPcvXB6BpRUfLeUEjR2NmUJ76TqsUlzV+f2qQcXmzgh4rCKYAmzarjUZbHOFT8H6p0C
         XpbQ==
X-Gm-Message-State: APjAAAWkobi04Zhm669pYDEjBHnMAeSeJG3y73yaunI90dVzdK62VrSh
        xQM/avDSzmlmvKadNd+7J/gKVDf4
X-Google-Smtp-Source: APXvYqx3h43yn9TLA/gX255CpV5YhddmYYvexQyTsRT/2ybYVxpXPheNqdaL6kBbmMXQDxoljlUxqA==
X-Received: by 2002:a63:1021:: with SMTP id f33mr19627983pgl.392.1551723685239;
        Mon, 04 Mar 2019 10:21:25 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:b459:1755:7327:66f8? ([2601:647:4800:973f:b459:1755:7327:66f8])
        by smtp.gmail.com with ESMTPSA id o2sm10283834pgq.29.2019.03.04.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:21:24 -0800 (PST)
Subject: Re: [LKP] [workqueue] 4d43d395fe:
 WARNING:at_kernel/workqueue.c:#__flush_work
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        James Smart <jsmart2021@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190304134116.GF25100@shao2-debian>
 <d6c6c236-7546-b5a4-47bd-d64b8b37083c@i-love.sakura.ne.jp>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b247096b-9033-a06b-fd2b-2d0f8611eb97@grimberg.me>
Date:   Mon, 4 Mar 2019 10:21:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6c6c236-7546-b5a4-47bd-d64b8b37083c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Forwarding to NMVE people:
> 
> kernel test robot found that
> flush_work(&ctrl->async_event_work) is called from nvmet_ctrl_free()
> without INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work)
> after ctrl was allocated (probably initialized with 0).
> Will you make sure that INIT_WORK() is always called?

I cannot reproduce this issue. When following the code I don't
immediately see how this can happen.. Was there something special
in this specific test run? Is it 100% reproduce-able?

> 
> On 2019/03/04 22:41, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 4d43d395fed124631ca02356c711facb90185175 ("workqueue: Try to catch flush_work() without INIT_WORK().")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: blktests
>> with following parameters:
>>
>> 	disk: 1SSD
>> 	test: nvme-005
>>
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +---------------------------------------------+------------+------------+
>> |                                             | d73aba1115 | 4d43d395fe |
>> +---------------------------------------------+------------+------------+
>> | boot_successes                              | 11         | 15         |
>> | boot_failures                               | 0          | 4          |
>> | WARNING:at_kernel/workqueue.c:#__flush_work | 0          | 4          |
>> | RIP:__flush_work                            | 0          | 4          |
>> +---------------------------------------------+------------+------------+
>>
>>
>>
>> [   62.446979] WARNING: CPU: 0 PID: 169 at kernel/workqueue.c:2911 __flush_work+0x1eb/0x200
>> [   62.450153] Modules linked in: nvme_loop nvme_fabrics nvmet nvme_core loop sr_mod cdrom sd_mod sg crct10dif_pclmul crc32_pclmul ppdev crc32c_intel ata_generic pata_acpi ghash_clmulni_intel snd_pcm snd_timer aesni_intel crypto_simd snd cryptd glue_helper soundcore i2c_piix4 pcspkr virtio_scsi ata_piix serio_raw libata parport_pc floppy parport ip_tables
>> [   62.461143] CPU: 0 PID: 169 Comm: kworker/u4:2 Not tainted 5.0.0-rc3-00131-g4d43d39 #1
>> [   62.463444] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   62.465843] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loop]
>> [   62.467769] RIP: 0010:__flush_work+0x1eb/0x200
>> [   62.469176] Code: 66 66 90 65 ff 0d b5 de f6 7e 31 c0 eb a2 8b 4d 00 48 8b 55 08 83 e1 08 48 0f ba 6d 00 03 80 c9 f0 e9 58 ff ff ff 0f 0b eb 86 <0f> 0b 31 c0 eb 80 e8 0a 0d fe ff 66 2e 0f 1f 84 00 00 00 00 00 66
>> [   62.475512] RSP: 0000:ffffc9000093fcf8 EFLAGS: 00010246
>> [   62.477040] RAX: 0000000000000000 RBX: ffff888077f9c148 RCX: 0000000000000000
>> [   62.478944] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff888077f9c148
>> [   62.480945] RBP: ffff888077f9c148 R08: ffff88812ec00000 R09: ffff88812ec00028
>> [   62.483203] R10: 0000000000000000 R11: ffffffff8265eef8 R12: 0000000000000000
>> [   62.485841] R13: ffffc9000093fd90 R14: ffffffff810a49a0 R15: 0000000000000000
>> [   62.488334] FS:  0000000000000000(0000) GS:ffff88813fc00000(0000) knlGS:0000000000000000
>> [   62.491077] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   62.492692] CR2: 0000558ad08acff0 CR3: 000000007f398000 CR4: 00000000000006f0
>> [   62.494662] Call Trace:
>> [   62.495566]  ? del_timer+0x53/0x80
>> [   62.496668]  __cancel_work_timer+0x12b/0x1b0
>> [   62.497961]  ? wake_up_q+0x80/0x80
>> [   62.499361]  ? pcpu_free_area+0x270/0x2e0
>> [   62.501054]  nvmet_ctrl_free+0x10f/0x1b0 [nvmet]
>> [   62.502767]  ? free_percpu+0x7c/0x1c0
>> [   62.504193]  nvmet_sq_destroy+0x74/0x110 [nvmet]
>> [   62.505566]  nvme_loop_destroy_admin_queue+0x20/0x40 [nvme_loop]
>> [   62.507223]  nvme_loop_reset_ctrl_work+0x2a/0xe0 [nvme_loop]
>> [   62.508876]  process_one_work+0x19c/0x3b0
>> [   62.510167]  worker_thread+0x1e5/0x3b0
>> [   62.511357]  ? process_one_work+0x3b0/0x3b0
>> [   62.512890]  kthread+0x11e/0x140
>> [   62.514273]  ? kthread_park+0x90/0x90
>> [   62.515735]  ret_from_fork+0x35/0x40
>> [   62.517157] ---[ end trace d741a57df27dcf91 ]---
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> lkp
>>
> 
