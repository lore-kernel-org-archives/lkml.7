Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1107C205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDDItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:49:00 -0400
Received: from foss.arm.com ([217.140.101.70]:54678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfDDIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:48:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 397F11596;
        Thu,  4 Apr 2019 01:48:59 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D06563F557;
        Thu,  4 Apr 2019 01:48:57 -0700 (PDT)
Subject: Re: [PATCH v3 01/20] coresight: pmu: Adding ITRACE property to cs_etm
 PMU
To:     mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        Mike.leach@arm.com, leo.yan@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
 <20190404033541.14072-2-mathieu.poirier@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6ad55b70-9c1d-eb12-14cb-90ea3724dde0@arm.com>
Date:   Thu, 4 Apr 2019 09:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404033541.14072-2-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2019 04:35, Mathieu Poirier wrote:
> Add to the capabilities the ITRACE property so that ITRACE START events
> are generated when the PMU is switched on by the core.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
