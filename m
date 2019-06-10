Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137DC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC2C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 11:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbfFJLV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 07:21:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389686AbfFJLV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:21:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2CEB346;
        Mon, 10 Jun 2019 04:21:55 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224AD3F557;
        Mon, 10 Jun 2019 04:23:36 -0700 (PDT)
Subject: Re: Linux Testing Microconference at LPC
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, ionela.voinescu@arm.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <CAPhKKr9nm+JoLUu5g4ruop0589R0Mwbd+gqgG3T+WccjtUjw+g@mail.gmail.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <cf236d8c-9f95-59a3-1960-52c010bbc107@arm.com>
Date:   Mon, 10 Jun 2019 12:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhKKr9nm+JoLUu5g4ruop0589R0Mwbd+gqgG3T+WccjtUjw+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhaval,

On 5/22/19 5:11 PM, Dhaval Giani wrote:
>> Please let us know what topics you believe should be a part of the
>> micro conference this year.
> 
> At OSPM right now, Douglas and Ionela were talking about their
> scheduler behavioral testing framework using LISA and rt-app. This is
> an interesting topic, and I think has a lot of scope for making
> scheduler testing/behaviour more predictable as well as
> analyze/validate scheduler behavior. I am hoping they are able to make
> it to LPC this year.

We unfortunately won't be able to attend on that topic this year. We however do have
some documentation describing the way we use statistics in our testing methodology,
although it requires some level of familiarity with the tooling [LISA].
The [slides] from Valentin at OSPM 2019 describes some other aspects regarding noise handling.
All of that should probably be aggregated in some tool-agnostic part of the LISA documentation to make it
easier to grasp by the wider community, especially when it comes to test framework capabilities comparison.

If someone fancies a chat on tooling capabilities, we are also reachable on #arm-lisa channel on
freenode during European working hours.

[LISA] https://lisa-linux-integrated-system-analysis.readthedocs.io/en/master/workflows/automated_testing.html#analyzing-results
[slides] http://retis.sssup.it/ospm-summit/Downloads/01_07-SchedulerBehaviouralTesting_Schneider.pdf

> 
> Dhaval
> 

Best regards,

Douglas
