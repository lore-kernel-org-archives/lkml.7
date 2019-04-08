Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E4BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7941E20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDHKjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:39:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:39:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F2D4C2828A0
Subject: Re: [PATCH v3 2/4] mfd: cros_ec: instantiate properly CrOS ISH MCU
 device
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
References: <20190408094141.27858-1-enric.balletbo@collabora.com>
 <20190408094141.27858-3-enric.balletbo@collabora.com>
 <20190408102825.GJ9224@smile.fi.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <565c3640-97ab-4a8c-e5bd-fb47d3fd3dfb@collabora.com>
Date:   Mon, 8 Apr 2019 12:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408102825.GJ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/19 12:28, Andy Shevchenko wrote:
> On Mon, Apr 08, 2019 at 11:41:39AM +0200, Enric Balletbo i Serra wrote:
>> From: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
>>
>> Integrated Sensor Hub (ISH) is also a MCU running EC
>> having feature bit EC_FEATURE_ISH. Instantiate it as
>> a special CrOS EC device with device name 'cros_ish'.
> 
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
>> Changes in v3:
>> - Fix Andy Shevchenko email.
> 

The fix was s/andry/andriy/ For some reason I missed an 'i' in your name and the
email obviously bounced for your address.

> I'm not sure what it means.
> I'm using @linux.intel.com for OSS work.
> 

Seems that you used andriy.shevchenko@intel.com instead, see:

https://lore.kernel.org/patchwork/patch/1047022/

The part that says:

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


