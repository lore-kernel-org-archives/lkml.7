Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA3C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2034D208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfFQQb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:31:28 -0400
Received: from smtp3.goneo.de ([85.220.129.37]:36582 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFQQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id DD80323F252;
        Mon, 17 Jun 2019 18:31:21 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s76l7b57MjrH; Mon, 17 Jun 2019 18:31:20 +0200 (CEST)
Received: from [192.168.10.227] (ip-109-91-78-216.hsi12.unitymediagroup.de [109.91.78.216])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 18BDE23F021;
        Mon, 17 Jun 2019 18:31:20 +0200 (CEST)
Subject: Re: [PATCH 12/14] doc-rst: add ABI documentation to the admin-guide
 book
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <9da2a7f6ff57d9d53dcbb964eb310f7956522870.1560477540.git.mchehab+samsung@kernel.org>
 <87o930uvur.fsf@intel.com> <2955920a-3d6a-8e41-e8fe-b7db3cefed8b@darmarit.de>
 <20190614081546.64101411@lwn.net>
 <327067f6-2609-41e6-c987-e37620e7154e@darmarit.de>
 <20190617061146.06975213@coco.lan>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <c3caf35e-9790-661f-e9db-0a050d31ca7d@darmarit.de>
Date:   Mon, 17 Jun 2019 18:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617061146.06975213@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 17.06.19 um 11:11 schrieb Mauro Carvalho Chehab:
> Em Sun, 16 Jun 2019 18:04:01 +0200
> Markus Heiser <markus.heiser@darmarit.de> escreveu:
> 
>> Am 14.06.19 um 16:15 schrieb Jonathan Corbet:
>>> On Fri, 14 Jun 2019 16:10:31 +0200
>>> Markus Heiser <markus.heiser@darmarit.de> wrote:
>>>    
>>>> I agree with Jani. No matter how the decision ends, since I can't help here, I'd
>>>> rather not show up in the copyright.
>>>
>>> Is there something specific you are asking us to do here?
>>>    
>>
>>
>> I have lost the overview, but there was a patch Mauro added a
>> kernel_abi.py.  There was my name (Markus Heiser) listed with a
>> copyright notation.
>>
>> I guess Mauro picked up some old RFC or an other old patch of
>> mine from 2016 and made some C&P .. whatever .. ATM I do not have
>> time to give any support on parsing ABI and I'am not interested
>> in holding copyrights on a C&P of a old source  ;)
> 
> Well, the code was basically written by you :-)
> 
> It was written to be a script capable of running a generic
> script. On that time, my contribution to it was basically
> to hardcode it to run "get_abi.pl".

Thanks for clarifying.

> 
> This came from an old branch where the last change was back in 2017.
> It was resurrected due to a discussion at KS ML.
> 
> There, the discussion was related to what's left to be converted
> to ReST.
> 
> While I can't simply remove your copyright, would you be happy
> with something like that?

Yes, but basically I share Jani's and Jon's doubts about this solution.

-- Markus --

> 
> 
> Thanks,
> Mauro
> 
> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> index 2d5d582207f7..ef91b1e1ff4b 100644
> --- a/Documentation/sphinx/kernel_abi.py
> +++ b/Documentation/sphinx/kernel_abi.py
> @@ -7,7 +7,8 @@ u"""
>       Implementation of the ``kernel-abi`` reST-directive.
>   
>       :copyright:  Copyright (C) 2016  Markus Heiser
> -    :copyright:  Copyright (C) 2016  Mauro Carvalho Chehab
> +    :copyright:  Copyright (C) 2016-2019  Mauro Carvalho Chehab
> +    :maintained-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>       :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
>   
>       The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
> 
> 


