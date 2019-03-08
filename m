Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCC920811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCHIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:36:58 -0500
Received: from smtp3.goneo.de ([85.220.129.37]:33224 "EHLO smtp3.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfCHIg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:36:58 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Mar 2019 03:36:56 EST
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 8086223F0F1;
        Fri,  8 Mar 2019 09:32:00 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SqIqzS1o7_lS; Fri,  8 Mar 2019 09:31:59 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-091-248-065-152.ewe-ip-backbone.de [91.248.65.152])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 5ACB823F460;
        Fri,  8 Mar 2019 09:31:59 +0100 (CET)
Subject: Re: [PATCH 7/9] docs: Remove unknown 'hint' directive
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-8-tobin@kernel.org>
 <77efd92e-f882-bb32-e58c-6836e4307744@infradead.org>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <2e8c4224-181e-e107-51b9-86d2f1d41309@darmarit.de>
Date:   Fri, 8 Mar 2019 09:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <77efd92e-f882-bb32-e58c-6836e4307744@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 08.03.19 um 04:51 schrieb Randy Dunlap:
> On 3/7/19 1:11 PM, Tobin C. Harding wrote:
>> Current RST file contains an unknown directive causing Sphinx to emit
>>
>> 	ERROR: Unexpected indentation.
>>
>> Use normal language construct instead.
>>
>> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> 
> This is a good idea.  My previous patch eliminated the warning but the
> ..hint is not presented very well in the generated output.  :)
> 
> Thanks.
> 
>> ---
>>   Documentation/driver-api/dmaengine/dmatest.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
>> index 8d81f1a7169b..25eecd2769b0 100644
>> --- a/Documentation/driver-api/dmaengine/dmatest.rst
>> +++ b/Documentation/driver-api/dmaengine/dmatest.rst
>> @@ -59,8 +59,8 @@ parameter, that specific channel is requested using the dmaengine and a thread
>>   is created with the existing parameters. This thread is set as pending
>>   and will be executed once run is set to 1. Any parameters set after the thread
>>   is created are not applied.


Here a blank line is missed. Thats while '.. hint:' directive is not detected
well.  Without the blank line the '.. hint:` string is a part of the section
above.

>> -.. hint::
>> -  available channel list could be extracted by running the following command::
>> +
>> +Hint: available channel list could be extracted by running the following command::
>>   
>>       % ls -1 /sys/class/dma/

   -- Markus --

