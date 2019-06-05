Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3BDC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52371206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfFEQXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:23:39 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:9546 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfFEQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:23:39 -0400
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x55GNbaa010152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jun 2019 10:23:37 -0600 (CST)
Received: from eng1n65.eng.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x55GNaIP002675
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 5 Jun 2019 10:23:37 -0600
Subject: Re: [PATCH 1/2] mfd: core: Support multiple OF child devices of the
 same type
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
 <20190605063108.GF4797@dell>
From:   Robert Hancock <hancock@sedsystems.ca>
Openpgp: preference=signencrypt
Autocrypt: addr=hancock@sedsystems.ca; prefer-encrypt=mutual; keydata=
 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
Organization: SED Systems
Message-ID: <7561b2af-52b4-af78-f854-00ba0b86c822@sedsystems.ca>
Date:   Wed, 5 Jun 2019 10:23:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605063108.GF4797@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-05 12:31 a.m., Lee Jones wrote:
> On Tue, 04 Jun 2019, Robert Hancock wrote:
> 
>> Previously the MFD core supported assigning OF nodes to created MFD
>> devices, but relied solely on matching the of_compatible string. This
>> would result in devices being potentially assigned the wrong node if
>> there are multiple devices with the same compatible string within a
>> multifunction device.
>>
>> Add support for matching the full name of the node in the MFD cell
>> definition, so that we can match against a specific instance of a
>> device. If this is not specified, we match just based on the
>> compatible string, as before.
>>
>> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
>> ---
>>  drivers/mfd/mfd-core.c   | 5 ++++-
>>  include/linux/mfd/core.h | 3 +++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>> index 1ade4c8..74bc895 100644
>> --- a/drivers/mfd/mfd-core.c
>> +++ b/drivers/mfd/mfd-core.c
>> @@ -177,7 +177,10 @@ static int mfd_add_device(struct device *parent, int id,
>>  
>>  	if (parent->of_node && cell->of_compatible) {
>>  		for_each_child_of_node(parent->of_node, np) {
>> -			if (of_device_is_compatible(np, cell->of_compatible)) {
>> +			if (of_device_is_compatible(np, cell->of_compatible) &&
>> +			    (!cell->of_full_name ||
>> +			     !strcmp(cell->of_full_name,
>> +				     of_node_full_name(np)))) {
>>  				pdev->dev.of_node = np;
>>  				break;
> 
> That is some ugly, squashed up code.
> 
> If we end up accepting this, I suggest flattening this out a bit.
> 
> ... but we'll cross that bridge when we come to it.

Yes, that if statement could be broken up to make it more readable. Will
fix in a next version assuming the concept is acceptable.

> 
>> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
>> index 99c0395..470f6cb 100644
>> --- a/include/linux/mfd/core.h
>> +++ b/include/linux/mfd/core.h
>> @@ -55,6 +55,9 @@ struct mfd_cell {
>>  	 */
>>  	const char		*of_compatible;
>>  
>> +	/* Optionally match against a specific device of a given type */
>> +	const char		*of_full_name;
>> +
> 
> Can you give me an example for when this might be useful?

This is an example of some device tree entries for our MFD device:

            axi_iic_0: i2c@c0000 {
                compatible = "xlnx,xps-iic-2.00.a";
                clocks = <&axi_clk>;
                clock-frequency = <100000>;
                interrupts = <7>;
                #size-cells = <0>;
                #address-cells = <1>;
            };

            axi_iic_1: i2c@d0000 {
                compatible = "xlnx,xps-iic-2.00.a";
                clocks = <&axi_clk>;
                clock-frequency = <100000>;
                interrupts = <8>;
                #size-cells = <0>;
                #address-cells = <1>;
            };

and the corresponding MFD cells:

{
	.name		= "axi_iic_0",
	.of_compatible	= "xlnx,xps-iic-2.00.a",
	.of_full_name	= "i2c@c0000",
	.num_resources	= ARRAY_SIZE(dbe_i2c1_resources),
	.resources	= dbe_i2c1_resources
},
{
	.name		= "axi_iic_1",
	.of_compatible	= "xlnx,xps-iic-2.00.a",
	.of_full_name	= "i2c@d0000",
	.num_resources	= ARRAY_SIZE(dbe_i2c2_resources),
	.resources	= dbe_i2c2_resources
},

Without having the .of_full_name support, both MFD cells ended up
wrongly matching against the i2c@c0000 device tree node since we just
picked the first one where of_compatible matched.

-- 
Robert Hancock
Senior Software Developer
SED Systems, a division of Calian Ltd.
Email: hancock@sedsystems.ca
