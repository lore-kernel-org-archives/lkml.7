Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F1BC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E820830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d7NKWpKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbfIMMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:19:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40182 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388317AbfIMMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:19:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8DCJSfr030974;
        Fri, 13 Sep 2019 07:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568377168;
        bh=dpFGMm+i4Q/XNLpCLmprRJVVJLyjRFGXq1ONFfGsX5c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d7NKWpKdBjaikFODQypm4iaEg+cZRfyjJFwh78TBaWyS3UuTwwrfMkaJTaw9/XuKW
         I9YCmVbZZIA6+HmoCpUioUG5ASI3+nMm1OUFo+GncyV/IMhp0sZqXX5f1dijY13fFb
         BSE1yVRRqt31XlMa5W/BaZXxrcwO4Y9Gp3ANh138=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8DCJSBW046322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Sep 2019 07:19:28 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 13
 Sep 2019 07:19:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 13 Sep 2019 07:19:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8DCJOGJ003752;
        Fri, 13 Sep 2019 07:19:24 -0500
Subject: Re: [RFC 1/3] dt-bindings: dma: Add documentation for DMA domains
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>
References: <20190906141816.24095-1-peter.ujfalusi@ti.com>
 <20190906141816.24095-2-peter.ujfalusi@ti.com>
 <961d30ea-d707-1120-7ecf-f51c11c41891@ti.com>
 <20190908121058.GL2672@vkoul-mobl>
 <a452cd06-79ca-424d-b259-c8d60fc59772@ti.com>
 <20190912170312.GD4392@vkoul-mobl>
 <1992ccdd-78b3-f248-3d4d-76b5e6d4cb37@ti.com>
 <20190913103654.GE4392@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <12accd8e-a8ad-1ac6-d394-6f4d90011c9f@ti.com>
Date:   Fri, 13 Sep 2019 15:19:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913103654.GE4392@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod,

On 13/09/2019 13.36, Vinod Koul wrote:
>>> So you have dma, xbar and client? And you need to use a specfic xbar,
>>> did i get that right?
>>
>> At the end yes.
> 
> :)
> 
>> EDMA have dedicated crossbar
>> sDMA have dedicated crossbar
> 
> So the domain mapping should point to crossbar.
> 
>> Slave devices must use the crossbar to request channel from the DMA
>> controllers. Non slave request are directed to the controllers directly
>> (no DT binding).
> 
> The clients for these are different right, if so slave clients will
> point to domain xbar and non slave will point to domain controller (to
> make everyone use domains). Non domain get any channel ... (fallback as
> well)
> 
> 
>> At minimum we would need a new property for DMA routers.
>> dma-domain-router perhaps which is pointing to the xbar.
> 
> Precisely!

After some thinking at the end we have two main type of DMA channels:
slave channels: Hw triggered channels
non-slave channels: SW triggered channels w/o DMA request lines

right?

Slave channels must be described in DT as we need to specify the DMA
request number/line/trigger, whatever it is called on different platforms.

non-slave channels on the other hand can be requested from any
controllers which can execute it. Or in the scope of this series, from
the controller which is best suited to service the device or module.

If we really want to move to similar binding structure as interrupts
opposed to what we have atm (gpio, pwm, leds, etc uses the same
principle), then

dma-slave-controller: can point to a dma controller or dma router which
should be used from the node it is presented inherited by it's child
nodes for slave channels.

dma-nonslave-controller: can point to a dma controller which should be
used from the node it is presented inherited by it's child nodes for non
slave channels.

DMA routers have the phandle for the dma controller they are attached
to, so this should be fine, I guess.

Based on the topology of the SoC, these can be added in higher level in
the tree to divert from the higher level controller selection.

