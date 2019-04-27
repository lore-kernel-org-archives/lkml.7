Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605222084F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kOXVefpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfD0DBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:01:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36774 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfD0DBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:01:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3R30noV097744;
        Fri, 26 Apr 2019 22:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556334049;
        bh=LZCR6iKbbXEPqBepbMx2w7d7Lo5FnctqMVgc8kv1M8c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kOXVefpVWhb+zgn7q7TtEgyIS434p2jRwv5o/p3xTQ2d4S3EfLhpPH3GewqtMEz2G
         3eA1ksje+vUy96srr55lUzSys5AjfUPwWrobn7PfqpSlK/oCL2p/hLI5SlQpPOrk6/
         RREYqGTo9KZEtsBkOBymtE+IytLXw4Txz03X7iFI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3R30nG1036899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 22:00:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 22:00:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 22:00:48 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3R30hwL099822;
        Fri, 26 Apr 2019 22:00:44 -0500
Subject: Re: [PATCH v4 4/5] dt-bindings: mtd: Add bindings for TI's AM654
 HyperBus memory controller
To:     Rob Herring <robh@kernel.org>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20190423104814.5762-1-vigneshr@ti.com>
 <20190423104814.5762-5-vigneshr@ti.com> <20190426202025.GA24486@bogus>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <0972151d-5911-5a6e-da36-8fa8e1761e30@ti.com>
Date:   Sat, 27 Apr 2019 08:31:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426202025.GA24486@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/19 1:50 AM, Rob Herring wrote:
> On Tue, Apr 23, 2019 at 04:18:13PM +0530, Vignesh Raghavendra wrote:
>> Add binding documentation for TI's HyperBus memory controller present on
>> AM654 SoC.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 32 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 33 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>> new file mode 100644
>> index 000000000000..fc87c7918389
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>> @@ -0,0 +1,32 @@
>> +Bindings for HyperBus Memory Controller (HBMC) on TI's K3 family of SoCs
>> +
>> +Required properties:
>> +- compatible : "ti,am654-hbmc" for AM654 SoC
>> +- reg : Two entries:
>> +	First entry pointed to the register space of HBMC controller
>> +	Second entry pointing to the memory map region dedicated for
>> +	MMIO access to attached flash devices
>> +- ranges : Address range allocated for each chipselect in the MMIO space
>> +
>> +Optional properties:
>> +- mux-controls : phandle to the multiplexer that controls selection of
>> +		 HBMC vs OSPI. Mux state of 1 indicates HBMC is selected.
> 
> So 1 is also the default because your example doesn't have the property?
> 

No default is 0. Will fix the example.

>> +
>> +Example:
>> +
>> +	hbmc: hbmc@47034000 {
>> +		compatible = "ti,am654-hbmc";
>> +		reg = <0x0 0x47034000 0x0 0x100>,
>> +			<0x5 0x00000000 0x1 0x0000000>;
>> +		power-domains = <&k3_pds 55>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
>> +			 <0x1 0x5 0x04000000 0x4000000>; /* CS1 - 64MB
> 
> This is wrong. You need 2 cells for the child address. The first cell is 
> the CS and the 2nd cell is the offset (typically 0). Otherwise you have 
> overlapping addresses with child addresses 0 and 1.
> 

Oops, didn't think of that. Will fix in the next version.

>> +
>> +		/* Slave flash node */
>> +		flash@0 {
> 
> And then the unit-address here would be '0,0'.
> 
>> +			compatible = "cypress,hyperflash";
> 
> Doesn't match what you defined for this binding.

Will update. Thanks for the review!

> 
>> +			reg = <0x0 0x4000000>;
>> +		};
>> +	};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a5f22f85c848..1ade81f9a32a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7258,6 +7258,7 @@ S:	Supported
>>  F:	drivers/mtd/hyperbus/
>>  F:	include/linux/mtd/hyperbus.h
>>  F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
>> +F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
>>  
>>  HYPERVISOR VIRTUAL CONSOLE DRIVER
>>  L:	linuxppc-dev@lists.ozlabs.org
>> -- 
>> 2.21.0
>>

-- 
Regards
Vignesh
