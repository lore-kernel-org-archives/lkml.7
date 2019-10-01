Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC35C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F27520815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hLKxiNOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfJAOHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:07:43 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:35769 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJAOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rOjfo7iJ4xoMy2FlBmLPoZd36TFqOKu/PofJxwLAs94=; b=hLKxiNOM+CvmkVJdUgOpZdVqk7
        T8kZfCetAhjDYNh+86H1QZYhq+O/dn9qAhU7qulKa2/yu1PujQ7nzteV3yX/GFeg0bfyws4FvWT7B
        tUYNfpMIqJmLRJceVhx4VkU70HsU9sePFt/mw9s7axURiK38VIilR5MoijU6LFnli0aSrKHRgYGfI
        p7VqEFX/IeGDGq6kAan+Of479Iw7NTPmkarUmvNbfAgQHYqLksMw3RMVd6znWJwaPjsrly2X8lyJy
        8tEVi7hk1V59irTFyckLRA4xK9tz4ZtP2uvRElon67VK+iSp1eTonr2YUPbGz76ji0oUnLL0HDis6
        u49hQ+xQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53091 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <noralf@tronnes.org>)
        id 1iFIoX-0005Hl-Hu; Tue, 01 Oct 2019 16:07:41 +0200
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
 <20191001134555.GB22532@ziepe.ca>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
Date:   Tue, 1 Oct 2019 16:07:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001134555.GB22532@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi drm-misc maintainers,

I have just applied a patch to drm-misc-next that as it turns out should
have been applied to -fixes for this -rc cycle.

Should I cherry pick it to drm-misc-next-fixes?
(I know there's a flowchart in the docs but I've never really understood
it.)

Noralf.

Den 01.10.2019 15.45, skrev Jason Gunthorpe:
> On Tue, Oct 01, 2019 at 03:28:46PM +0200, Noralf Trønnes wrote:
>>
>>
>> Den 01.10.2019 14.36, skrev Jason Gunthorpe:
>>> On Thu, Jul 25, 2019 at 12:51:30PM +0200, Noralf Trønnes wrote:
>>>> This makes the tiny drivers visible by default without having to enable a
>>>> knob.
>>>>
>>>> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com> to it once
>>>>  drivers/gpu/drm/Makefile        |  2 +-
>>>>  drivers/gpu/drm/tinydrm/Kconfig | 37 +++++++++++++++++++--------------
>>>>  2 files changed, 22 insertions(+), 17 deletions(-)
>>>
>>> Bisection says this patch (28c47e16ea2a19adb47fe2c182cbd61cb854237c)
>>> breaks kconfig stuff in v5.4-rc by creating circular
>>> dependencies. Could someone send a -rc patch to fix this please?
>>>
>>> THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
>>> ...depends on FB_SSD1307 (defined at drivers/video/fbdev/Kconfig:2259), with definition...
>>> ...depends on FB (defined at drivers/video/fbdev/Kconfig:12), with definition...
>>> ...depends on DRM_KMS_FB_HELPER (defined at drivers/gpu/drm/Kconfig:79), with definition...
>>> ...depends on DRM_KMS_HELPER (defined at drivers/gpu/drm/Kconfig:73), with definition...
>>> ...depends on TINYDRM_REPAPER (defined at drivers/gpu/drm/tinydrm/Kconfig:51), with definition...
>>> ...depends on THERMAL (defined at drivers/thermal/Kconfig:6), with definition...
>>> ...depends on SENSORS_NPCM7XX (defined at drivers/hwmon/Kconfig:1285), with definition...
>>> ...depends on HWMON (defined at drivers/hwmon/Kconfig:6), with definition...
>>> ...depends on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484), with definition...
>>> ...depends on ACPI_VIDEO (defined at drivers/acpi/Kconfig:193), with definition...
>>> ...depends on ACER_WMI (defined at drivers/platform/x86/Kconfig:19), with definition...
>>> ...depends on BACKLIGHT_CLASS_DEVICE (defined at drivers/video/backlight/Kconfig:144), with definition...
>>> ...depends again on THINKPAD_ACPI (defined at drivers/platform/x86/Kconfig:484)
>>>
>>
>> Would this commit fix this by any chance:
>>
>> drm/tiny: Kconfig: Remove always-y THERMAL dep. from TINYDRM_REPAPER
>> https://cgit.freedesktop.org/drm/drm-misc/commit/?id=dfef959803c728c616ad29b008cd91b3446a993a
> 
> Yes, thank you, can someone send this to -rc to unbreak 5.4?
> 
> Jason
> 
