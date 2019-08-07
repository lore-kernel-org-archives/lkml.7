Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6AEC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F210F21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHGKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:12:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfHGKMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:12:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCC028;
        Wed,  7 Aug 2019 03:12:42 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE71B3F575;
        Wed,  7 Aug 2019 03:12:40 -0700 (PDT)
Subject: Re: [PATCHv9 1/3] arm64: dts: qcom: sdm845: Add Coresight support
To:     saiprakash.ranjan@codeaurora.org, mathieu.poirier@linaro.org,
        bjorn.andersson@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, agross@kernel.org,
        david.brown@linaro.org, mark.rutland@arm.com
Cc:     rnayak@codeaurora.org, vivek.gautam@codeaurora.org,
        sibis@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        marc.w.gonzalez@free.fr
References: <cover.1564550873.git.saiprakash.ranjan@codeaurora.org>
 <be6d77eb6c7498df09d04e0a369d4d65b38f4b8e.1564550873.git.saiprakash.ranjan@codeaurora.org>
 <b50c06d4-8298-7abe-4442-2aff336509f5@codeaurora.org>
 <b5cb08ef-ca2f-e852-f234-d0f693b58596@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <adc1ac7a-877a-73cf-4051-4e3b4017799b@arm.com>
Date:   Wed, 7 Aug 2019 11:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b5cb08ef-ca2f-e852-f234-d0f693b58596@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai,

On 07/08/2019 11:08, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 7/31/2019 11:35 AM, Sai Prakash Ranjan wrote:
>> Hi Suzuki,
>>
>> On 7/31/2019 11:28 AM, Sai Prakash Ranjan wrote:
>>> Add coresight components found on Qualcomm SDM845 SoC.
>>>
>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 451 +++++++++++++++++++++++++++
>>>    1 file changed, 451 insertions(+)
>>
>> I have tested coresight with scatter gather on SDM845 MTP and MSM8996
>> based DB820c board and posted the results in
>>
>> - https://github.com/saiprakash-ranjan/coresight-test-results
>>
>> Please let me know if you need some additional testing done.
>>
>> I could not perform coresight tests on MSM8998 MTP with latest build
>> as it was resulting in crash due to some AHB timeouts. This was not
>> due to scatter-gather and mostly likely the problem with the build.
>> Maybe we can keep msm8998-coresight on hold?
>>
>> BTW, patches are based on linux-next.
>>
> 
> Any more tests you would want me to run?

Apologies for the late response. I had seen the results and they look fine.
I was hitting some issues, which I have now root caused to firmware issues.
So we are good to go.

Suzuki
