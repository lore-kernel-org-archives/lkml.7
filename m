Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2804C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38B622DBF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfICTJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:09:28 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59239 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:09:27 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id 55191240009;
        Tue,  3 Sep 2019 19:09:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Sep 2019 21:09:24 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio/adc: Add a compatible string for
 JZ4770 SoC ADC
In-Reply-To: <20190728094523.2a161231@archlinux>
References: <20190727195940.14010-1-contact@artur-rojek.eu>
 <20190728094523.2a161231@archlinux>
Message-ID: <5dd8172ff664fa1795a10ef40960ba54@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Just reminding you of this patch set.

Artur

On 2019-07-28 10:45, Jonathan Cameron wrote:
> On Sat, 27 Jul 2019 21:59:38 +0200
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
>> Add a compatible string for the ADC controller present on
>> Ingenic JZ4770 SoC.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Hi Artur,
> 
> I'll have to hold this series for a few weeks as the fix for the
> clock rate divider isn't in my upstream for the togreg branch yet
> (as I haven't sent a pull request since the merge window).
> 
> Give me a poke if I seem to have forgotten these in a few weeks
> time.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> 
>> Changes:
>> 
>> v2: no change
>> 
>>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt 
>> b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>> index f01159f20d87..cd9048cf9dcf 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>  - compatible: Should be one of:
>>    * ingenic,jz4725b-adc
>>    * ingenic,jz4740-adc
>> +  * ingenic,jz4770-adc
>>  - reg: ADC controller registers location and length.
>>  - clocks: phandle to the SoC's ADC clock.
>>  - clock-names: Must be set to "adc".
