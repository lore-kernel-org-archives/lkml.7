Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98323C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ozBjAJEi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ER0em7f4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDHIK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:10:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:10:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E577A61110; Mon,  8 Apr 2019 08:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554711054;
        bh=B24mPUafIFdtauVdiqO2enUJ5L0Zb4appgFJkVFD068=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ozBjAJEipqwfICme8UViDxTu0kW/b0FN8T8MY17wMEIdWaYrBu3T/mnIQN056+C94
         fZoRuss8G/z9B7tOPYAP/iT3CnQehK/gqIinlL51LNwYk2twQ4YdCsNqsClVEqhR3T
         Jbj6B3KDdEsQKD5SFe2BxZMVN1hrGRrmrtS8sCH0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4C5286022B;
        Mon,  8 Apr 2019 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554711051;
        bh=B24mPUafIFdtauVdiqO2enUJ5L0Zb4appgFJkVFD068=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ER0em7f4jXYH/BF3xw6fhpDnwHS4TutXmh0S4lw58uY+l2dWLEAtRW7/Yz9pPdBSj
         THn1PWg0nIWOfC+UST+TLERWvGaoOW58LYCimwCgezSxieadRrONTZdqIPhos3DMJ6
         jj8eb2K8mL/SBu3mgDTnQ3o6ViS/yTRQTSr3gXW4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Apr 2019 13:40:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/9] arm64: dts: qcom: qcs404: Add rpmpd node
In-Reply-To: <20190327123832.11566-7-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-7-sibis@codeaurora.org>
Message-ID: <3686ccecbbf8c13ad6b2aa12167f8510@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-27 18:08, Sibi Sankar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add the rpmpd node on the qcs404 and define the available levels.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> [sibis: fixup available levels]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index e8fd26633d57..a7d46647c416 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> 
>  / {
>  	interrupt-parent = <&intc>;
> @@ -230,6 +231,60 @@
>  				compatible = "qcom,rpmcc-qcs404";
>  				#clock-cells = <1>;
>  			};
> +
> +			rpmpd: power-controller {
> +				compatible = "qcom,qcs404-rpmpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmpd_opp_table>;
> +
> +				rpmpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmpd_opp_ret: opp1 {
> +						opp-level = <RPM_SMD_LEVEL_RETENTION>;
> +					};
> +
> +					rpmpd_opp_ret_plus: opp2 {
> +						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> +					};
> +
> +					rpmpd_opp_min_svs: opp3 {
> +						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmpd_opp_low_svs: opp4 {
> +						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +					};
> +

typo in opp5 - opp11 rpmhpd/rpmpd
will fix it in the next re-spin

> +					rpmhpd_opp_svs: opp5 {
> +						opp-level = <RPM_SMD_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_plus: opp6 {
> +						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +					};
> +
> +					rpmhpd_opp_nom: opp7 {
> +						opp-level = <RPM_SMD_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_plus: opp8 {
> +						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp9 {
> +						opp-level = <RPM_SMD_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_no_cpr: opp10 {
> +						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +					};
> +
> +					rpmhpd_opp_turbo_plus: opp11 {
> +						opp-level = <RPM_SMD_LEVEL_BINNING>;
> +					};
> +				};
> +			};
>  		};
>  	};

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
