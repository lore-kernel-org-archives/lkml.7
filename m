Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D42C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CD20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="w8EXAoZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgABHyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:54:15 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:45400 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbgABHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:54:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577951654; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yJYJDd1Z2YXAv6jesy41e54rJyXI82cXXASQ0/OaVFU=;
 b=w8EXAoZmP0u5NS5uqE6rkkHcIxVt/pzDIK10sdFl1xJwHCUpHZgJrsZv5B/a3lgokDcac4/m
 PFYXlZzGkzw4Leou7zI5MZ1JnRzh7B+J3QYY9WlZuZ0zYRLowDAAFAI/rh+gTFpIDhPaBIlM
 DVrSOWcjr8TMpLPa+g5b3aP+khs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0da1a2.7fb722093458-smtp-out-n02;
 Thu, 02 Jan 2020 07:54:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A0A10C4479C; Thu,  2 Jan 2020 07:54:09 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 062CEC433CB;
        Thu,  2 Jan 2020 07:54:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jan 2020 13:24:08 +0530
From:   vgarodia@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: sc7180: Add Venus video codec DT node
In-Reply-To: <20191229031853.GL3755841@builder>
References: <1576828760-13176-1-git-send-email-dikshita@codeaurora.org>
 <1576828760-13176-2-git-send-email-dikshita@codeaurora.org>
 <20191229031853.GL3755841@builder>
Message-ID: <17bc9ed78316f483fea273849d39d6a8@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for your review comments.

On 2019-12-29 08:48, Bjorn Andersson wrote:
> On Thu 19 Dec 23:59 PST 2019, Dikshita Agarwal wrote:
> 
>> This adds Venus video codec DT node for sc7180.
>> 
>> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 36 
>> ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 6876aae2..42c70f5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/clock/qcom,videocc-sc7180.h>
>> 
>>  / {
>>  	interrupt-parent = <&intc>;
>> @@ -66,6 +67,11 @@
>>  			compatible = "qcom,cmd-db";
>>  			no-map;
>>  		};
>> +
>> +		venus_mem: memory@8F600000 {
>> +			reg = <0 0x8F600000 0 0x500000>;
>> +			no-map;
>> +		};
>>  	};
>> 
>>  	cpus {
>> @@ -1042,6 +1048,36 @@
>>  			};
>>  		};
>> 
>> +		venus: video-codec@aa00000 {
>> +			compatible = "qcom,sc7180-venus";
>> +			reg = <0 0x0aa00000 0 0xff000>;
>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +			power-domains = <&videocc VENUS_GDSC>,
> 
> Should this be aligned with the DT refactoring done for sdm845, where
> the GDSC is moved into the *-core subnodes etc?
This is already aligned to new refactored design i.e clocks/GDSCs are no 
more
core specific.

> Regards,
> Bjorn
> 
>> +					<&videocc VCODEC0_GDSC>;
>> +			power-domain-names = "venus", "vcodec0";
>> +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
>> +				<&videocc VIDEO_CC_VENUS_AHB_CLK>,
>> +				<&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
>> +				<&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
>> +				<&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
>> +			clock-names = "core", "iface", "bus",
>> +					"vcodec0_core", "vcodec0_bus";
>> +			iommus = <&apps_smmu 0x0C00 0x60>;
>> +			memory-region = <&venus_mem>;
>> +
>> +			video-core0 {
>> +					compatible = "venus-decoder";
>> +			};
>> +
>> +			video-core1 {
>> +					compatible = "venus-encoder";
>> +			};
>> +
>> +			video-firmware {
>> +					iommus = <&apps_smmu 0x0C42 0x0>;
>> +			};
>> +		};
>> +
>>  		pdc: interrupt-controller@b220000 {
>>  			compatible = "qcom,sc7180-pdc", "qcom,pdc";
>>  			reg = <0 0x0b220000 0 0x30000>;
>> --
>> 1.9.1
>> 
