Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33C0C04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94FB2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557960280;
	bh=RD/BsQzuTKMqyx5gPDoTRwO4+h8UvnjsTAjiA4VH+dg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=V70Lk+8WqPN2wsKxjjyMFxUu+o0XqhUDhgAqsCL+xTQbq5wPzmjWA7lJqirGjL9xc
	 VDiElGVVHzOgDkSWrS8kmrVfEMfSytPDaT3Zj4f5K6BhxxfswejPDRsJWt5ojZ+Zat
	 JTF/EeAFJ3Ar6gD1djBjtjV7clvKReDSB5EWO14U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEOWoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 18:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfEOWoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:44:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C817820862;
        Wed, 15 May 2019 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557960278;
        bh=RD/BsQzuTKMqyx5gPDoTRwO4+h8UvnjsTAjiA4VH+dg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LhV5qBs8pKqjgncDeKAmibIV69CTrusSWRPh93xY7VBDQkKGjDxTiZ/FncfOxjMCs
         3Yfzmtz29l+sKYfhD8THMKoQwc8pnMywTG5ttCrzX6dW9e+EpWOniSwYeLCzmvEomX
         BC8c7i4KWwWOWt2kwd58MPu7X8iAzRAkttnoyO0Q=
Subject: Re: Linux Testing Microconference at LPC
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com,
        shuah <shuah@kernel.org>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
Date:   Wed, 15 May 2019 16:44:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha and Dhaval,

On 4/11/19 11:37 AM, Dhaval Giani wrote:
> Hi Folks,
> 
> This is a call for participation for the Linux Testing microconference
> at LPC this year.
> 
> For those who were at LPC last year, as the closing panel mentioned,
> testing is probably the next big push needed to improve quality. From
> getting more selftests in, to regression testing to ensure we don't
> break realtime as more of PREEMPT_RT comes in, to more stable distros,
> we need more testing around the kernel.
> 
> We have talked about different efforts around testing, such as fuzzing
> (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> testing, test frameworks such as ktests, smatch to find bugs in the
> past. We want to push this discussion further this year and are
> interested in hearing from you what you want to talk about, and where
> kernel testing needs to go next.
> 
> Please let us know what topics you believe should be a part of the
> micro conference this year.
> 
> Thanks!
> Sasha and Dhaval
> 

A talk on KUnit from Brendan Higgins will be good addition to this
Micro-conference. I am cc'ing Brendan on this thread.

Please consider adding it.

thanks,
-- Shuah
