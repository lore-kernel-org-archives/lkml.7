Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A08120868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbkD2Nb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfCHQEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:04:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Arxyn05+HpySDYzmb+UxaUxYPP2cqICEsKadMfLK53I=; b=NbkD2Nb3TfjmQKyjr1NFRtx97
        e0PerFv8YdbNME5eO8oDQLT9mbQ3oOguishKwLguz9nszsgnOZZXhx5V9UVPg3dQ7uFGVXoYH1kIN
        7m4RF8dgTo+Ttdi+HxRShxIDAB5WnELMqmpgCAlIHtUOmj0CqGtUmELZrwGvjxMmWPTUBDbZlS13B
        t+lG3YgXVBhMLWVfFqrTi8u9LpImjXXcDa724g+kn05j8AAgOrZMnKb3RSBvW+zwSqjO8kNcSZPUJ
        3HNYMB/YCz2NPOqKSDpOFFdO55g3jLFOU/ejzSfObWeDeFFrxp8or6GGcnoAZ7Kotk7LU9yMnPHq+
        WOfj4cqAA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2HzE-0002gt-5g; Fri, 08 Mar 2019 16:04:40 +0000
Subject: Re: [PATCH 7/9] docs: Remove unknown 'hint' directive
To:     Markus Heiser <markus.heiser@darmarit.de>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-8-tobin@kernel.org>
 <77efd92e-f882-bb32-e58c-6836e4307744@infradead.org>
 <2e8c4224-181e-e107-51b9-86d2f1d41309@darmarit.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4b41199e-6b4c-d78d-9f3e-044d2ee599b5@infradead.org>
Date:   Fri, 8 Mar 2019 08:04:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2e8c4224-181e-e107-51b9-86d2f1d41309@darmarit.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 12:27 AM, Markus Heiser wrote:
> 
> Am 08.03.19 um 04:51 schrieb Randy Dunlap:
>> On 3/7/19 1:11 PM, Tobin C. Harding wrote:
>>> Current RST file contains an unknown directive causing Sphinx to emit
>>>
>>>     ERROR: Unexpected indentation.
>>>
>>> Use normal language construct instead.
>>>
>>> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
>>
>> This is a good idea.  My previous patch eliminated the warning but the
>> ..hint is not presented very well in the generated output.  :)
>>
>> Thanks.
>>
>>> ---
>>>   Documentation/driver-api/dmaengine/dmatest.rst | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
>>> index 8d81f1a7169b..25eecd2769b0 100644
>>> --- a/Documentation/driver-api/dmaengine/dmatest.rst
>>> +++ b/Documentation/driver-api/dmaengine/dmatest.rst
>>> @@ -59,8 +59,8 @@ parameter, that specific channel is requested using the dmaengine and a thread
>>>   is created with the existing parameters. This thread is set as pending
>>>   and will be executed once run is set to 1. Any parameters set after the thread
>>>   is created are not applied.
> 
> 
> Here a blank line is missed. Thats while '.. hint:' directive is not detected
> well.  Without the blank line the '.. hint:` string is a part of the section
> above.

I added a blank line and the ..hint still is not handled in any special
manner.  That's why I prefer Tobin's patch.

>>> -.. hint::
>>> -  available channel list could be extracted by running the following command::
>>> +
>>> +Hint: available channel list could be extracted by running the following command::
>>>         % ls -1 /sys/class/dma/
> 
>   -- Markus --
> 


-- 
~Randy
