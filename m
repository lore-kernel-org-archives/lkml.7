Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B9ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB2621835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="L69K3sSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfJIMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:48:27 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:51771 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfJIMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SYIJ6IPWOlpj5WATHXmZNe6pBHCn+BfMqMdU9hKzdt8=; b=L69K3sSVmY1LeI7Fga3acpiRNq
        1qvgIiW40RId5WHUHO+isXNclHGgeUPyvczPdnNDNOl+2KOtMVkgaWC1aNuxCL0F24uDXDpThLzbb
        qywKftzwBjivTZkR2OpGXnRqKlm4803pQMuy2CP8+96KIo8vtD0eHRl0PGuZZUdeX+QAE6H0QIptP
        G51GadLMl2V5hpPN+ZlbjXdJo2gFuI36y2fq6V1jQbcETkod3GQw2ATIdQtlrOg6zBm+Fqz8O8TC1
        mBpmguOxGCZPRs9lotdzAD2mo6syj2HwI3ZSpGMzyYFOsURO8UoUPHM+yFWivSZydKt+aDLXqlUXv
        khH7fLxg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51119 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1iIBOC-0003Og-Ok; Wed, 09 Oct 2019 14:48:24 +0200
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
To:     Daniel Vetter <daniel@ffwll.ch>
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
 <20191001134555.GB22532@ziepe.ca>
 <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
 <20191009104531.GW16989@phenom.ffwll.local>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <1bc77839-c47a-6e79-dd6e-e26e05b34eae@tronnes.org>
Date:   Wed, 9 Oct 2019 14:48:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009104531.GW16989@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 09.10.2019 12.45, skrev Daniel Vetter:
> On Tue, Oct 01, 2019 at 04:07:38PM +0200, Noralf Trønnes wrote:
>> Hi drm-misc maintainers,
>>
>> I have just applied a patch to drm-misc-next that as it turns out should
>> have been applied to -fixes for this -rc cycle.
>>
>> Should I cherry pick it to drm-misc-next-fixes?
> 
> Yup, cherry pick and reference the commit that's already in -next (in case
> it creates conflicts down the road that reference makes the mess easier to
> understand).
> 

I remembered that Maxime just sent out a fixes pull and the subject says
drm-misc-fixes. The prevous one he sent out was -next-fixes.
So it looks like I should cherry pick to drm-misc-fixes for it to show
up in 5.4?

Noralf.

>> (I know there's a flowchart in the docs but I've never really understood
>> it.)
> 
> Usually bugfixes for kernel releases should land in drm-misc-next-fixes or
> drm-misc-fixes. But cherry-picking over in case of mistakes is ok too.
> -Daniel
> 
>>
>> Noralf.
>>
>> Den 01.10.2019 15.45, skrev Jason Gunthorpe:
>>> On Tue, Oct 01, 2019 at 03:28:46PM +0200, Noralf Trønnes wrote:
>>>>
>>>>
>>>> Den 01.10.2019 14.36, skrev Jason Gunthorpe:
>>>>> On Thu, Jul 25, 2019 at 12:51:30PM +0200, Noralf Trønnes wrote:
>>>>>> This makes the tiny drivers visible by default without having to enable a
>>>>>> knob.
>>>>>>
>>>>>> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
>>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com> to it once
>>>>>>  drivers/gpu/drm/Makefile        |  2 +-
>>>>>>  drivers/gpu/drm/tinydrm/Kconfig | 37 +++++++++++++++++++--------------
>>>>>>  2 files changed, 22 insertions(+), 17 deletions(-)
>>>>>
>>>>> Bisection says this patch (28c47e16ea2a19adb47fe2c182cbd61cb854237c)
>>>>> breaks kconfig stuff in v5.4-rc by creating circular
>>>>> dependencies. Could someone send a -rc patch to fix this please?
>>>>>
>>>>> THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
>>>>> ...depends on FB_SSD1307 (defined at drivers/video/fbdev/Kconfig:2259), with definition...
>>>>> ...depends on FB (defined at drivers/video/fbdev/Kconfig:12), with definition...
>>>>> ...depends on DRM_KMS_FB_HELPER (defined at drivers/gpu/drm/Kconfig:79), with definition...
>>>>> ...depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), with definition...
>>>>> ...depends on TINYDRM_REPAPER (defined at drivers/gpu/drm/tinydrm/Kconfig:51), with definition...
>>>>> ...depends on THERMAL (defined at drivers/thermal/Kconfig:6), with definition...
>>>>> ...depends on SENSORS_NPCM7XX (defined at drivers/hwmon/Kconfig:1285), with definition...
>>>>> ...depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition...
>>>>> ...depends on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
>>>>> ...depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with definition...
>>>>> ...depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with definition...
>>>>> ...depends on BACKLIGHT_CLASS_DEVICE (defined at drivers/video/backlight/Kconfig:144), with definition...
>>>>> ...depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484)
>>>>>
>>>>
>>>> Would this commit fix this by any chance:
>>>>
>>>> drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER
>>>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dfef959803c728c616ad29b008cd91b3446a993a
>>>
>>> Yes, thank you, can someone send this to -rc to unbreak 5.4?
>>>
>>> Jason
>>>
> 
