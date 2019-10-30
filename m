Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89EF2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gpD50T+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfJ3Fg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 01:36:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3Fg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:36:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9U5ausW041383;
        Wed, 30 Oct 2019 00:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572413816;
        bh=X2vi5WNzjqtQ+5Yhrq1ahZ33fjgtT830Vh7ZwHVgWD0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gpD50T+Gw/zzcrraMqdw+PLguiEFIYQqcwD5mwm6cdTLLJ/t4GJLK9GSm9d0s0ZkG
         ir9kbAdiodVQtEn08Vtz4xmXq+3WkBsBND7uJD4kXgh7vOBRLXr4tOb5OKtKOvylSb
         JA7WKQ3lkgOzzJ92r7He3ENMTLsv/TBNynu0bCFY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9U5atIL021238;
        Wed, 30 Oct 2019 00:36:56 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 00:36:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 00:36:43 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9U5apn6097376;
        Wed, 30 Oct 2019 00:36:53 -0500
Subject: Re: [PATCH v2 01/14] dt-bindings: phy: Sierra: Add bindings for
 Sierra in TI's J721E
To:     Rob Herring <robh@kernel.org>, Anil Varughese <aniljoy@cadence.com>
CC:     Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20191023125735.4713-1-kishon@ti.com>
 <20191023125735.4713-2-kishon@ti.com> <20191029185916.GA19313@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8ec5a9bd-4283-04bf-af4c-c5b7b912a342@ti.com>
Date:   Wed, 30 Oct 2019 11:06:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029185916.GA19313@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 30/10/19 12:29 AM, Rob Herring wrote:
> On Wed, Oct 23, 2019 at 06:27:22PM +0530, Kishon Vijay Abraham I wrote:
>> Add DT binding documentation for Sierra PHY IP used in TI's J721E
>> SoC.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../devicetree/bindings/phy/phy-cadence-sierra.txt  | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>> index 6e1b47bfce43..bf90ef7e005e 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>> @@ -2,21 +2,24 @@ Cadence Sierra PHY
>>  -----------------------
>>  
>>  Required properties:
>> -- compatible:	cdns,sierra-phy-t0
>> -- clocks:	Must contain an entry in clock-names.
>> -		See ../clocks/clock-bindings.txt for details.
>> -- clock-names:	Must be "phy_clk"
>> +- compatible:	Must be "cdns,sierra-phy-t0" for Sierra in Cadence platform
>> +		Must be "ti,sierra-phy-t0" for Sierra in TI's J721E SoC.
>>  - resets:	Must contain an entry for each in reset-names.
>>  		See ../reset/reset.txt for details.
>>  - reset-names:	Must include "sierra_reset" and "sierra_apb".
>>  		"sierra_reset" must control the reset line to the PHY.
>>  		"sierra_apb" must control the reset line to the APB PHY
>> -		interface.
>> +		interface ("sierra_apb" is optional).
>>  - reg:		register range for the PHY.
>>  - #address-cells: Must be 1
>>  - #size-cells:	Must be 0
>>  
>>  Optional properties:
>> +- clocks:		Must contain an entry in clock-names.
>> +			See ../clocks/clock-bindings.txt for details.
>> +- clock-names:		Must be "phy_clk". Must contain "cmn_refclk" and
>> +			"cmn_refclk1" for configuring the frequency of the
>> +			clock to the lanes.
> 
> I don't understand how the same block can have completely different 
> clocks. Did the original binding forget some? 
> 
> TI needs 0, 1 or 3 clocks? Reads like it could be any.

For TI, phy_clk is not needed. Anil, can you clarify what this clock actually
corresponds to? Is it a functional clock of PHY?

Sierra SERDES actually has a number of clocks which can be configured. The
initial dt-binding didn't model all these clocks. The "cmn_refclk" and
"cmn_refclk1" are used to program the dividers withing the Sierra. The actual
registers for programming the dividers are in the Sierra wrapper though. The
original Sierra driver and dt-binding didn't try to change the default divider
values.

Thanks
Kishon
> 
> Rob
> 
