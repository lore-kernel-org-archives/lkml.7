Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96898C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696192064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfGJHcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:32:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44522 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfGJHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:32:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so784850pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 00:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/8k3wJZ/M5gqwesQlBPnEgxOOT25nplWBQ3376EquKg=;
        b=rCXfb17ulre0y5xuU7arOj2y00zRCSQGzKoPw7iERbndUkd9Zna6qbYlPsywgZv6bg
         2GdndxoJ1RlpNikIg+0KC/Z7hYA3v+SbXK+PxAJakqLDCXDFKN0nSYpVyOwVhnWLUOxd
         k5axC/jLR1eRCYj0BmZnZsYSISxIXsqB89OaxnIWuv67myRqJrxdmrpmTatJd/8UhBge
         sRb/yLaq59hEW/Za2yGGE83lyumQTkuCQxq4qAJfvwVvhOE1AG8YCB4R6gsnKYDcY1Bu
         pN4p8nDfFitEFtaoh1tD2rJ3cLhhOyn7i7hgkIM7iyjahmVf60Xcoi+NxFo56YVmk/Tu
         z9Ww==
X-Gm-Message-State: APjAAAXkZ0ae9FFQXWe36ntNtJHtDGnSMVnwrZJ3SW6uLJTCIa1l+B3L
        CjFkO7vdEowKVc0GAToxWYCgJQ==
X-Google-Smtp-Source: APXvYqwK3Jf9w48Lla8NZTVWD/DBh1DqC5ss795aeyr2gQwR+7Jw/tTYhkCw/arOVf47ygPuQrHoRA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr36703662pgr.52.1562743951664;
        Wed, 10 Jul 2019 00:32:31 -0700 (PDT)
Received: from localhost.localdomain ([182.69.207.54])
        by smtp.gmail.com with ESMTPSA id g1sm2915730pgg.27.2019.07.10.00.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 00:32:30 -0700 (PDT)
Subject: Re: [v2 0/5] arm64: allow to reserve memory for normal kexec kernel
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190709182014.16052-1-pasha.tatashin@soleen.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <d57ec270-a9dc-1820-195c-eb7ef61f9828@redhat.com>
Date:   Wed, 10 Jul 2019 13:02:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190709182014.16052-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 07/09/2019 11:50 PM, Pavel Tatashin wrote:
> Changelog
> v1 - v2
> 	- No changes to patches, addressed suggestion from James Morse
> 	  to add "arm64" tag to cover letter.

Minor nit. Please also add PATCH to the subject line. Something like 
[PATCH v2]

Also will suggest to wait for atleast a couple of days before sending a 
new version of the patchset so as to give sufficient time for reviews to 
happen.

> 	- Improved cover letter information based on discussion.

> Currently, it is only allowed to reserve memory for crash kernel, because
> it is a requirement in order to be able to boot into crash kernel without
> touching memory of crashed kernel is to have memory reserved.

> The second benefit for having memory reserved for kexec kernel is
> that it does not require a relocation after segments are loaded into
> memory.

> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs might take a significant
> portion of reboot.
> 
> In fact, on the machine that we are using, that has ARM64 processor
> it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
> time:
> 
> kernel shutdown	0.03s
> relocation	0.35s
> kernel startup	0.29s
> 
> Image: 13M and initramfs is 24M. If initramfs increases, the relocation
> time increases proportionally.
> 
> While, it is possible to add 'kexeckernel=' parameters support to other
> architectures by modifying reserve_crashkernel(), in this series this is
> done for arm64 only.

Note that we normally have two dimensions to this (and similar) 
problem(s) - time we spend in relocating the kernel + initramfs v/s the 
memory space we reserve while enabling kexeckernel (in this case) in the 
primary kernel.

Just to give you an example, I have to shrink even the crashkernel 
reservation size in the primary kernel on arm64 systems running fedora 
which have very small memory footprint. I have a amazon ec2 (aarch64) 
for example which runs with 256M memory space and even enabling 
crashkernel on the same was quite a challenge :)

In such a case we need to do a comparison between the space we reserve 
v/s the time we spend while relocating while doing a kexec load.

Note that we recently had issues with OOM in crashkernel boot, because 
of which we had to introduce kernel command-line parameter to allow a 
user to disable device dump to reduce memory usage, see the following 
commit:

a3a3031b384f ("vmcore: Add a kernel parameter novmcoredd")

More on the same below ...

> The reason it is so slow on arm64 to relocate kernel is because the code
> that does relocation does this with MMU disabled, and thus D-Cache and
> I-Cache must also be disabled.
> 
> Alternative solution is more complicated: Setup a temporary page table
> for relocation_routine and also for code from cpu_soft_restart. Perform
> relocation with MMU enabled, do cpu_soft_restart where MMU and caching
> are disabled, jump to purgatory. A similar approach was suggested for
> purgatory and was rejected due to making purgatory too complicated.
> On, the other hand hibernate does something similar already, but there
> MMU never needs to be disabled, and also by the time machine_kexec()
> is called, allocator is not available, as we can't fail to do reboot,
> so page table must be pre-allocated during kernel load time.

... may be its time to explore this path now with a fresh mind. I know 
Pratyush tried a bit on this and now I am experimenting on the same on 
several aarch64 systems, mainly because we are really short on memory 
resources on several aarch64 systems (used in embedded/cloud domain) and 
frequently run into OOM issues even in the primary kernel.

Some more comments below:

1. I recommend protecting this code under a CONFIG (CONFIG_FAST_KEXEC ?) 
option and make it dependent on ARM64 being enabled (via CONFIG_ARM64 
option) to avoid causing issues on other archs like s390, powerpc, 
x86_64 (which probably don't need these changes).

Also better to make the CONFIG option disabled by default, so that we 
can avoid OOM issues in primary kernel on arm64 systems with smaller 
memory footprints. A user can enabled it, if he needs fast kexec load 
experience..

2. Also, I don't see timing results for kexec_file_load() in this cover 
letter. Can you add some results for the same here, or are they on 
similar lines?

I will give this a go on some aarch64 systems at my end and come back 
with more on the kernel + initramfs relocation time v/s memory space 
taken up results.

Thanks,
Bhupesh

> Note: the above time is relocation time only. Purgatory usually also
> computes checksum, but that is skipped, because --no-check is used when
> kernel image is loaded via kexec.
> 
> Pavel Tatashin (5):
>    kexec: quiet down kexec reboot
>    kexec: add resource for normal kexec region
>    kexec: export common crashkernel/kexeckernel parser
>    kexec: use reserved memory for normal kexec reboot
>    arm64, kexec: reserve kexeckernel region
> 
>   .../admin-guide/kernel-parameters.txt         |  7 ++
>   arch/arm64/kernel/setup.c                     |  5 ++
>   arch/arm64/mm/init.c                          | 83 ++++++++++++-------
>   include/linux/crash_core.h                    |  6 ++
>   include/linux/ioport.h                        |  1 +
>   include/linux/kexec.h                         |  6 +-
>   kernel/crash_core.c                           | 27 +++---
>   kernel/kexec_core.c                           | 50 +++++++----
>   8 files changed, 127 insertions(+), 58 deletions(-)
> 

