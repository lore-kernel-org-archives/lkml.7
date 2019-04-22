Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4020BC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1321B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 07:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDVHMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 03:12:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46238 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfDVHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 03:12:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id D321B278FE0
Subject: Re: Linux Testing Microconference at LPC
To:     Steven Rostedt <rostedt@goodmis.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <2dfb-5cb85000-7-65937800@86141034>
 <20190418092624.61b3611b@gandalf.local.home>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <c59e5962-1f4d-cac6-520a-8a5be076aa2f@collabora.com>
Date:   Mon, 22 Apr 2019 08:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190418092624.61b3611b@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 18/04/2019 14:26, Steven Rostedt wrote:
> On Thu, 18 Apr 2019 11:22:47 +0100
> "Gustavo Padovan" <gustavo.padovan@collabora.com> wrote:
> 
>> Guillaume would like to talk about the his work on kernelCI on automated bisection, functional testing and modular pipelines.
> 
> Can you be more specific about what Guillaume wants to talk about for
> those topics? I hope it's not just a "let everyone know what Guillaume
> has done" talk. Plumbers is about discussions of on going and future
> work. If these are all work-in-progress and Guillaume is looking for
> input from other stakeholder developers, then that is exactly what
> Plumbers is about. But if this is just to show developers what was done
> and how to use the finished work, then save that for something like
> Open Source Summit.

Sure, this is very much about discussing how to grow KernelCI in
a more community-driven way.  It should also help defining the
role of KernelCI in the wider kernel community, alongside other
test infrastructures.

As Gustavo mentioned, there is the bisection tool which has
already started to bear fruit.  It has a few known limitations
that I've already started to address and several aspects that
would be worth discussing for future development.  In particular,
it quickly gets a lot more complex when bisecting long test
suites compared to the simple boot tests we're doing now.

Then there is the topic of adding more test suites to cover more
areas of the kernel.  Ultimately it would be good to have a way
to enable anyone to submit a new test suite to KernelCI and not
just the small team of developers working on it now, to scale
proportionally with the size of the task.  It's also worth
discussing a strategy as to how to expand testing (which areas to
cover first, how to make best use of the available test capacity
etc.).

One more thing I have in mind is an idea I started to explain in
a document[1] whereby some components of the current KernelCI
system could have alternative instances.  For example, if an
organisation is doing some upstream kernel testing and wants to
join KernelCI to contribute the results, rather than requiring
all the tests to be run in LAVA or all the kernels to be built
with Jenkins on kernelci.org, there could be alternative
automated build systems for some binaries to be produced and
alternative test systems to test them.  Having a common test
results format also helps, but it's only the last step in the
pipeline so there is more to it if we want to explore the full
potential of collaborative testing.  So that seems like a good
subject for discussion too as it's mostly still all up in the
air.

Best wishes,
Guillaume

[1] https://groups.io/g/kernelci/topic/kernelci_modular_pipeline/29692355