>> A slave channel request would first look for dma-domain-router, if it is
>> there, the request goes via that.
>> If not then look for dma-domain-controller and use it for the request.
>> The DMA binding can drop the phandle to the xbar/dma.
>> Request for not slave channel would only look for dma-domain-controller.
>>
>>
>> But...
>>
>> - If we have one dedicated memcpy DMA and one for slave usage.
>> In top we declare dma-domain-controller = <&m2m_dma>;
>>
>> Then you have  a slave client somewhere
>> client1: peripheral@42 {
>> 	dma-domain-controller = <&slave_dma>;
>> 	dmas = <6>, <7>;
>> 	dma-names = "tx", "rx";
>> };
>>
>> This is fine I guess. But what would we do if the driver for client1
>> needs additional memcpy channel? By the definition of the binding the
>> non slave channel should be taken from the closest dma-domain-controller
>> which is not what we want. We want the channel from m2m_dma.
> 
> I would not envision same controller needs both memcpy or slave
> channels. If so, that should be represented as something like dma-names
> and represent two sets of dmas one for domain1 and another for domain2.
> 
> I would generalize it and not call it memcpy/slave but just domains and
> have a controller use multiple domains (if we have a super controller
> which can do that :D)
> 
> client1: peripheral@42 {
>         dma-domain-names = "memcpy", "slave";
>         dma-domains = <&mem_dma>, <&slave_dma>;
>         ...
> };

Right, similar thing should work, I guess.

/ {
	/* DDR to DDR is used in main_udmap */
	dma-domain-names = "memcpy";
	dma-domains = <&main_udmap>;

	cbass_main {
		/* memcpy is from main_udmap and slaves also */
		dma-domain-names = "slave";
		dma-domains = <&main_udmap>;

		cbass_mcu {
			/* memcpy is from mcu_udmap and slaves also */
			dma-domain-names = "memcpy", "slave";
			dma-domains = <&mcu_udmap>, <&mcu_udmap>;

		};
	};
};

or

/ {
	/* memcpy is from edma and slaves also */
	dma-domain-names = "memcpy", "slave";
	dma-domains = <&edma>, <&edma>;

	edma_xbar1 xbar@0 {
		/*
		 * DMA router on front of edma,
		 * optionally can be explicitly tell the DMA controller
		 * to be used with the router if needed.
		 */

		dma-domain-names = "slave";
		dma-domains = <&main_udmap>;
	};

	mcbsp muxed_dma@0 {
		/* memcpy is from edma and slaves from edma_xbar1 */
		dma-domain-names = "slave";
		dma-domains = <&edma_xbar1>;
	};

	voice muxed_dma@1 {
		/* memcpy is from edma and slaves from edma_xbar1 */
		dma-domain-names = "slave";
		dma-domains = <&edma_xbar1>;
	};

	something not_muxed@0 {
		/* memcpy is from edma and slaves also */
	};
};

Even the DMA router binding can be changed to look for the "slave"
domain it belongs to?

The the dmas can drop the phandle to the controller/router

Internal API wise, things could use
dmaengine_get_slave_domain(struct device *client_dev);
if we get a domain, we know the the binding does not include the phandle
for the controller.

and
dmaengine_get_nonslave_domain(struct device *client_dev);

The DMA routers and drivers might need to be changed, not sure if they
would notice the drop of the first phandle from the binding...

>>
>> And no, we can not start looking for the dma-domain-controller starting
>> from the root as in most cases the dma-domain-controller closer to the
>> client is what we really want and not the globally best controller.
>>
>> - How to handle the transition?
>>
>> If neither dma-domain-controller/router is found, assume that the first
>> argument in the binding is a phandle to the dma/router?
>> We need to carry the support for what we have today for a long time. The
>> kernel must boot with old DT blob.
>>
>> - Will it make things cleaner? Atm it is pretty easy to see which
>> controller/router is used for which device.

Is this big change worth to push for?


>> - Also to note that the EDMA and sDMA bindings are different, so we can
>> not just swap dma-domain-controller/router underneath, we also need to
>> modify the client's dmas line as well.
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
