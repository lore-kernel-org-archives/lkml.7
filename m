Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D3B20673
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfFRPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:51:09 -0400
Received: from foss.arm.com ([217.140.110.172]:47596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfFRPvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:51:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0EC2B;
        Tue, 18 Jun 2019 08:51:08 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE4273F718;
        Tue, 18 Jun 2019 08:51:07 -0700 (PDT)
Subject: Re: [PATCH] docs/vm: hwpoison.rst: Fix quote formatting
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20190618145605.21208-1-valentin.schneider@arm.com>
 <20190618093159.26352aed@lwn.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1b60185d-1fb4-b8f0-c7c2-9fb50f550566@arm.com>
Date:   Tue, 18 Jun 2019 16:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618093159.26352aed@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2019 16:31, Jonathan Corbet wrote:
> On Tue, 18 Jun 2019 15:56:05 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
> 
>> The asterisks prepended to the quoted text currently get translated to
>> bullet points, which gets increasingly confusing the smaller your
>> screen is (when viewing the sphinx output, that is).
>>
>> Convert the whole quote to a literal block.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> That definitely seems worth fixing, and I can apply this.  But a few
> things to ponder first...
> 
>  - If you convert it to a literal block, the asterisks can remain, making
>    for a less intrusive patch.
> 
>  - I was wondering if we should just use a kernel-doc directive to pull
>    the comment directly from the source, but investigation quickly showed
>    that the "overview comment" doesn't actually exist in anything close to
>    the quoted form.  See mm/memory-failure.c.
> 
> Given that, and things like references to support in "upcoming Intel
> CPUs", I suspect that this document is pretty seriously out of date and
> needs some more in-depth attention.  If you're playing in this area and
> feel like it, updating the document for real would be much appreciated...:)
> 

I'm afraid this was only a "drive-by" patch, as I just happened to skim
through this page on my phone while waiting for a meeting - I'm quite
clueless about page poisoning.

However, I could try to replace the quote with a kernel-doc directive to
get a more up-to-date description (and maybe add a small note to say the
rest of the doc is somewhat outdated). That, or just keep the quote as is
but keep the asterisks - whichever you're happier with.

> Thanks,
> 
> jon
> 
