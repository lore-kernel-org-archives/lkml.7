Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED8AC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A4A2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfEJAJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:09:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:17203 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfEJAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:09:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 17:09:12 -0700
X-ExtLoop1: 1
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2019 17:09:12 -0700
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu>
 <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com>
 <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
 <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com>
 <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
 <CAERHkrsavsBoEOR5Eq-nm6ADarS0zTi5Mu-T7TO6JoSUi7TRfQ@mail.gmail.com>
 <8098b70b-2095-91ea-d4ad-9181829066c7@oracle.com>
 <CAERHkrvKfvrSOKoJ5StYWENm9domgx1OkPyeKHacP9AGrgf8cg@mail.gmail.com>
 <7671d3f0-ca07-7260-a855-473ab58d1c30@oracle.com>
 <CAERHkrtw3jH1eWn52r+L75k84SeYuvw12A5cbmofiNjoJFhEsw@mail.gmail.com>
 <b2b1b1f6-9790-73c7-8566-031ec28606a7@oracle.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Message-ID: <4e35f261-7965-3eee-cd5c-744b19de4a2b@linux.intel.com>
Date:   Thu, 9 May 2019 17:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <b2b1b1f6-9790-73c7-8566-031ec28606a7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 10:50 AM, Subhra Mazumdar wrote:
> 
>>> select_task_rq_* seems to be unchanged. So the search logic to find a cpu
>>> to enqueue when a task becomes runnable is same as before and doesn't do
>>> any kind of cookie matching.
>> Okay, that's true in task wakeup path, and also load_balance seems to pull task
>> without checking cookie too. But my system is not over loaded when I tested this
>> patch, so there is none or only one task in rq and on the rq's rb
>> tree, so this patch
>> does not make a difference.
> I had same hypothesis for my tests.
>>
>> The question is, should we do cookie checking for task selecting CPU and load
>> balance CPU pulling task?
> The basic issue is keeping the CPUs busy. In case of overloaded system,
> the trivial new idle balancer should be able to find a matching task
> in case of forced idle. More problematic is the lower load scenario when
> there aren't any matching task to be found but there are runnable tasks of
> other groups. Also wake up code path tries to balance threads across cores
> (select_idle_core) first which is opposite of what core scheduling wants.
> I will re-run my tests with select_idle_core disabled, but the issue is
> on x86 Intel systems (my test rig) the CPU ids are interleaved across cores
> so even select_idle_cpu will balance across cores first. May be others have
> some better ideas?
>>

We did an experiment on a coffee lake desktop that has 6 cores to see how load
balancing works for core scheduling.

In a nutshell, it seems like for workload like sysbench that are constant
and doesn't have much sleep/wakeups, load balancer is doing a pretty
good job, right on the money.  However, when we are overcommiting the
cpus heavily, and the load is non-constant with I/Os and lots of forks
like doing kernel build, it is much harder to get tasks placed optimally.

We set up two VMs, each in its own cgroup.  In one VM, we run the
benchmark. In the other VM, we run a cpu hog task for each vcpu to
provide a constant background load.

The HT on case with no core scheduling is used as baseline performance.

There are 6 cores on Coffee Lake test system.  We pick 3, 6 and 12
vcpu cases for each VM to look at the 1/2 occupied, fully occupied
and 2x occupied system when HT is used.

Sysbench  (Great for core sched)

		Core Sched			HT off
		------				----------	
		avg perf (std dev)		avg perf (std dev)
3vcpu/VM	+0.37%	(0.18%)			-1.52%	(0.17%)
6vcpu/VM	-3.36%	(2.04%)			-31.72%	(0.13%)
12vcpu/VM	+1.02%	(1.17%)			-31.03%	(0.07%)

Kernel build  (Difficult for core sched)

		Core Sched			HT off
		------				----------	
		avg perf (std dev)		avg perf (std dev)
3vcpu/VM	+0.05%	(1.21%)			-3.66%	(0.81%)
6vcpu/VM	-30.41%	(3.03%)			-40.73%	(1.53%)
12vcpu/VM	-34.03%	(2.77%)			-24.87%	(1.22%)

Tim
