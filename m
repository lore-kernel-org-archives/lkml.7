Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0913B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DETkbkPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCHQfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:35:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39658 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHQfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4k71DbwlIHBNxWymdKtNVX4Eq1pYJjd8+cEjnlvypWc=; b=DETkbkPyY/XPe6Bf9mrON0aaG
        3d5LZOxqwAXUtgdU/N3kdh8IM8jcxXHLBE0lizXM11V7DTikDW55MXPV0OyYwuwxHrsW3PfUaJDoQ
        BYQlhg66MJ8x58+YBz8OM2O6cE3Unjb1oEY4bj6NZuhoylZMrlyc2kinpd+ODz0R4kSMlWTxmia1B
        Ku/TB/ZupXqPBGUF+Rj6O6FXKySii/zKKxCMe5qhlXrQEAlCNojrIqUsR0SecA9PmMd74KxyNM2jO
        x88UqgCZMyRr8GQpzM/gFY5uMLmIyzIO2ZlTOHfGfizQXWeTgs0rFb5qzCzXtHOteK8SdlDBPLa85
        FCdFSZ32g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2ISs-0006n7-94; Fri, 08 Mar 2019 16:35:18 +0000
Subject: Re: [PATCH 7/9] docs: Remove unknown 'hint' directive
To:     Markus Heiser <markus.heiser@darmarit.de>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-8-tobin@kernel.org>
 <77efd92e-f882-bb32-e58c-6836e4307744@infradead.org>
 <2e8c4224-181e-e107-51b9-86d2f1d41309@darmarit.de>
 <4b41199e-6b4c-d78d-9f3e-044d2ee599b5@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8ca3ea67-c4aa-dc06-fb21-0c5c58a09669@infradead.org>
Date:   Fri, 8 Mar 2019 08:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4b41199e-6b4c-d78d-9f3e-044d2ee599b5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/19 8:04 AM, Randy Dunlap wrote:
> On 3/8/19 12:27 AM, Markus Heiser wrote:
>>
>> Am 08.03.19 um 04:51 schrieb Randy Dunlap:
>>> On 3/7/19 1:11 PM, Tobin C. Harding wrote:
>>>> Current RST file contains an unknown directive causing Sphinx to emit
>>>>
>>>>     ERROR: Unexpected indentation.
>>>>
>>>> Use normal language construct instead.
>>>>
>>>> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
>>>
>>> This is a good idea.  My previous patch eliminated the warning but the
>>> ..hint is not presented very well in the generated output.  :)
>>>
>>> Thanks.
>>>
>>>> ---
>>>>   Documentation/driver-api/dmaengine/dmatest.rst | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
>>>> index 8d81f1a7169b..25eecd2769b0 100644
>>>> --- a/Documentation/driver-api/dmaengine/dmatest.rst
>>>> +++ b/Documentation/driver-api/dmaengine/dmatest.rst
>>>> @@ -59,8 +59,8 @@ parameter, that specific channel is requested using the dmaengine and a thread
>>>>   is created with the existing parameters. This thread is set as pending
>>>>   and will be executed once run is set to 1. Any parameters set after the thread
>>>>   is created are not applied.
>>
>>
>> Here a blank line is missed. Thats while '.. hint:' directive is not detected
>> well.  Without the blank line the '.. hint:` string is a part of the section
>> above.
> 
> I added a blank line and the ..hint still is not handled in any special
> manner.  That's why I prefer Tobin's patch.

Nak.  :(
I had looked at the wrong output file.
With my "blank line patch" applied, the ..hint directive does work,
so only the blank line is needed, as Markus said.


>>>> -.. hint::
>>>> -  available channel list could be extracted by running the following command::
>>>> +
>>>> +Hint: available channel list could be extracted by running the following command::
>>>>         % ls -1 /sys/class/dma/
>>
>>   -- Markus --
>>
> 
> 


-- 
~Randy
