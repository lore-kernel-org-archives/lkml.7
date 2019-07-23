Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F440C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E6D22543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="umYZMvAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbfGWNgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:36:03 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56042 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfGWNgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:36:02 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6NDZjpQ018789;
        Tue, 23 Jul 2019 08:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563888945;
        bh=6Dck4gO4V5pnVJYCW/w9BCIIyokmJANz2CsTs7Xl2Y0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=umYZMvAKS0FeHtrhOnvVhYaa883PV5QS5KaqSE/finBhJKdSpfmREJxUSllYNZjr0
         DfdUJA6FaH8VNbuOv67vBN1K3sO/14ERt02jHbutq6VLntshkC4bh7zzOW/nKDTXJ/
         6J54n3/b/RsXw5B054GW9ld8onhV++nOJR1Zd4IE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6NDZj9C037519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jul 2019 08:35:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Jul 2019 08:35:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Jul 2019 08:35:45 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6NDZgYw073346;
        Tue, 23 Jul 2019 08:35:43 -0500
Subject: Re: [PATCH 3/9] dt-bindings: interrupt-controller: arm, gic-v3:
 Describe ESPI range support
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190723104437.154403-1-maz@kernel.org>
 <20190723104437.154403-4-maz@kernel.org>
 <04e80def-c8e3-a403-036e-2a64db935ed4@ti.com>
 <e67ff715-9625-6aec-5e1f-28f7c9df66f6@kernel.org>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2c331e5a-d47f-ceac-1c17-412816ff7369@ti.com>
Date:   Tue, 23 Jul 2019 19:05:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e67ff715-9625-6aec-5e1f-28f7c9df66f6@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/19 6:45 PM, Marc Zyngier wrote:
> On 23/07/2019 13:59, Lokesh Vutla wrote:
>>
>>
>> On 23/07/19 4:14 PM, Marc Zyngier wrote:
>>> GICv3.1 introduces support for new interrupt ranges, one of them being
>>> the Extended SPI range (ESPI). The DT binding is extended to deal with
>>> it as a new interrupt class.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>>> index c34df35a25fc..98a3ecda8e07 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>>> @@ -44,11 +44,12 @@ properties:
>>>        be at least 4.
>>>  
>>>        The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>>> -      interrupts. Other values are reserved for future use.
>>> +      interrupts, 2 for interrupts in the Extended SPI range. Other values
>>> +      are reserved for future use.
>>
>> Any reason why hardware did not consider extending SPIs from 1020:2043? This way
>> only EPPI would have been introduced. Just a thought.
> 
> First, 1020-1023 is the special INTID range. You can't have anything
> else there.
> 
> Then, making the range contiguous could imply that the range is also
> contiguous in the register space, which isn't possible (note that the
> EPPI range does it the other way around -- it is discontinuous in the
> INTID space, and yet continuous in the register space).
> 
> Finally, the decision to push the numbering out towards the LPI range
> allows the ESPI space to be grown easily up to 4k.

okay, got it.

> 
> But frankly, none of that really matters. They are just numbers.
> 
>> Either ways, just to be consistent with hardware numbering can ESPI range be 3
>> and EPPI range be 2?
> 
> Well, the way I see it is that it is more logical for the binding
> itself. We already have 0 for SPIs and 1 for PPIs, despite PPIs being
> before SPIs in the INTID space.

Agreed. Patch looks good to me. FWIW:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

> 
> Thanks,
> 
> 	M.
> 
