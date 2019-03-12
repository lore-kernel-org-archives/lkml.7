Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9F2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XqAz5d6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCLPO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:14:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Ttww9efOhj0n0HMA/voUv01eMzuj9kJ5qQR1qWTnBk=; b=XqAz5d6kEyAFqgvChY6W9Jq0D
        qFEk/fzOZqKXNW73zeR7T3bf/poe7R+oBMA2ULBfJUfbPkY3DaB1jt6BDEZ8/mAl7eOkzO7vVdWgc
        YY2sLtAlQGU89PQT39ldzUA/ndvX9qri4zY26rTkSMN5ZN/GO+AuXfH2vLOPYX0Nrf7XLGnxE1M89
        RLLfBGBaOAvFgUDy+i3bGYj+z50UxBX6Rx3X/KX5sNX0rk59YKvLqnaMfoPaDOYPBzXxh2b99vrDZ
        XCwDDXeSwmIfYn3Caz+5gC1kelyY+4DmNvC9BZBiYo2sF/axhZ34ksHiYFs0HLZA+rbJX002+wbEr
        Kaa20XDaw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3j7F-00070j-FU; Tue, 12 Mar 2019 15:14:57 +0000
Subject: Re: [PATCH] kernel/trace/trace_kprobe.c - fix comment format
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <2812.1552381112@turing-police>
 <20190312110151.00e0df4d@gandalf.local.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8869c042-aba9-f29b-db16-342d64769e04@infradead.org>
Date:   Tue, 12 Mar 2019 08:14:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312110151.00e0df4d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/19 8:01 AM, Steven Rostedt wrote:
> On Tue, 12 Mar 2019 04:58:32 -0400
> "Valdis Klētnieks" <valdis.kletnieks@vt.edu> wrote:
> 
>>   CC      kernel/trace/trace_kprobe.o
>> kernel/trace/trace_kprobe.c:41: warning: cannot understand function prototype: 'struct trace_kprobe '
>>
>> The real problem is that a comment looked like kerneldoc when it shouldn't be...
>>
>> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
>>
>> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
>> index 9eaf07f99212..c825c591553a 100644
>> --- a/kernel/trace/trace_kprobe.c
>> +++ b/kernel/trace/trace_kprobe.c
>> @@ -35,7 +35,7 @@ static struct dyn_event_operations trace_kprobe_ops = {
>>  	.match = trace_kprobe_match,
>>  };
>>  
>> -/**
>> +/*
> 
> NACK.
> 
> This isn't a kernel doc comment, and I don't want to make it one when
> it is not. Just ignore that warning.
> 
> -- Steve

Huh?  The patch doesn't do that -- it does the opposite of that.
I.e., begin a non-kernel-doc comment with /* instead of /**.

> 
>>   * Kprobe event core functions
>>   */
>>  struct trace_kprobe {
> 


-- 
~Randy
