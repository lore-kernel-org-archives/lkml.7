Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CE221850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfC1TWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:22:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50494 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1TWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:22:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AB715AB;
        Thu, 28 Mar 2019 12:22:21 -0700 (PDT)
Received: from [10.37.12.85] (unknown [10.37.12.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5A8C3F614;
        Thu, 28 Mar 2019 12:22:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: coresight: Support static funnel
To:     leo.yan@linaro.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        shiwanglai@hisilicon.com
References: <20190328023509.22242-1-leo.yan@linaro.org>
 <20190328023509.22242-2-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4b0ecaee-a578-f328-7f62-8ca49f7729bb@arm.com>
Date:   Thu, 28 Mar 2019 19:24:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190328023509.22242-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2019 02:35 AM, Leo Yan wrote:
> Document DT binding for static (non-configurable) funnel and give an
> example for it.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Wanglai Shi <shiwanglai@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
