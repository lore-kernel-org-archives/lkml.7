Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C800CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEBC20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="qGlZh9wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJ2SyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:54:05 -0400
Received: from avasout03.plus.net ([84.93.230.244]:55912 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732093AbfJ2SyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:54:04 -0400
Received: from [10.0.2.15] ([146.198.133.39])
        by smtp with ESMTPA
        id PWcyigzCktvkXPWcziiYf9; Tue, 29 Oct 2019 18:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1572375243; bh=I4ZZ/wVJJQ0guXrWMZRkvryKrerb1ReP5+TDi/d996w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qGlZh9wka1XHevwqmEXD49cMDJJfe+FkSQGHxa1snuKSk6S2cgjCPgidJzixQZACE
         wUW2kiQI1FiTjd1ob1ZeayuihK5zg+aPVmAhvEfSBCL/Lm5zkYc5W3e3zyD5G6dnw7
         BZQUO7icHobzrrZFqfhzrm6FI4cFgw+k/g9UpyhRC2saG+qzples5/pDdSc/FB+o3T
         +EvtPc5/zBBu2vkEksa2KC4UqfCINtk+/N5ApeevynBL+EXTOrH7XT3lZnY0UFpRkt
         GtNCTULhBK7GtciDczTbi4mP2kN1/FtVKCsZIh1/L/LAo06NwwMSu9Eddj0cRYOat8
         0JzfIf7xWiPkw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=ePBtc0h1 c=1 sm=1 tr=0
 a=1Jh3712dEPwUcX5EWi7t+w==:117 a=1Jh3712dEPwUcX5EWi7t+w==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=491Ab-Zl-TA3clIL934A:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
 <20191028221523.vlzdk6dkcglxei6v@desk.local>
 <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
 <20191028230349.xlhm42ripxktx43y@desk.local>
 <61eb73ad-5c30-0005-5031-6584df72ad5f@ramsayjones.plus.com>
 <20191029080701.qpvscbz3xptadhbd@ltop.local>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ede574e5-d18d-f30c-b9f0-a39b73d57ff3@ramsayjones.plus.com>
Date:   Tue, 29 Oct 2019 18:54:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029080701.qpvscbz3xptadhbd@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDVoYw7ULPJG2gXopqFyDkmgZvbcO8oQUTiYMfxlmz6Gnd4uUsch0XW/zcYouohl3jtIkJ7OQVZAnwhkyFoc8eds9yVeMsZTsXYDLiJipbGXmrCsDCtr
 za5CAl/4tJyknl2EXIlMxmt+ZrMs1BCXQEdZJNpJgkUGb3yruOFNglrpSlbHwCzZuVqbv/oKFJb+Bw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2019 08:07, Luc Van Oostenryck wrote:
> On Tue, Oct 29, 2019 at 02:38:54AM +0000, Ramsay Jones wrote:
>> On 28/10/2019 23:03, Luc Van Oostenryck wrote:
>>> diff --git a/parse.c b/parse.c
>>> index 4464e2667..4b0a1566c 100644
>>> --- a/parse.c
>>> +++ b/parse.c
>>> @@ -345,6 +345,7 @@ static struct symbol_op goto_op = {
>>>  
>>>  static struct symbol_op __context___op = {
>>>  	.statement = parse_context_statement,
>>> +	.attribute = attribute_context,
>>
>> Hmm, so why is do we have a context_op and a __context___op?
>>
>>>  };
>>>  
>>>  static struct symbol_op range_op = {
>>> @@ -537,6 +538,7 @@ static struct init_keyword {
>>>  	{ "while",	NS_KEYWORD, .op = &while_op },
>>>  	{ "do",		NS_KEYWORD, .op = &do_op },
>>>  	{ "goto",	NS_KEYWORD, .op = &goto_op },
>>> +	{ "context",	NS_KEYWORD, .op = &context_op },
>>>  	{ "__context__",NS_KEYWORD, .op = &__context___op },
>>
>> So, can '__context__' be used in a statement, as well as an
>> attribute, while 'context' can only be used in an attribute?
> 
> Yes, indeed.

OK, so I wasn't quite as confused as I thought! ;-)

> '__context__' was only parsed as a statement and 'context'
> only as an attribute. But now we also want to be able to use
> '__context__' as an attribute (because 'context' is not a
> reserved keyword and can thus be a used defined macro).
> 
> There is no reason, though, we should now also want to use
> 'context' as a statement since it's a sparse extension. Hence
> adding attribute_context to '__context___op' and keeping
> 'context_op' as such (but moving them together).

Thanks for the explanation.

ATB,
Ramsay Jones

