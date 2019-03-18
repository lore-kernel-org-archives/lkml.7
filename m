Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2369C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C2220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nKCNTLQe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nKCNTLQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCRPiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:38:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:38:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DF3B56072E; Mon, 18 Mar 2019 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552923479;
        bh=JOhiXPsBLFjOV0DadUldjU8SQEB8yIK8fUoYGb477j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKCNTLQeLeXvCmdxlfiPX7XedtPlKYCoMfyrX3XImz4hL6KfwsY6F1TBxCdMtWFqO
         /2kOCHtlo990zLvGAKy0GeYSGKC9jRL82C1VbNXya9Cmv1Q8qbFuBW+bYrSa7WArH4
         2eKKn68czRw7+GZRZXzFEHesrqr6H518gxfhnYJ8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA20D60312;
        Mon, 18 Mar 2019 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552923479;
        bh=JOhiXPsBLFjOV0DadUldjU8SQEB8yIK8fUoYGb477j0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKCNTLQeLeXvCmdxlfiPX7XedtPlKYCoMfyrX3XImz4hL6KfwsY6F1TBxCdMtWFqO
         /2kOCHtlo990zLvGAKy0GeYSGKC9jRL82C1VbNXya9Cmv1Q8qbFuBW+bYrSa7WArH4
         2eKKn68czRw7+GZRZXzFEHesrqr6H518gxfhnYJ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA20D60312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 18 Mar 2019 09:37:58 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 06/10] dt-bindings: sdm845-pinctrl: add wakeup
 interrupt parent for GPIO
Message-ID: <20190318153758.GB30156@codeaurora.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-7-ilina@codeaurora.org>
 <20190315233748.GA7219@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190315233748.GA7219@bogus>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Rob.

On Fri, Mar 15 2019 at 17:37 -0600, Rob Herring wrote:
>On Wed, Mar 13, 2019 at 03:18:40PM -0600, Lina Iyer wrote:
>> SDM845 SoC has an always-on interrupt controller (PDC) with select GPIO
>> routed to the PDC as interrupts that can be used to wake the system up
>> from deep low power modes and suspend.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt    | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>
>I still don't love this being specific to wake-up, but don't have a
>better suggestion. One nit, otherwise:
>
I added this to interrupts.txt. I will remove this, if the documentation in
[PATCH v4 03/10] of/irq: document properties for wakeup interrupt parent
of this series works.

-- Lina

>Reviewed-by: Rob Herring <robh@kernel.org>
>
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> index 665aadb5ea28..f0fedbc5d41a 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.txt
>> @@ -29,6 +29,11 @@ SDM845 platform.
>>  	Definition: must be 2. Specifying the pin number and flags, as defined
>>  		    in <dt-bindings/interrupt-controller/irq.h>
>>
>> +- wakeup-parent:
>> +	Usage: optional
>> +	Value type: <phandle>
>> +	Definition: A phandle to the wakeup interrupt controller for the SoC.
>> +
>>  - gpio-controller:
>>  	Usage: required
>>  	Value type: <none>
>> @@ -53,7 +58,6 @@ pin, a group, or a list of pins or groups. This configuration can include the
>>  mux function to select on those pin(s)/group(s), and various pin configuration
>>  parameters, such as pull-up, drive strength, etc.
>>
>> -
>>  PIN CONFIGURATION NODES:
>>
>>  The name of each subnode is not important; all subnodes should be enumerated
>> @@ -160,6 +164,7 @@ Example:
>>  		#gpio-cells = <2>;
>>  		interrupt-controller;
>>  		#interrupt-cells = <2>;
>> +		wake-parent = <&pdc_intc>;
>
>wakeup-parent
>
>>
>>  		qup9_active: qup9-active {
>>  			mux {
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
