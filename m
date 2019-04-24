Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2102218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XKhfB2V7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ddfuNfgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfDXIom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:44:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51060 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDXIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:44:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 213FC6072E; Wed, 24 Apr 2019 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556095480;
        bh=I7KdZC9Q0rDi4dpEcNAcqQg1ZH7lBDqgdOtIZITXw0w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XKhfB2V7nMdJSoF8SLfiJRRvshv3dK+jwUKYRh8WgKioM9ZHVpzMhYmvvGbK3RkZV
         zNuRYWEMgSMa0Oef4be1TIkWxyQOyK/pQmxFnfk3TyHs+Z9Qj/oOQ5PKoIqZsUuFrM
         HBLFXZvjt0WFpaa5GGbqpbOUhT5MhhK6lenga+Rs=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC1E26072E;
        Wed, 24 Apr 2019 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556095478;
        bh=I7KdZC9Q0rDi4dpEcNAcqQg1ZH7lBDqgdOtIZITXw0w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ddfuNfgULLPmnN1HZrDxJpuhab/8dowNU0/A6twFxpVAt4m0otPN4pPfxt/hDg5gW
         B701KK94j/5ob6OHKBRpayuvhW+l930Ylx/BtAHcg1VFcABeUQO09x2/SOZzu2oYD/
         yTPgfhLz7sjy+vDgUZuD0bU72BzU6bt+Ku4Km4KY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC1E26072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
To:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <662bcd9c-abed-23d1-865b-220adfd95ab7@codeaurora.org>
Date:   Wed, 24 Apr 2019 14:14:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190423132823.7915-2-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Georgi,

On 4/23/19 6:58 PM, Georgi Djakov wrote:
> In addition to frequency and voltage, some devices may have bandwidth
> requirements for their interconnect throughput - for example a CPU
> or GPU may also need to increase or decrease their bandwidth to DDR
> memory based on the current operating performance point.
> 
> Extend the OPP tables with additional property to describe the bandwidth
> needs of a device. The average and peak bandwidth values depend on the
> hardware and its properties.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>   Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
>   .../devicetree/bindings/property-units.txt    |  4 ++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 76b6c79604a5..830f0206aea7 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -132,6 +132,9 @@ Optional properties:
>   - opp-level: A value representing the performance level of the device,
>     expressed as a 32-bit integer.
>   
> +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
> +  the two integer values for average and peak bandwidth in megabytes per second.
> +
>   - clock-latency-ns: Specifies the maximum possible transition latency (in
>     nanoseconds) for switching to this OPP from any other OPP.
>   
> @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>   		};
>   	};
>   };
> +
> +Example 7: bandwidth-MBps:
> +Average and peak bandwidth values for the interconnects between CPU and DDR
> +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
> +interconnects is scaled together with CPU frequency.
> +
> +/ {
> +	cpus {
> +		CPU0: cpu@0 {
> +			compatible = "arm,cortex-a53", "arm,armv8";
> +			...
> +			operating-points-v2 = <&cpu_opp_table>;
> +			/* path between CPU and DDR memory and CPU and L3 */
> +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
> +					<&noc MASTER_CPU &noc SLAVE_L3>;
> +		};
> +	};
> +
> +	cpu_opp_table: cpu_opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
> +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
> +			bandwidth-MBps = <457 1525>, <914 3050>;
> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			/* CPU<->DDR bandwidth: 915 MB/s average, 3051 MB/s peak */
> +			 * CPU<->L3 bandwidth: 1828 MB/s average, 6102 MB/s peak */
> +			bandwidth-MBps = <915 3051>, <1828 6102>;
> +		};
> +	};

nit: missed closing braces

> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index bfd33734faca..9c3dbefcdae8 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -41,3 +41,7 @@ Temperature
>   Pressure
>   ----------------------------------------
>   -kpascal	: kiloPascal
> +
> +Throughput
> +----------------------------------------
> +-MBps		: megabytes per second
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
