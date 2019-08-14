Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF5EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AE0208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfHNWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:22:40 -0400
Received: from foss.arm.com ([217.140.110.172]:34496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfHNWWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:22:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC72344;
        Wed, 14 Aug 2019 15:22:39 -0700 (PDT)
Received: from [10.1.196.61] (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C7C3F718;
        Wed, 14 Aug 2019 15:22:38 -0700 (PDT)
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Morten Borup Petersen <morten_bp@live.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
 <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
 <20190814100518.GA21898@e107155-lin>
 <CABb+yY1jZs0OU-oi86iNNHiqBTjaY6ixFPMoUPkU6MCH_YrwLg@mail.gmail.com>
 <20190814165133.GA8346@e107155-lin>
From:   "tushar.khandelwal@arm.com" <tushar.khandelwal@arm.com>
Message-ID: <55dcfe02-8c2c-4f9a-b467-bcac0d6b0fd7@arm.com>
Date:   Wed, 14 Aug 2019 23:22:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814165133.GA8346@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/08/2019 17:51, Sudeep Holla wrote:
> On Wed, Aug 14, 2019 at 09:52:25AM -0500, Jassi Brar wrote:
>> On Wed, Aug 14, 2019 at 5:05 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> On Tue, Aug 13, 2019 at 11:36:56AM -0500, Jassi Brar wrote:
>>> [...]
>>>
>>>>>>>
>>>>>>> As mentioned in the response to your initial comment, the driver does
>>>>>>> not currently support mixing protocols.
>>>>>>>
>>>>>> Thanks for acknowledging that limitation. But lets also address it.
>>>>>>
>>>>>
>>>>> We are hesitant to dedicate time to developing mixing protocols given
>>>>> that we don't have any current usecase nor any current platform which
>>>>> would support this.
>>>>>
>>>> Can you please share the client code against which you tested this driver?
>>>>  From my past experience, I realise it is much more efficient to tidyup
>>>> the code myself, than endlessly trying to explain the benefits.
>>>>
>>>
>>> Thanks for the patience and offer.
>>>
>> Ok, but the offer is to Morten for MHUv2 driver.
>>
>>> Can we try the same with MHUv1 and SCMI
>>> upstream driver.
>>>
>> MHUv1 driver is fine as it is.
>> I did try my best to keep you from messing the SCMI driver, without success
>> https://lkml.org/lkml/2017/8/7/924
> 
> I disagree, you haven't told me how to address the usecase which I mentioned
> with the abstraction/multiplexer on top of MHU as you have been suggesting.
> 
> I am sure MHUv2 will have the same usecase.
> 

MHUv2 driver is addressing existing (door-bell) use case as well as new 
(multi-word) use case using new IP features.

> --
> Regards,
> Sudeep
> 
