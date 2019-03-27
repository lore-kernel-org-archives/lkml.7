Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFB6206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfC0RbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:31:14 -0400
Received: from foss.arm.com ([217.140.101.70]:58432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfC0RbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:31:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A401596;
        Wed, 27 Mar 2019 10:31:12 -0700 (PDT)
Received: from [10.37.12.55] (unknown [10.37.12.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7600F3F557;
        Wed, 27 Mar 2019 10:31:10 -0700 (PDT)
Subject: Re: [PATCH 05/25] coresight: Merge the static and dynamic replicator
 drivers
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-6-git-send-email-suzuki.poulose@arm.com>
 <20190327152749.GC1658@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <21d02bdd-5fe2-4496-b96d-f588f559e8d7@arm.com>
Date:   Wed, 27 Mar 2019 17:33:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327152749.GC1658@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2019 03:27 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:22PM +0000, Suzuki K Poulose wrote:
>> Merge the drivers for the two varieties of replicators into
>> a singel one. The dynamic replicator has programming base
>> which can be programmed to filter the trace data. The driver
>> detects the type based on the "base" address value of the
>> device, which is NULL for the static device.
>>
>> Also, while at it, remove the now obsolete DYNAMIC_REPLICATOR
>> config entry.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I'll pickup patches 1 to 5 immediately as they are useful on their own.

Cool, Thanks. I will drop them from the next revision

Suzuki
