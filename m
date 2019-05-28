Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4692DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B3D2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfE1Rkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 13:40:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33706 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1Rkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 13:40:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9AE780D;
        Tue, 28 May 2019 10:40:30 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C1B53F59C;
        Tue, 28 May 2019 10:40:29 -0700 (PDT)
Subject: Re: [PATCH v4 00/30] coresight: Support for ACPI bindings
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkzRXXB1EFpWHn6JN_6pfOm-1TvVgiJY2MKExhifiBakBQ@mail.gmail.com>
 <CANLsYkzK7N9Bt6E6f187LaDydeC5afMp=LjMuvhFYKbij_SyjA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <24558133-c66a-018d-3ef6-1cd963302109@arm.com>
Date:   Tue, 28 May 2019 18:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkzK7N9Bt6E6f187LaDydeC5afMp=LjMuvhFYKbij_SyjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 28/05/2019 18:36, Mathieu Poirier wrote:
> On Tue, 28 May 2019 at 11:32, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>

...

>>
>> I have applied this set.

Thanks.

> 
> As Leo pointed out it would be interesting to update the documentation
> in "Documentation/trace/coresight.txt".

I am on it, will send it out soon.

Cheers
Suzuki


