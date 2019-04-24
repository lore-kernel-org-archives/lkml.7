Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C2BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1820835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfDXVeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:34:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730946AbfDXVeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:34:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E108AACCD;
        Wed, 24 Apr 2019 21:34:21 +0000 (UTC)
Date:   Wed, 24 Apr 2019 14:34:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Eric Wong <e@80x24.org>
Cc:     linux-kernel@vger.kernel.org, Omar Kilani <omar.kilani@gmail.com>
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190424213415.7muqd4tkuxsgwigz@linux-r8p5>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190424193903.swlfmfuo6cqnpkwa@dcvr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Eric Wong wrote:

>Omar Kilani <omar.kilani@gmail.com> wrote:
>> Hi there,
>>
>> I???m still trying to piece together a reproducible test that triggers
>> this, but I wanted to post in case someone goes ???hmmm... change X
>> might have done this???.
>
>Maybe Davidlohr knows, since he's responsible for most of the
>epoll changes in 5.0.

Not really, I have not been made aware of any issues until now.

>
>> Basically, something???s broken (or at least, has changed enough to
>> cause problems in user space) in epoll since 5.0. It???s still broken in
>> 5.1-rc5.
>>
>> It doesn???t happen 100% of the time. It???s sort of hard to pin down but
>> I???ve observed the following:
>>
>> * nginx not accepting connections under load
>> * A java app which uses netty / NIO having strange writability
>> semantics on channels, which confuses netty / java enough to not
>> properly flush written data on the socket.
>>
>> I went and tested these Linux kernels:
>>
>> 4.20.17
>> 4.19.32
>> 4.14.111
>>
>> And the issue(s) do not show up there.
>>
>> I???m still actively chasing this up, and will report back ??? I haven???t
>> touched kernel code in 15 years so I???m a little rusty. :)

A bisection and/or workload that triggers the issue would be great to
see what's going on.

Thanks,
Davidlohr
