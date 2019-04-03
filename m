Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CF4C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4B21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wepfVLKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCJbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:31:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59436 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCJbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:31:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x339V4ib011292;
        Wed, 3 Apr 2019 04:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554283864;
        bh=mmudK46J15CJFT4qMmYeR4xgQWqPuI4jG+nU4vhcOjs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wepfVLKEqZwkoO40p7KHsugofYqTPMaZCem4wi77kshSc2M2EK+K7k6bFlR0ZP9rT
         tOr3AG9remTdeAZSG/3x3Shtt7h1jMl9Si6zPjFP3BCan/EWWqdvWpD3n5qlfr+n5j
         KrDOUGDI41KBioczfdwu0MkcUaMwlWMgrhxdMblw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x339V4nB103943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Apr 2019 04:31:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 3 Apr
 2019 04:31:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 3 Apr 2019 04:31:03 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x339Uvam012755;
        Wed, 3 Apr 2019 04:30:58 -0500
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding documentation for TI
 syscon gate clock
To:     Rob Herring <robh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190312090518.28666-1-vigneshr@ti.com>
 <20190312090518.28666-2-vigneshr@ti.com> <20190328123142.GA6229@bogus>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a998b977-99ef-876e-a226-4f1738392f9f@ti.com>
Date:   Wed, 3 Apr 2019 12:30:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328123142.GA6229@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 14:31, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 02:35:17PM +0530, Vignesh Raghavendra wrote:
>> Add dt bindings for TI syscon gate clock.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>   .../bindings/clock/ti,syscon-gate-clock.txt   | 35 +++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
>> new file mode 100644
>> index 000000000000..f2bc4281ddba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
>> @@ -0,0 +1,35 @@
>> +TI syscon gate clock
>> +
>> +The gate clock node must be provided inside a system controller node.
>> +
>> +Required:
>> +- comaptible: Must be "ti,syscon-gate-clock"
>> +- reg: Offset of register that controls the clock within syscon regmap
>> +- ti,clock-bit-idx: bit index that control gate/ungating of clock
>> +- clocks: phandle to the clock parent
>> +- #clock-cells: must be <0>
>> +
>> +Example:
>> +	ctrlmmr_epwm_ctrl: syscon@104140{
>> +		compatible = "syscon", "simple-bus";
> 
> Can't be both of these...

Is this a hard requirement? We seem to have few instances in the various 
DTS files for various vendors where this is done, syscon is paired with 
simple-mfd or simple-bus, or something else.

Basically, syscon by itself does not probe its children, and you can't 
have the simple syscon support from kernel side if you don't have the 
syscon compatible. Alternative is that we don't add any of the syscon 
children under the syscon but add them as separate nodes outside it.

The above is not an issue for this patch itself if we ditch the separate 
clock nodes, but it is more of a question about the syscon functionality 
itself.

-Tero

> 
>> +		reg = <0x0 0x104140 0x0 0x18>;
>> +		ranges = <0x0 0x0 0x104140>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		ehrpwm0_tbclk: clk@0 {
>> +			compatible = "ti,syscon-gate-clock";
>> +			reg = <0x0>;
>> +			#clock-cells = <0>;
>> +			clocks = <&k3_clks 40 0>;
>> +			ti,clock-bit-idx = <0>;
> 
> This would imply you have multiple nodes at one address which is
> discouraged.
> 
>> +		};
> 
> We generally don't describe clocks as 1 clock per node. Give the parent
> a specific compatible and make it a clock provider.
> 
>> +
>> +		ehrpwm1_tbclk: clk@4 {
>> +			compatible = "ti,syscon-gate-clock";
>> +			reg = <0x4>;
>> +			#clock-cells = <0>;
>> +			clocks = <&k3_clks 41 0>;
>> +			ti,clock-bit-idx = <0>;
>> +		};
>> +	};
>> -- 
>> 2.21.0
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
