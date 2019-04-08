Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF1020870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BcRjTXlr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IudVEbGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDHIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:12:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfDHIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:12:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0A8860712; Mon,  8 Apr 2019 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554711173;
        bh=YCoN3hUCQe7iFitcu3VFc56fzMLSacy58cNhZ1Eucoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BcRjTXlrf7WJMKc0qOsWUNcBEkPY/FDj/Dbit7c99nBr/vf11pY9IyLzkMknPWqu8
         hTiwHPCtqyhWLwJ0rczLfQKajdjTMIa1vtn6/oTgUX7jdxSuhOuQynWoCOy0jpwdM3
         427/BaNZIPtolA4Qai5qOkF7qLs5uD6QVDGVICQw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0145061834;
        Mon,  8 Apr 2019 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554711170;
        bh=YCoN3hUCQe7iFitcu3VFc56fzMLSacy58cNhZ1Eucoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IudVEbGnDqNANxxxfp0mqKv2Vh2ASa3SeQXwtHHZLLSmzTR0KHBY1KSrVB0CAkdTB
         ExPS7Tf9fibIDJQ1U19AlozBmhhP7fINAkOaB0jOOZ9P8kqLVV/MvgGWGHpScjS1f2
         gFRzZTzWK2CjDCmqrAuACfw+VMHzd3XbkH+U547o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Apr 2019 13:42:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, rnayak@codeaurora.org
Cc:     david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: msm8998: Add rpmpd node
In-Reply-To: <20190327123832.11566-10-sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
 <20190327123832.11566-10-sibis@codeaurora.org>
Message-ID: <deadb7d1da072e4c351605c653181099@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-27 18:08, Sibi Sankar wrote:
> Add the rpmpd node on the msm8998 and define the available levels.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 51 +++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 3fd0769fe648..b7e3e0646b9b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8998.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/gpio/gpio.h>
> 
>  / {
> @@ -272,6 +273,56 @@
>  				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
>  				#clock-cells = <1>;
>  			};
> +
> +			rpmpd: power-controller {
> +				compatible = "qcom,msm8998-rpmpd";
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


typo in opp5 - opp10 rpmhpd/rpmpd
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
> +					rpmhpd_opp_turbo_plus: opp10 {
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
