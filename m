Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1002064A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfC1Sko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:40:44 -0400
Received: from foss.arm.com ([217.140.101.70]:49926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfC1Skn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:40:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 823F115AB;
        Thu, 28 Mar 2019 11:40:43 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E463F614;
        Thu, 28 Mar 2019 11:40:41 -0700 (PDT)
Subject: Re: [PATCH 21/25] coresight: Use fwnode handle instead of device
 names
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
 <1553107783-3340-22-git-send-email-suzuki.poulose@arm.com>
 <20190328174216.GD778@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <01518a53-23d1-8c70-7327-69e8602bddb6@arm.com>
Date:   Thu, 28 Mar 2019 18:42:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190328174216.GD778@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2019 05:42 PM, Mathieu Poirier wrote:
> On Wed, Mar 20, 2019 at 06:49:38PM +0000, Suzuki K Poulose wrote:
>> We rely on the device names to find a CoreSight device on the
>> coresight bus. The device name however is obtained from the platform,
>> which is bound to the real platform/amba device. As we are about
>> to use different naming scheme for the coresight devices, we can't
>> rely on the platform device name to find the corresponding
>> coresight device. Instead we use the platform agnostic
>> "fwnode handle" of the parent device to find the devices.
>> We also reuse the same fwnode as the parent for the Coresight
>> device we create.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Agreed to all comments. Will address them in the next revision.

Cheers
Suzuki
