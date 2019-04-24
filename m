Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D5BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA75121905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KNTUJoCb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SjlHOwD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfDXJA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:00:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:00:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96E4A60769; Wed, 24 Apr 2019 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556096425;
        bh=Van698OCEsULgU1Ypynd+NrLwqHe+jSsp7HuHfcwrtM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KNTUJoCbaoSYaKesmfnwO9iS9Xq9S+s/5yHVAWUsTWKjArygN34I6IFOaOtABJkAd
         27hRsApLTjPIbpiLGLHskf5GZkEuAWgXx+UQPYJdlI9OTDsszJEWbsCGfoeSMx5CLP
         2xIiu/m2EFIF0ff/zv2tyfGSM3+c9PhzHlQn+CGE=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 302F760117;
        Wed, 24 Apr 2019 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556096424;
        bh=Van698OCEsULgU1Ypynd+NrLwqHe+jSsp7HuHfcwrtM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SjlHOwD+N6SX8rc+84RmROBOq7BgetS0QN90GFhOvNyV6IEhVK1LhKEkopNd9ra+4
         dBKWHh5tgRMsMRPDgH81WNOoKf+8axM9n/z9XCp8DxXtsEEI2rHaBrnPwKP7yj4w76
         UChZj1gb/Xdo9aVUk7m+JO1mIe/4mL5wBBUMTYwE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 302F760117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps
 bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        sboyd@kernel.org, nm@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
 <20190423132823.7915-2-georgi.djakov@linaro.org>
 <e35223d0-80ac-5236-2b8d-7f46cd3a1581@codeaurora.org>
 <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <dd6f055c-e7df-13e8-72aa-2973d3c664d0@codeaurora.org>
Date:   Wed, 24 Apr 2019 14:30:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190424064942.v5g6jr5l3xy5z3xv@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Viresh,

On 4/24/19 12:19 PM, Viresh Kumar wrote:
> On 24-04-19, 12:16, Rajendra Nayak wrote:
>>
>>
>> On 4/23/2019 6:58 PM, Georgi Djakov wrote:
>>> In addition to frequency and voltage, some devices may have bandwidth
>>> requirements for their interconnect throughput - for example a CPU
>>> or GPU may also need to increase or decrease their bandwidth to DDR
>>> memory based on the current operating performance point.
>>>
>>> Extend the OPP tables with additional property to describe the bandwidth
>>> needs of a device. The average and peak bandwidth values depend on the
>>> hardware and its properties.
>>>
>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>> ---
>>>    Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
>>>    .../devicetree/bindings/property-units.txt    |  4 ++
>>>    2 files changed, 42 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
>>> index 76b6c79604a5..830f0206aea7 100644
>>> --- a/Documentation/devicetree/bindings/opp/opp.txt
>>> +++ b/Documentation/devicetree/bindings/opp/opp.txt
>>> @@ -132,6 +132,9 @@ Optional properties:
>>>    - opp-level: A value representing the performance level of the device,
>>>      expressed as a 32-bit integer.
>>> +- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
>>> +  the two integer values for average and peak bandwidth in megabytes per second.
>>> +
>>>    - clock-latency-ns: Specifies the maximum possible transition latency (in
>>>      nanoseconds) for switching to this OPP from any other OPP.
>>> @@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
>>>    		};
>>>    	};
>>>    };
>>> +
>>> +Example 7: bandwidth-MBps:
>>> +Average and peak bandwidth values for the interconnects between CPU and DDR
>>> +memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
>>> +interconnects is scaled together with CPU frequency.
>>> +
>>> +/ {
>>> +	cpus {
>>> +		CPU0: cpu@0 {
>>> +			compatible = "arm,cortex-a53", "arm,armv8";
>>> +			...
>>> +			operating-points-v2 = <&cpu_opp_table>;
>>> +			/* path between CPU and DDR memory and CPU and L3 */
>>> +			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
>>> +					<&noc MASTER_CPU &noc SLAVE_L3>;
>>> +		};
>>> +	};
>>> +
>>> +	cpu_opp_table: cpu_opp_table {
>>> +		compatible = "operating-points-v2";
>>> +		opp-shared;
>>> +
>>> +		opp-200000000 {
>>> +			opp-hz = /bits/ 64 <200000000>;
>>> +			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
>>> +			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
>>> +			bandwidth-MBps = <457 1525>, <914 3050>;
>>
>> Should this also have a bandwidth-MBps-name perhaps? Without that I guess we assume
>> the order in which we specify the interconnects is the same as the order here?
> 
> Right, so I suggested not to add the -name property and to rely on the
> order. Though I missed that he hasn't mentioned the order thing here.

by skipping names, aren't we forced to specify all the specified paths
bandwidths for each opp even if it is redundant? i.e if the first/second
icc path doesn't have to change across a few opps but if the other path
does need to change this scheme would force it to be included and will
try to set the first/second path again.


e.g: Here the first path does not have to change across these two opps
but have to specified nonetheless since we omit names.

+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			bandwidth-MBps = <457 1525>, <914 3050>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			bandwidth-MBps = <457 1525>, <1828 6102>;
+		};


> 
> @Georgi: Please mention above in the binding that the order is same as
> interconnects binding.
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
