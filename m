Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B34C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9A12173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TOI1cq+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfC2GOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:14:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56660 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2GOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:14:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2T6ECHG072330;
        Fri, 29 Mar 2019 01:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553840052;
        bh=g0XJJIFjRO85+4SIEq9+FipTir1l09SxKLBwaJ4l4wA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TOI1cq+0dyjYuVY1VzPh5ltgnGNUQelDaTI3V9xAFKEgftBrecLjLtqEf9nniLSxJ
         PzuVHBVvHZ0P8qny2UWWWS71hMOqr3FRbu5r50ugl18Wg0atFyWoG6mNT/+ZgE3vbV
         iQwnjzytdD5a4uoweK8OuIOBHIFIYnx2yiyo+2Q4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2T6ECUu032908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 01:14:12 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 01:14:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 01:14:12 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2T6E8c0082067;
        Fri, 29 Mar 2019 01:14:09 -0500
Subject: Re: [PATCH v3 3/5] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
To:     Rob Herring <robh@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190325080815.6056-1-kishon@ti.com>
 <20190325080815.6056-4-kishon@ti.com> <20190328180759.GA32679@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <18677fbe-8d84-92eb-3252-ec401e91fb7e@ti.com>
Date:   Fri, 29 Mar 2019 11:43:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328180759.GA32679@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 28/03/19 11:37 PM, Rob Herring wrote:
> On Mon, Mar 25, 2019 at 01:38:13PM +0530, Kishon Vijay Abraham I wrote:
>> AM654x has two SERDES instances. Each instance has three input clocks
>> (left input, externel reference clock and right input) and two output
>> clocks (left output and right output) in addition to a PLL mux clock
>> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
>> The PLL mux clock can select from one of the three input clocks.
>> The right output can select between left input and external reference
>> clock while the left output can select between the right input and
>> external reference clock.
>>
>> The left and right input reference clock of SERDES0 and SERDES1
>> respectively are connected to the SoC clock. In the case of two lane
>> SERDES personality card, the left input of SERDES1 is connected to
>> the right output of SERDES0 in a chained fashion.
>>
>> See section "Reference Clock Distribution" of AM65x Sitara Processors
>> TRM (SPRUID7 – April 2018) for more details.
>>
>> Add dt-binding documentation in order to represent all these different
>> configurations in device tree.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../bindings/phy/ti,phy-am654-serdes.txt      | 81 +++++++++++++++++++
>>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 +++
>>  2 files changed, 94 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
>>
>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>> new file mode 100644
>> index 000000000000..25a9206147ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
>> @@ -0,0 +1,81 @@
>> +TI AM654 SERDES
>> +
>> +Required properties:
>> + - compatible: Should be "ti,phy-am654-serdes"
>> + - reg : Address and length of the register set for the device.
>> + - reg-names: Should be "serdes" which corresponds to the register space
>> +	populated in "reg".
> 
> *-names is kind of pointless with only 1 entry.

okay. I'll drop this.
> 
>> + - #phy-cells: determine the number of cells that should be given in the
>> +	phandle while referencing this phy. Should be "2". The 1st cell
>> +	corresponds to the phy type (should be one of the types specified in
>> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
>> +	lane function.
>> +	If SERDES0 is referenced 2nd cell should be:
>> +		0 - USB3
>> +		1 - PCIe0 Lane0
>> +		2 - ICSS2 SGMII Lane0
>> +	If SERDES1 is referenced 2nd cell should be:
>> +		0 - PCIe1 Lane0
>> +		1 - PCIe0 Lane1
>> +		2 - ICSS2 SGMII Lane1
>> + - clocks: List of clock-specifiers representing the input to the SERDES.
>> +	Should have 3 items representing the left input clock, external
>> +	reference clock and right input clock in that order.
>> + - clock-output-names: List of clock names for each of the clock outputs of
>> +	SERDES. Should have 3 items for CMU reference clock,
>> +	left output clock and right output clock in that order.
>> + - assigned-clocks: As defined in
>> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
>> + - assigned-clock-parents: As defined in
>> +	Documentation/devicetree/bindings/clock/clock-bindings.txt
>> + - #clock-cells: Should be <1> to choose between the 3 output clocks.
>> +	Defined in Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +   The following macros are defined in dt-bindings/phy/phy-am654-serdes.h
>> +   for selecting the correct reference clock. This can be used while
>> +   specifying the clocks created by SERDES.
>> +	=> AM654_SERDES_CMU_REFCLK
>> +	=> AM654_SERDES_LO_REFCLK
>> +	=> AM654_SERDES_RO_REFCLK
>> +
>> + - mux-controls: phandle to the multiplexer
> 
> What does this mux?

The serdes is muxed between USB, PCIe and SGMII. The mux-controls will help to
select the SERDES function based on the board configuration.
> 
>> +
>> +Example:
>> +
>> +Example for SERDES0 is given below. It has 3 clock inputs;
>> +left input reference clock as indicated by <&k3_clks 153 4>, external
>> +reference clock as indicated by <&k3_clks 153 1> and right input
>> +reference clock as indicated by <&serdes1 AM654_SERDES_LO_REFCLK>. (The
>> +right input of SERDES0 is connected to the left output of SERDES1).
>> +
>> +SERDES0 registers 3 clock outputs as indicated in clock-output-names. The
>> +first refers to the CMU reference clock, second refers to the left output
>> +reference clock and the third refers to the right output reference clock.
>> +
>> +The assigned-clocks and assigned-clock-parents is used here to set the
>> +parent of left input reference clock to MAINHSDIV_CLKOUT4 and parent of
>> +CMU reference clock to left input reference clock.
>> +
>> +serdes0: serdes@900000 {
>> +	compatible = "ti,phy-am654-serdes";
>> +	reg = <0x0 0x900000 0x0 0x2000>;
>> +	reg-names = "serdes";
> 
>> +	#phy-cells = <2>;
>> +	power-domains = <&k3_pds 153>;
> 
> Not documented.

Okay. I'll add.

Thanks
Kishon
