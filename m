Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11766C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA982084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDYKlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:41:31 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfDYKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:41:30 -0400
Received: from [192.168.1.115] ([95.115.19.22]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MA7Su-1hVBJq3sxW-00Bc9z; Thu, 25 Apr 2019 12:40:57 +0200
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.li@linux.intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, hpa@zytor.com,
        ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d8395c0e-7486-7c84-2c1c-de0929ec27b7@metux.net>
Date:   Thu, 25 Apr 2019 12:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2pEyaHJLFmA1tBhwk5VT8NxduhY7EK+nK7VAkFyzlDXBlfkPdI1
 b5yKFucK2ubEfsa2WrZcjlOFy0D5nMCe79FBR2IhZv7pMmPsvAslRxkuIV0aNiwdspvXbTl
 3TXPfAqjtbv8KCTuNglMx3eimtnoEpi/U1d34p/SF10n7fu3FLBJAri//3NrBFYHrBERBUN
 uUx8VCOOmeoLUrukFmVmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kegZAr6aaKk=:6g0KeJFE+nAw20UqnWCaFH
 sm+Y9XbC+lqOMLV72cWJbqK5/NRucqOj3X0oUmrNNwjSrZXGSXe4RX293AIwsM06hpN2M817K
 lZZ+qKFeAJ4P5b4BIi0et0Ypgb/C3L8VxrftUBcTqjQEo9RNfg0PeebJltanWzj59xOXHqbE0
 IuzgHbURyrSTTUcJdaPTB7+EIhjtlOLH9NwRIf2ECr1naA+HrWaWIxFuYhePi4czDBxyPUVrF
 aBCgQ6WUQCxEvIqNOFELpWJivSmrnG8bSC9XwjzPlBZptuNvXXUvU20EzqEAW2O4vKxZT823X
 BMpB0XW2j35zRUGn7EURBm1fzZk9DaCfE+EHLzKYpxwdc+qgK4Os6iQD5S/7b3JN3XxEafyQZ
 ZUBR/MeD1a3hXzDyJZOChLwKGuNpQ5doJvgkNjewYsajHQfqsIPkR/Tdo6ahxmgF6d02a8h45
 Tp+1Fk3KLt8weUcuLaXdNPRU6Hn99IjA/fd9EC/toLQ5haiv+AA4dj6ht6Mxxdkak54zBmhsi
 lHIyq7lskAyIxzFarRqshn7YDyozaz19RXETAWOEFdtPwSMCqYCkG2u5kfi5teV40Ubxhucb6
 ufxOC9vUOIzIWY7JeS1FB6kXKtTEyVROuuJp0G302Ue80J+Pf+z114ea23gQZcQ2zzxMeFanL
 +Hmko/gRyYZ0VKfNmuivsPEMFn+SMMGEX6PiVNaRWYoQoUjrCHZGKdszn7rZR80qp2uQ8Ju6O
 K07k1QLmPDTarUpc5+SuBg8LthpTK3zI5/l9fdmKUZEH8IAQcmIOdByhE3g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 23:18, Thomas Gleixner wrote:

Hi,

>> +config PROC_PID_ARCH_STATUS
>> +	bool "Enable /proc/<pid>/arch_status file"
> 
> Why is this switchable? x86 selects it if PROC_FS is enabled and all other
> architectures are absolutely not interested in this.

IMHO, it's good to have a switch, but that way doesn't make much sense.
Instead, I'd do it the other way round: make that switch depending on
those archs that actually support it. Something like this:

config PROC_PID_ARCH_STATUS
	bool "Enable /proc/<pid>/arch_status file"
	depends on PROC_FS
	depends on BROKEN

When x86 comes in, it would change to:

config PROC_PID_ARCH_STATUS
	bool "Enable /proc/<pid>/arch_status file"
	depends on PROC_FS
	depends on X86

And later arm coming in:

config PROC_PID_ARCH_STATUS
	bool "Enable /proc/<pid>/arch_status file"
	depends on PROC_FS
	depends on X86 || ARM

>> +	default n
>> +	help
>> +	  Provides a way to examine process architecture specific information.
>> +	  See <file:Documentation/filesystems/proc.txt> for more information.
> 
> Which contains zero information about this file when only this patch is
> applied. 

hmm, the patch alone doesn't do anything useful anyway. it only becomes
useful with subsequent patches that add some arch. I wonder if there's
anything more useful to document at that point.

>> +/*
>> + * Add support for task architecture specific output in /proc/pid/arch_status.
>> + * task_arch_status() must be defined in asm/processor.h
>> + */
>> +#ifdef CONFIG_PROC_PID_ARCH_STATUS
>> +# ifndef task_arch_status
>> +# define task_arch_status(m, task)
>> +# endif
> 
> What exactly is the point of this macro mess? If an architecture selects
> CONFIG_PROC_PID_ARCH_STATUS then it has to provide proc_task_arch_status()
> and the prototype should be in include/linux/proc_fs.h.

ACK.

>> +static int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
>> +				struct pid *pid, struct task_struct *task)
>> +{
>> +	task_arch_status(m, task);
>> +	return 0;
>> +}

Is that wrapper really neeeded ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
