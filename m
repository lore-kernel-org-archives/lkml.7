Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D571C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DF3206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 21:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560373937;
	bh=7CIGt69fnY+Oo0VNwYzt3Fg4wy5520t2tFyR/kiTyj4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GVkUdnSuC3Tcoz+Xf6XuZ4dLep/SqTDM75SEt4165Ev6nnc5zS6FeD4QjcL+LnlYU
	 Bb/iO8+e3w+VKgJt4VbQh0xXo25v2fllugDAqSSN7TvkAFV+L0UbtmN7L1qbqJRd9/
	 uXhXz1l7/BLD0kmK4vSKXIgw2B8l7uopk2QDviAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfFLVMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 17:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfFLVMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:12:14 -0400
Received: from [192.168.1.32] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D71206BB;
        Wed, 12 Jun 2019 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560373933;
        bh=7CIGt69fnY+Oo0VNwYzt3Fg4wy5520t2tFyR/kiTyj4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fxWCuUypWFT3jnslFsGTruAdXtPrPlBpkHwUJXRQsm2RZAiefki7r77ZP/MfEbFMc
         NBKUztOFxJLL8VLowEz6W8LWGU++/HNbU2F8vDYBGZrrqIoR+DevkPlxnGcuJ2IYsF
         t5i5HIAMozQ2TgDP75QSrfXMyWqsfngPVTWvpX9Q=
