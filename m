Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3167C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C799024992
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfFDLmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:42:07 -0400
Received: from foss.arm.com ([217.140.101.70]:41034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfFDLmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:42:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF1380D;
        Tue,  4 Jun 2019 04:42:06 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FB9B3F690;
        Tue,  4 Jun 2019 04:42:05 -0700 (PDT)
Subject: Re: [RFC PATCH 47/57] drivers: mfd: Use driver_find_device_by_name
 helper
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, lee.jones@linaro.org
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-48-git-send-email-suzuki.poulose@arm.com>
 <CAK8P3a22Uo9mLh7cLpZQQpxRFd=XJ1uKu66eu1c6_AMNzW8etg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ae7c07c5-f223-dec4-b8e4-c49d08a76fd7@arm.com>
Date:   Tue, 4 Jun 2019 12:42:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a22Uo9mLh7cLpZQQpxRFd=XJ1uKu66eu1c6_AMNzW8etg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 04/06/2019 10:45, Arnd Bergmann wrote:
> On Mon, Jun 3, 2019 at 5:52 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> Use the new driver_find_device_by_name() helper.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I see that there are currently no callers of this function, and I never
> liked the interface anyway, so how about just removing
> syscon_regmap_lookup_by_pdevname instead?

If that works for you, sure. I can send in a patch separately
and hopefully I can remove this patch depending when the said
change lands.

Cheers
Suzuki
