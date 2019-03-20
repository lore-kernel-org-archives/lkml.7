Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F53C10F0D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747042186A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCTGON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:14:13 -0400
Received: from edison.jonmasters.org ([173.255.233.168]:59748 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfCTGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:14:12 -0400
Received: from [74.203.127.5] (helo=tonnant.bos.jonmasters.org)
        by edison.jonmasters.org with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <jcm@jonmasters.org>)
        id 1h6UUM-0001Kh-Bd; Wed, 20 Mar 2019 06:14:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com>
 <20190213073707.GA2875@kroah.com>
 <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
 <20190213091803.GA2308@kroah.com> <20190213192512.GH69686@sasha-vm>
 <20190213195232.GA10047@kroah.com>
 <79d10599-70d2-7d06-1cee-6e52d36233bf@jonmasters.org>
 <20190320050659.GA16580@kroah.com>
From:   Jon Masters <jcm@jonmasters.org>
Message-ID: <134e0fe1-e468-5243-90b5-ccb81d63e9a1@jonmasters.org>
Date:   Wed, 20 Mar 2019 02:14:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320050659.GA16580@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 74.203.127.5
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/19 1:06 AM, Greg KH wrote:
> On Tue, Mar 19, 2019 at 11:46:09PM -0400, Jon Masters wrote:
>> On 2/13/19 2:52 PM, Greg KH wrote:
>>> On Wed, Feb 13, 2019 at 02:25:12PM -0500, Sasha Levin wrote:
>>
>>>> So really, it sounds like a low hanging fruit: we don't really need to
>>>> write much more testing code code nor do we have to refactor existing
>>>> test suites. We just need to make sure the right tests are running on
>>>> stable kernels. I really want to clarify what each subsystem sees as
>>>> "sufficient" (and have that documented somewhere).
>>>
>>> kernel.ci and 0-day and Linaro are starting to add the fs and mm tests
>>> to their test suites to address these issues (I think 0-day already has
>>> many of them).  So this is happening, but not quite obvious.  I know I
>>> keep asking Linaro about this :(
>>
>> We're working on investments for LDCG[0] in 2019 that include kernel CI
>> changes for server use cases. Please keep us informed of what you folks
>> ultimately want to see, and I'll pass on to the steering committee too.
>>
>> Ultimately I've been pushing for a kernel 0-day project for Arm. That's
>> probably going to require a lot of duplicated effort since the original
>> 0-day project isn't open, but creating an open one could help everyone.
> 
> Why are you trying to duplicate it on your own?  That's what kernel.ci
> should be doing, please join in and invest in that instead.  It's an
> open source project with its own governance and needs sponsors, why
> waste time and money doing it all on your own?

To clarify, I'm pushing for investment in kernel.ci to achieve that goal
that it could provide the same 0-day capability for Arm and others.
It'll ultimately result in duplicated effort vs if 0-day were open.

Jon.