Subject: Re: [PATCHv5 2/2] mtd: spi-nor: cadence-quadspi: add reset control
To:     Tudor.Ambarus@microchip.com, linux-mtd@lists.infradead.org
Cc:     marex@denx.de, dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        tien.fong.chee@intel.com
References: <20190612143744.30718-1-dinguyen@kernel.org>
 <20190612143744.30718-2-dinguyen@kernel.org>
 <2ee32a0d-7523-0b23-072e-e68af4977db7@microchip.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 mQINBFEnvWwBEAC44OQqJjuetSRuOpBMIk3HojL8dY1krl8T8GJjfgc/Gh97CfVbrqhV5yQ3
 Sk/MW9mxO9KNvQCbZtthfn62YHmroNwipjZ6wKOMfKdtJR4+8JW/ShIJYnrMfwN8Wki6O+5a
 yPNNCeENHleV0FLVXw3aACxOcjEzGJHYmg4UC+56rfoxPEhKF6aGBTV5aGKMtQy77ywuqt12
 c+hlRXHODmXdIeT2V4/u/AsFNAq6UFUEvHrVj+dMIyv2VhjRvkcESIGnG12ifPdU7v/+wom/
 smtfOAGojgTCqpwd0Ay2xFzgGnSCIFRHp0I/OJqhUcwAYEAdgHSBVwiyTQx2jP+eDu3Q0jI3
 K/x5qrhZ7lj8MmJPJWQOSYC4fYSse2oVO+2msoMTvMi3+Jy8k+QNH8LhB6agq7wTgF2jodwO
 yij5BRRIKttp4U62yUgfwbQtEUvatkaBQlG3qSerOzcdjSb4nhRPxasRqNbgkBfs7kqH02qU
 LOAXJf+y9Y1o6Nk9YCqb5EprDcKCqg2c8hUya8BYqo7y+0NkBU30mpzhaJXncbCMz3CQZYgV
 1TR0qEzMv/QtoVuuPtWH9RCC83J5IYw1uFUG4RaoL7Z03fJhxGiXx3/r5Kr/hC9eMl2he6vH
 8rrEpGGDm/mwZOEoG5D758WQHLGH4dTAATg0+ZzFHWBbSnNaSQARAQABtCFEaW5oIE5ndXll
 biA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz6JAjgEEwECACIFAlbG5oQCGwMGCwkIBwMCBhUIAgkK
 CwQWAgMBAh4BAheAAAoJEBmUBAuBoyj0fIgQAICrZ2ceRWpkZv1UPM/6hBkWwOo3YkzSQwL+
 AH15hf9xx0D5mvzEtZ97ZoD0sAuB+aVIFwolet+nw49Q8HA3E/3j0DT7sIAqJpcPx3za+kKT
 twuQ4NkQTTi4q5WCpA5b6e2qzIynB50b3FA6bCjJinN06PxhdOixJGv1qDDmJ01fq2lA7/PL
 cny/1PIo6PVMWo9nf77L6iXVy8sK/d30pa1pjhMivfenIleIPYhWN1ZdRAkH39ReDxdqjQXN
 NHanNtsnoCPFsqeCLmuUwcG+XSTo/gEM6l2sdoMF4qSkD4DdrVf5rsOyN4KJAY9Uqytn4781
 n6l1NAQSRr0LPT5r6xdQ3YXIbwUfrBWh2nDPm0tihuHoH0CfyJMrFupSmjrKXF84F3cq0DzC
 yasTWUKyW/YURbWeGMpQH3ioDLvBn0H3AlVoSloaRzPudQ6mP4O8mY0DZQASGf6leM82V3t0
 Gw8MxY9tIiowY7Yl2bHqXCorPlcEYXjzBP32UOxIK7y7AQ1JQkcv6pZ0/6lX6hMshzi9Ydw0
 m8USfFRZb48gsp039gODbSMCQ2NfxBEyUPw1O9nertCMbIO/0bHKkP9aiHwg3BPwm3YL1UvM
 ngbze/8cyjg9pW3Eu1QAzMQHYkT1iiEjJ8fTssqDLjgJyp/I3YHYUuAf3i8SlcZTusIwSqnD
 uQINBFEnvWwBEADZqma4LI+vMqJYe15fxnX8ANw+ZuDeYHy17VXqQ7dA7n8E827ndnoXoBKB
 0n7smz1C0I9StarHQPYTUciMLsaUpedEfpYgqLa7eRLFPvk/cVXxmY8Pk+aO8zHafr8yrFB1
 cYHO3Ld8d/DvF2DuC3iqzmgXzaRQhvQZvJ513nveCa2zTPPCj5w4f/Qkq8OgCz9fOrf/CseM
 xcP3Jssyf8qTZ4CTt1L6McRZPA/oFNTTgS/KA22PMMP9i8E6dF0Nsj0MN0R7261161PqfA9h
 5c+BBzKZ6IHvmfwY+Fb0AgbqegOV8H/wQYCltPJHeA5y1kc/rqplw5I5d8Q6B29p0xxXSfaP
 UQ/qmXUkNQPNhsMnlL3wRoCol60IADiEyDJHVZRIl6U2K54LyYE1vkf14JM670FsUH608Hmk
 30FG8bxax9i+8Muda9ok/KR4Z/QPQukmHIN9jVP1r1C/aAEvjQ2PK9aqrlXCKKenQzZ8qbeC
 rOTXSuJgWmWnPWzDrMxyEyy+e84bm+3/uPhZjjrNiaTzHHSRnF2ffJigu9fDKAwSof6SwbeH
 eZcIM4a9Dy+Ue0REaAqFacktlfELeu1LVzMRvpIfPua8izTUmACTgz2kltTaeSxAXZwIziwY
 prPU3cfnAjqxFHO2TwEpaQOMf8SH9BSAaCXArjfurOF+Pi3lKwARAQABiQIfBBgBAgAJBQJR
 J71sAhsMAAoJEBmUBAuBoyj0MnIQAI+bcNsfTNltf5AbMJptDgzISZJrYCXuzOgv4+d1CubD
 83s0k6VJgsiCIEpvELQJsr58xB6l+o3yTBZRo/LViNLk0jF4CmCdXWjTyaQAIceEdlaeeTGH
 d5GqAud9rv9q1ERHTcvmoEX6pwv3m66ANK/dHdBV97vXacl+BjQ71aRiAiAFySbJXnqj+hZQ
 K8TCI/6TOtWJ9aicgiKpmh/sGmdeJCwZ90nxISvkxDXLEmJ1prvbGc74FGNVNTW4mmuNqj/p
 oNr0iHan8hjPNXwoyLNCtj3I5tBmiHZcOiHDUufHDyKQcsKsKI8kqW3pJlDSACeNpKkrjrib
 3KLQHSEhTQCt3ZUDf5xNPnFHOnBjQuGkumlmhkgD5RVguki39AP2BQYp/mdk1NCRQxz5PR1B
 2w0QaTgPY24chY9PICcMw+VeEgHZJAhuARKglxiYj9szirPd2kv4CFu2w6a5HNMdVT+i5Hov
 cJEJNezizexE0dVclt9OS2U9Xwb3VOjs1ITMEYUf8T1j83iiCCFuXqH4U3Eji0nDEiEN5Ac0
 Jn/EGOBG2qGyKZ4uOec9j5ABF7J6hyO7H6LJaX5bLtp0Z7wUbyVaR4UIGdIOchNgNQk4stfm
 JiyuXyoFl/1ihREfvUG/e7+VAAoOBnMjitE5/qUERDoEkkuQkMcAHyEyd+XZMyXY
