Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB1C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3C21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfGLQoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:44:32 -0400
Received: from foss.arm.com ([217.140.110.172]:60020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfGLQoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:44:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47AF22B;
        Fri, 12 Jul 2019 09:44:29 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274553F246;
        Fri, 12 Jul 2019 09:44:27 -0700 (PDT)
Subject: Re: [PATCHv8 1/5] arm64: dts: qcom: sdm845: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, mike.leach@linaro.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, david.brown@linaro.org,
        mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        marc.w.gonzalez@free.fr
References: <cover.1562940244.git.saiprakash.ranjan@codeaurora.org>
 <52550ed9bbc10dca860eb1700aef5c97f644327b.1562940244.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <06c1a087-53f7-4841-1ae3-07ccbed22a72@arm.com>
Date:   Fri, 12 Jul 2019 17:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <52550ed9bbc10dca860eb1700aef5c97f644327b.1562940244.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

On 12/07/2019 15:16, Sai Prakash Ranjan wrote:
> Add coresight components found on Qualcomm SDM845 SoC.

> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 451 +++++++++++++++++++++++++++
>   1 file changed, 451 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 4babff5f19b5..5d7e3f8e0f91 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1815,6 +1815,457 @@
>   			clock-names = "xo";
>   		};
>   
> +		stm@6002000 {
> +			compatible = "arm,coresight-stm", "arm,primecell";
> +			reg = <0 0x06002000 0 0x1000>,
> +			      <0 0x16280000 0 0x180000>;
> +			reg-names = "stm-base", "stm-stimulus-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";


Which tree is this based on ? I can't see aoss_qmp anywhere under dts/qcom
on 5.2-rc7.


Cheers
Suzuki
