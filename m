Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E05EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE78C21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DCJ4BiZ1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FMfhw8wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfC2Gc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:32:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfC2Gc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:32:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7FBC0608CC; Fri, 29 Mar 2019 06:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553841148;
        bh=U9JolyigyoUdXwTTKNcmJjEBXaM8kw3G/V+EhjwJlVE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DCJ4BiZ1WWPSFIsQSMkqF49d4DKnDHcmggmDsv/L1lOEpyKQllpl+tnQ8UDT7mrMc
         PqcZxndAcVR+EFtcW8UVznE2FHoNdZy3X38LkfpDljcRUqeGmbxhUROsjlItCRdOuB
         NTDmeZlufDryF5RsGV8UnuAVLcpF6FWikpIAv71c=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F29A604BE;
        Fri, 29 Mar 2019 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553841147;
        bh=U9JolyigyoUdXwTTKNcmJjEBXaM8kw3G/V+EhjwJlVE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FMfhw8wBhocN8ySZZAujcMYNzHA9ibJfrIR9/clHj4/HJYRfIF8Mxioh8FQ3KE302
         1xXPosMOyj0O8EV/gAPOoU8ogp3S1jTKKLUjRO5oTjvwHfz147zt7BSJWzH5AgzsWv
         a/OfYXtHmzl3vhYriZED8j9DGBPXz73nt5g1C9yg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F29A604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] gpu:drm: Remove duplicate headers
To:     Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        a.hajda@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
 <20190328065124.GB4846@pendragon.ideasonboard.com>
 <20190328160206.GA94653@CentOS76.localdomain>
 <20190328141210.GA4813@pendragon.ideasonboard.com>
 <20190328190203.GA27353@CentOS76.localdomain>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <65ce06ec-32b7-c662-ef4d-9ee9d1315e5a@codeaurora.org>
Date:   Fri, 29 Mar 2019 12:02:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328190203.GA27353@CentOS76.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 12:32 AM, Jagadeesh Pagadala wrote:
> On Thu, Mar 28, 2019 at 04:12:10PM +0200, Laurent Pinchart wrote:
>> Hi Jagadeesh,
>>
>> On Thu, Mar 28, 2019 at 09:32:06PM +0530, Jagadeesh Pagadala wrote:
>>> On Thu, Mar 28, 2019 at 08:51:24AM +0200, Laurent Pinchart wrote:
>>>> On Thu, Mar 28, 2019 at 02:41:56AM +0530, jagdsh.linux@gmail.com wrote:
>>>>> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>>>>>
>>>>> Remove duplicate headers which are included twice.
>>>> Could you, while at it, also sort the existing #include statements
>>>> alphabetically ? This should help avoiding similar issues in the future.
>>>>
>>>>> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

>>>>> ---
>>>>>   drivers/gpu/drm/bridge/panel.c       | 1 -
>>>>>   drivers/gpu/drm/i915/intel_display.c | 7 -------
>>>>>   2 files changed, 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
>>>>> index 38eeaf8..eb9567d 100644
>>>>> --- a/drivers/gpu/drm/bridge/panel.c
>>>>> +++ b/drivers/gpu/drm/bridge/panel.c
>>>>> @@ -15,7 +15,6 @@
>>>>>   #include <drm/drm_encoder.h>
>>>>>   #include <drm/drm_modeset_helper_vtables.h>
>>>>>   #include <drm/drm_probe_helper.h>
>>>>> -#include <drm/drm_panel.h>
>>>>>   
>>>>>   struct panel_bridge {
>>>>>   	struct drm_bridge bridge;
>>>>> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
>>>>> index ccb6163..1166342 100644
>>>>> --- a/drivers/gpu/drm/i915/intel_display.c
>>>>> +++ b/drivers/gpu/drm/i915/intel_display.c
>>>>> @@ -51,14 +51,7 @@
>>>>>   #include "intel_dsi.h"
>>>>>   #include "intel_frontbuffer.h"
>>>>>   
>>>>> -#include "intel_drv.h"
>>>>> -#include "intel_dsi.h"
>>>>> -#include "intel_frontbuffer.h"
>>>>> -
>>>>> -#include "i915_drv.h"
>>>>> -#include "i915_gem_clflush.h"
>>>>>   #include "i915_reset.h"
>>>>> -#include "i915_trace.h"
>>>>>   
>>>>>   /* Primary plane formats for gen <= 3 */
>>>>>   static const u32 i8xx_primary_formats[] = {
>>>  From c9a68b204fe4bb013c2b8481ca8239c957dd69cc Mon Sep 17 00:00:00 2001
>>> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>>> Date: Thu, 28 Mar 2019 21:20:12 +0530
>>> Subject: [PATCH] gpu:drm: sort the existing #includes alphabetically
>>>
>>> Hi Laurent,
>>>
>>> Hopefully this helps.
>> It does, thanks. If you squash it with your original patch and send a
>> v2, you can add my
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>>> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>>> ---
>>>   drivers/gpu/drm/bridge/panel.c       | 2 +-
>>>   drivers/gpu/drm/i915/intel_display.c | 4 ++--
>>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
>>> index eb9567d..000ba7c 100644
>>> --- a/drivers/gpu/drm/bridge/panel.c
>>> +++ b/drivers/gpu/drm/bridge/panel.c
>>> @@ -9,11 +9,11 @@
>>>    */
>>>   
>>>   #include <drm/drmP.h>
>>> -#include <drm/drm_panel.h>
>>>   #include <drm/drm_atomic_helper.h>
>>>   #include <drm/drm_connector.h>
>>>   #include <drm/drm_encoder.h>
>>>   #include <drm/drm_modeset_helper_vtables.h>
>>> +#include <drm/drm_panel.h>
>>>   #include <drm/drm_probe_helper.h>
>>>   
>>>   struct panel_bridge {
>>> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
>>> index 1166342..7956e89 100644
>>> --- a/drivers/gpu/drm/i915/intel_display.c
>>> +++ b/drivers/gpu/drm/i915/intel_display.c
>>> @@ -46,13 +46,13 @@
>>>   
>>>   #include "i915_drv.h"
>>>   #include "i915_gem_clflush.h"
>>> +#include "i915_reset.h"
>>>   #include "i915_trace.h"
>>> +
>>>   #include "intel_drv.h"
>>>   #include "intel_dsi.h"
>>>   #include "intel_frontbuffer.h"
>>>   
>>> -#include "i915_reset.h"
>>> -
>>>   /* Primary plane formats for gen <= 3 */
>>>   static const u32 i8xx_primary_formats[] = {
>>>   	DRM_FORMAT_C8,
>> -- 
>> Regards,
>>
>> Laurent Pinchart