Message-ID: <7a31d825-53a0-5b1f-af88-daff2b529587@kernel.org>
Date:   Wed, 12 Jun 2019 16:12:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2ee32a0d-7523-0b23-072e-e68af4977db7@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/19 10:07 AM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 06/12/2019 05:37 PM, Dinh Nguyen wrote:
>> External E-Mail
>>
>>
>> Get the reset control properties for the QSPI controller and bring them
>> out of reset. Most will have just one reset bit, but there is an additional
>> OCP reset bit that is used ECC. The OCP reset bit will also need to get
>> de-asserted as well. [1]
>>
>> The reason this patch is needed is in the case where a bootloader leaves
>> the QSPI controller in a reset state, or a state where init cannot occur
>> successfully, this patch will put the QSPI controller into a clean state.
>>
>> [1] https://www.intel.com/content/www/us/en/programmable/hps/arria-10/hps.html#reg_soc_top/sfo1429890575955.html
>>
>> Suggested-by: Tien-Fong Chee <tien.fong.chee@intel.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v5: remove udelay(not needed) on tested hardware
>>     group reset assert/deassert together
>>     update commit message with reasoning for patch
>> v4: fix compile error
>> v3: return full error by using PTR_ERR(rtsc)
>>     move reset control calls until after the clock enables
>>     use udelay(2) to be safe
>>     Add optional OCP(Open Core Protocol) reset signal
>> v2: use devm_reset_control_get_optional_exclusive
>>     print an error message
>>     return -EPROBE_DEFER
>> ---
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 792628750eec..f8b1009e488c 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/of.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>>  #include <linux/sched.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/timer.h>
>> @@ -1336,6 +1337,8 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	struct cqspi_st *cqspi;
>>  	struct resource *res;
>>  	struct resource *res_ahb;
>> +	struct reset_control *rstc;
>> +	struct reset_control *rstc_ocp;
>>  	const struct cqspi_driver_platdata *ddata;
>>  	int ret;
>>  	int irq;
>> @@ -1402,6 +1405,29 @@ static int cqspi_probe(struct platform_device *pdev)
>>  		goto probe_clk_failed;
>>  	}
>>  
>> +	/* Obtain QSPI reset control */
>> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>> +	if (IS_ERR(rstc)) {
>> +		dev_err(dev, "Cannot get QSPI reset.\n");
>> +		return PTR_ERR(rstc);
>> +	}
>> +
>> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>> +	if (IS_ERR(rstc_ocp)) {
>> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
>> +		return PTR_ERR(rstc_ocp);
>> +	}
>> +
>> +	if (rstc) {
> 
> Hi, Dinh,
> 
> reset_control_assert/deassert() already have checks for null, you can call them
> directly without checking for null.
> 
>> +		reset_control_assert(rstc);
>> +		reset_control_deassert(rstc);
> 
> Is there any difference between:
> reset_control_assert(rstc);
> reset_control_assert(rstc_ocp);
> 
> reset_control_deassert(rstc);
> reset_control_deassert(rstc_ocp);
> 
> and:
> 
> reset_control_assert(rstc);
> reset_control_deassert(rstc);
> 
> reset_control_assert(rstc_ocp);
> reset_control_deassert(rstc_ocp);
> 
> Which one would you choose?
> 

I prefer grouping the assert/deassert for each reset pointer together.

Dinh
