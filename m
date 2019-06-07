Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38079C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047BB208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ktNXUQwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfFGJ1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:27:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60942 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfFGJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:27:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x579Q2tp108826;
        Fri, 7 Jun 2019 04:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559899562;
        bh=x+/jv4waw72NZPJ7GdwLNaaEhDeI1awerl2cDh5XcZY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ktNXUQwG/yZcCDBhASfElEin9+2Y1xTmL6BrRyKyHCR1eLaxfVXtY3E5Svcf0V1XS
         uFiO8v6Ryunl5VgIk+F89bnlnAbNRwIzmoKMPzoPv5g1REU97rTg5iL1xoSaRhWIub
         aNTBb2Zn/mWr243Q2ANpOdU7eyTpThdKF3bOLTzM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x579Q2n5026948
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Jun 2019 04:26:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 7 Jun
 2019 04:26:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 7 Jun 2019 04:26:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x579Pvme094604;
        Fri, 7 Jun 2019 04:25:58 -0500
Subject: Re: [PATCH v7 1/6] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1559729030-16390-1-git-send-email-pawell@cadence.com>
 <1559729030-16390-2-git-send-email-pawell@cadence.com>
 <f032b3f3-409d-b0fc-8d5f-01c898b4c7a7@ti.com>
 <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <64be9d26-2a68-1b90-89c8-29b227e0cd9c@ti.com>
Date:   Fri, 7 Jun 2019 12:25:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB470903AF06C1F8A34BBB3C64DD100@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2019 07:46, Pawel Laszczak wrote:
> 
>>
>> Pawel,
>>
>> On 05/06/2019 13:03, Pawel Laszczak wrote:
>>> This patch aim at documenting USB related dt-bindings for the
>>> Cadence USBSS-DRD controller.
>>>
>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>> ---
>>>  .../devicetree/bindings/usb/cdns-usb3.txt     | 30 +++++++++++++++++++
>>>  1 file changed, 30 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
>>> new file mode 100644
>>> index 000000000000..1d2b449e3cb4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
>>> @@ -0,0 +1,30 @@
>>> +Binding for the Cadence USBSS-DRD controller
>>> +
>>> +Required properties:
>>> +  - reg: Physical base address and size of the controller's register areas.
>>> +	 Controller has 3 different regions:
>>> +	 region 1 - HOST registers area
>>> +	 region 2 - DEVICE registers area
>>> +	 region 3 - OTG/DRD registers area
>>> +  - reg-names - register memory area names:
>>> +	"xhci" - for HOST registers space
>>> +	"dev" - for DEVICE registers space
>>> +	"otg" - for OTG/DRD registers space
>>> +  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
>>> +  - interrupts: Interrupts used by cdns3 controller.
>>
>> Since we are requesting 3 separate named interrupts in code we need to
>> mention them here.
> 
> Hi Roger, 
> 
> Yes, I know, but this code is Reviewed-by: Rob Herring, so I thought to add 
> this as separate patch after putting this driver into kernel.
> 

Binding document should be updated as code changes.

> I assume that after making some change in this file I should remove statement
> Reviewed-by: Rob Herring <robh@kernel.org> from this patch to start reviving 
> from the beginning.  

Yes.

> 
> What do you think about such dt-binding:
> 
> Required properties:
>   - reg: Physical base address and size of the controller's register areas.
>          Controller has 3 different regions:
>          region 1 - HOST registers area
>          region 2 - DEVICE registers area
>          region 3 - OTG/DRD registers area

Is it so that region 1 is always HOST?
offset 0 seems to be OTG though.

If it is implementation specific then you could get rid of numbering.

>   - reg-names - register memory area names:
>         "xhci" - for HOST registers space
>         "dev" - for DEVICE registers space
>         "otg" - for OTG/DRD registers space
>   - compatible: Should contain:
>         "cdns,usb3-1.0.0" - for 0x00024502 controller version
>         "cdns,usb3-1.0.1" - for 0x00024509 controller version
>         "cdns,usb3-1.0.2" - for 0x0002450C controller version
>         "cdns,usb3-1.0.3" - for 0x0002450d controller version
> 
> - interrupts: Interrupts used by cdns3 controller:
>         "host" - interrupt used by XHCI driver.
>         "peripheral" - interrupt used by device driver
>         "otg" - interrupt used by DRD/OTG  part of driver
> 
> Optional properties:
>  - maximum-speed : valid arguments are "super-speed", "high-speed" and
>                    "full-speed"; refer to usb/generic.txt
>  - dr_mode: Should be one of "host", "peripheral" or "otg".
>  - phys: reference to the USB PHY

need to add 'phy-names' since you request the PHY with name.

>  - on-chip-buff-size : size of memory intended as internal memory for endpoints
>         buffers expressed in KB
> 
> Example:
>         usb@f3000000 {
>                 compatible = "cdns,usb3-1.0.1";
>                 interrupts = <USB_HOST_IRQ  7 IRQ_TYPE_LEVEL_HIGH>

coma missing.
>                                 <USB_DEVICE_IRQ  7 IRQ_TYPE_LEVEL_HIGH>
here too.
>                                 <USB_OTG_IRQ  8 IRQ_TYPE_LEVEL_HIGH>;

What is 7 and 8 ?

>                 interrupt-names = "host", "peripheral", "otg";
>                 reg = <0xf3000000 0x10000       /* memory area for HOST registers */

should end with >,

>                         0xf3010000 0x10000      /* memory area for DEVICE registers */
here too

>                         0xf3020000 0x10000>;    /* memory area for OTG/DRD registers */
>                 reg-names = "xhci", "dev", "otg";
>         };

Isn't otg at offset 0, xhci at offset 0x10000 and dev at offset 0x20000?

> 
> Is this correct now ?
> 
> Maybe I should add something additionally for phy ?

e.g.

                        phys = <&usb3_phy>;
                        phy-names = "cdns3,usbphy";

> 
> Regards,
> Pawel
> 
>   
>>
>>> +
>>> +Optional properties:
>>> + - maximum-speed : valid arguments are "super-speed", "high-speed" and
>>> +                   "full-speed"; refer to usb/generic.txt
>>> + - dr_mode: Should be one of "host", "peripheral" or "otg".
>>> + - phys: reference to the USB PHY
>>> +
>>> +Example:
>>> +	usb@f3000000 {
>>> +		compatible = "cdns,usb3-1.0.1";
>>> +		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
>>
>> This example won't work as code requests for 3 separate interrupts.
>>
>>> +		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
>>> +			0xf3010000 0x10000	/* memory area for DEVICE registers */
>>> +			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
>>> +		reg-names = "xhci", "dev", "otg";
>>> +	};
>>>
>>


-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
