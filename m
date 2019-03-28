Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D52082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfC1LBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:01:31 -0400
Received: from foss.arm.com ([217.140.101.70]:42686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfC1LBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:01:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B7A15BF;
        Thu, 28 Mar 2019 04:01:30 -0700 (PDT)
Received: from [10.37.12.55] (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 060F73F59C;
        Thu, 28 Mar 2019 04:01:27 -0700 (PDT)
Subject: Re: [PATCH 15/25] coresight: etm3x: Rearrange cp14 access detection
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-16-git-send-email-suzuki.poulose@arm.com>
 <20190327220559.GB778@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c2e647a3-17ea-326f-df1a-7e73ff918994@arm.com>
Date:   Thu, 28 Mar 2019 11:03:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327220559.GB778@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2019 10:05 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:32PM +0000, Suzuki K Poulose wrote:
>> As we are about to about refactor the platform specific handling,
> 
> s/about//
> 
>> move the DT property handling to generic helpers.
>>

Thanks for spotting. Will fix it.

Suzuki
