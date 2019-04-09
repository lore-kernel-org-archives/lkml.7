Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E65CC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5820857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q0vzZ83l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDIH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:56:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:56:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x397u9lL041949;
        Tue, 9 Apr 2019 02:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554796569;
        bh=zAcf4fCcOgvmZlb5eO6ddeQrvo02mJchoj1ROcf5pK8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Q0vzZ83l6sCiUIAyhRHTppFJtnKYzxxHgaMzER0OumvSd5whuc+uE0nmo9oZY++Eb
         EktaRlys+LZzl/E2Bdo7DRehvsea5ncytNqZu7D5C8eabcgMI+Un9chv4a1WkYxnQm
         cADEwJKdGyWcwpnZAvtxl5hDI4CacTNNyvV9TJMI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x397u9iK079295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 02:56:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 02:56:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 02:56:09 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x397u5ad064157;
        Tue, 9 Apr 2019 02:56:06 -0500
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding documentation for TI
 syscon gate clock
To:     Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Menon, Nishanth" <nm@ti.com>, "Kristo, Tero" <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20190312090518.28666-1-vigneshr@ti.com>
 <20190312090518.28666-2-vigneshr@ti.com> <20190328123142.GA6229@bogus>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <33f6bc53-a361-c12b-1c21-3c34b101e67a@ti.com>
Date:   Tue, 9 Apr 2019 13:27:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328123142.GA6229@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 28/03/19 6:01 PM, Rob Herring wrote:
> On Tue, Mar 12, 2019 at 02:35:17PM +0530, Vignesh Raghavendra wrote:
>> Add dt bindings for TI syscon gate clock.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  .../bindings/clock/ti,syscon-gate-clock.txt   | 35 +++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
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
> 

These registers have bits that control other functionalities apart from
PWM clocks. Therefore, I modeled them as "syscon", "simple-bus";

Or is it recommended to use:
 compatible = "syscon", "simple-mfd";


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

Ok, I can change this to single clock node and use #clock-cells to pass
register offset of and bit index from each consumer:

       ctrlmmr_epwm_ctrl: syscon@104140{
               compatible = "syscon", "simple-mfd";
               reg = <0x0 0x104140 0x0 0x18>;
               ranges = <0x0 0x0 0x104140>;
               #address-cells = <1>;
               #size-cells = <0>;

               ehrpwm_tbclk: clk {
                       compatible = "ti,syscon-gate-clock";
                       #clock-cells = <2>;
               };
	};

And consumer node:

       ehrpwm1: pwm@3010000 {
               compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
               #pwm-cells = <3>;
               reg = <0x0 0x3000000 0x0 0x100>;
               power-domains = <&k3_pds 40>;
               clocks = <&ehrpwm_tbclk 4 0>; /* offset 4, bit 0 */
	       clock-names = "tbclk";
       };


Would that be acceptable?

Regards
Vignesh

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


