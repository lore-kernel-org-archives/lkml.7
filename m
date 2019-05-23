Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFFEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4922175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfEWPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:31:57 -0400
Received: from foss.arm.com ([217.140.101.70]:49102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfEWPb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:31:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E057A78;
        Thu, 23 May 2019 08:31:56 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3B813F690;
        Thu, 23 May 2019 08:31:55 -0700 (PDT)
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
To:     leo.yan@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <20190523143227.GC31751@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <23a50436-4bcf-3439-c189-093e1a58438d@arm.com>
Date:   Thu, 23 May 2019 16:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523143227.GC31751@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 23/05/2019 15:32, Leo Yan wrote:
> Hi Suzuki,
> 
> On Wed, May 22, 2019 at 11:34:33AM +0100, Suzuki K Poulose wrote:
> 
> [...]
> 
>> Changes since v2:
>>   - Drop the patches exposing device links via sysfs, to be posted as separate
>>     series.
> 
> Thanks for sharing the git tree linkage in another email.  Just want
> to confirm, since patch set v3 you have dropped the patch "coresight:
> Expose device connections via sysfs" [1], will you send out this patch
> after ACPI binding support patches has been merged?

We are awaiting Mike's comment on the approach, as his CTI support also
needs something similar.

> 
> When you send out the new patch for exposing device connection, please
> loop me so that I can base on it for perf testing related works.

Sure, will do. As such, the perf testing should not be affected by that
series. It is just a helper to demonstrate the connections. But yes, it
will definitely help you to choose an ETF for a cluster, if you had multiple
ETFs on the system. Otherwise, you should be OK.

Please be aware that the power management support is missing on ACPI platform.
So you must make sure, by other means, that the debug domain is powered up.


Cheers
Suzuki
