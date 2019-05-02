Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CA7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD04205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBO2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:28:46 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.36]:19117 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbfEBO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:28:46 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 36DF1400D7A2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 May 2019 09:28:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id MChYhIyKviQerMChYhyVJ8; Thu, 02 May 2019 09:28:44 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=55820 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hMChX-000a4y-Fh; Thu, 02 May 2019 09:28:43 -0500
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
 <20190502135636.GT26546@localhost>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <f3fd7ece-98ff-4b67-6115-5f599e183508@embeddedor.com>
Date:   Thu, 2 May 2019 09:28:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502135636.GT26546@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hMChX-000a4y-Fh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.203]:55820
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 8:56 AM, Johan Hovold wrote:
> On Thu, May 02, 2019 at 08:22:30AM -0500, Gustavo A. R. Silva wrote:
>>
>>
>> On 5/2/19 5:26 AM, Johan Hovold wrote:
>>> On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>>>> cases where we are expecting to fall through.
>>>>
>>>> This patch fixes the following warnings:
>>>>
>>>> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
>>>> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>     if (bufferLength == 0) {
>>>>        ^
>>>> drivers/usb/serial/io_edgeport.c:1755:3: note: here
>>>>    case EXPECT_HDR2:
>>>>    ^~~~
>>>> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>>      if (bufferLength == 0) {
>>>>         ^
>>>> drivers/usb/serial/io_edgeport.c:1816:3: note: here
>>>>    case EXPECT_DATA: /* Expect data */
>>>>    ^~~~
>>>>
>>>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>>>
>>>> Notice that, in this particular case, the code comments are modified
>>>> in accordance with what GCC is expecting to find.
>>>>
>>>> This patch is part of the ongoing efforts to enable
>>>> -Wimplicit-fallthrough.
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>> ---
>>>> Changes in v2:
>>>>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
>>>>    instead of warning level 2.
>>>>  - All warnings in the switch statement are addressed now.
>>>>
>>>> Notice that these are the last remaining fall-through warnings
>>>> in the USB subsystem. :)
>>>
>>>>  drivers/usb/serial/io_edgeport.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
>>>> index 4ca31c0e4174..7ad10328f4e2 100644
>>>> --- a/drivers/usb/serial/io_edgeport.c
>>>> +++ b/drivers/usb/serial/io_edgeport.c
>>>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>>>>  				edge_serial->rxState = EXPECT_HDR2;
>>>>  				break;
>>>>  			}
>>>> -			/* otherwise, drop on through */
>>>> +			/* Fall through - otherwise, drop on through */
>>>>  		case EXPECT_HDR2:
>>>>  			edge_serial->rxHeader2 = *buffer;
>>>>  			++buffer;
>>>> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>>>>  				}
>>>>  				/* Else, drop through */
>>>>  			}
>>>> +			/* Fall through */
>>>>  		case EXPECT_DATA: /* Expect data */
>>>
>>> Looks like you forgot to take the original review feedback you got into
>>> account:
>>>
>>> 	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no
>>>
>>
>> Oh, the thing is that the fall-through comments have to be placed at
>> the very bottom of the case. Also, based on that feedback, this time
>> I left the "Else, drop through" comment in place, so people can be
>> informed that such fall-through is conditional.
>>
>> What do you think about this:
>>
>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
>> index 4ca31c0e4174..52f27fc82563 100644
>> --- a/drivers/usb/serial/io_edgeport.c
>> +++ b/drivers/usb/serial/io_edgeport.c
>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>>                                 edge_serial->rxState = EXPECT_HDR2;
>>                                 break;
>>                         }
>> -                       /* otherwise, drop on through */
>> +                       /* Fall through - otherwise, drop on through */
>>                 case EXPECT_HDR2:
>>                         edge_serial->rxHeader2 = *buffer;
>>                         ++buffer;
>> @@ -1813,6 +1813,11 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>>                                 }
>>                                 /* Else, drop through */
>>                         }
>> +                       /* Beware that, currently, there are at least three
>> +                        * break statements in this case block, so the
>> +                        * fall-through marked below is NOT unconditional.
>> +                        */
>> +                       /* Fall through */
>>                 case EXPECT_DATA: /* Expect data */
>>                         if (bufferLength < edge_serial->rxBytesRemaining) {
>>                                 rxLen = bufferLength;
> 
> It's better than v2, but I thought you said you were gonna look into
> restructuring the code to maintain (or even improve) readability?
> 

At first, I thought about that, but now I don't think that's realistic.
I'd turn the if-else into a switch, and based on the history of feedback
on this patch, we will end up having the same complains about the break
statements in that new switch and the possibility of a fall-through to
case EXPECT_DATA. At the end I would still have to add a comment explaining
that the last fall-through mark in unconditional.

Thanks
--
Gustavo





