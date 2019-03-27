Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6A2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfC0LnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:43:05 -0400
Received: from foss.arm.com ([217.140.101.70]:53232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfC0LnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30B2A374;
        Wed, 27 Mar 2019 04:43:05 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364123F557;
        Wed, 27 Mar 2019 04:43:03 -0700 (PDT)
Subject: Re: [PATCH 08/25] coresight: tmc: Clean up device specific data
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com,
        mathie.poirier@linaro.org
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-9-git-send-email-suzuki.poulose@arm.com>
 <20190326215322.GA1658@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cdb22ab6-c43f-5cf6-3110-eaa6906ae1a5@arm.com>
Date:   Wed, 27 Mar 2019 11:45:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190326215322.GA1658@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2019 09:53 PM, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Mar 20, 2019 at 06:49:25PM +0000, Suzuki K Poulose wrote:
>> In preparation to use a consistent device naming scheme,
>> clean up the device link tracking in replicator driver.
>> Use the "coresight" device instead of the "real" parent device
>> for all internal purposes. All other requests (e.g, power management,
>> DMA operations) must use the "real" device which is the parent device.
>>
>> Since the CATU driver also uses the TMC-SG infrastructure, update
>> the callers to ensure they pass the appropriate device argument
>> for the tables.
>>
>> Cc: Mathieu Poirier <mathie.poirier@linaro.org>
> 
> I was wondering why patches 6, 7, and 8 didn't make it to my inbox...  Now I
> have the answer :o)

Ah! Sorry about that. Will fix it

Suzuki
