Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59C0C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D220880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfHHGko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:40:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46090 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfHHGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:40:44 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hvc6L-0003JS-AZ
        for linux-kernel@vger.kernel.org; Thu, 08 Aug 2019 06:40:41 +0000
Received: by mail-pl1-f199.google.com with SMTP id u10so54891766plq.21
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 23:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l5rHDYLgnHvJXY+ZnRDc5GLGTswz9I9fXq6PUolc/fA=;
        b=EM2YfSsO9jOsXgJfYfeHWAyr0IsyWR99c9Dvoo7F8iZDhHAPxpCTHif3F1gkWIDWMJ
         /pr+Vs5FsudZg8MulM1ITRqqXPEKRVIzqFrYgGNmk5g/jRsHFumTmmV71tcUsx8l6N2X
         vMJyexfKDrFaBt06jOjU2Qe4Q6HF75wu09rBTZ6u0qWwbz3Q7rs47GGhtPx5vdYJ9cRf
         q7WzfKF/zvI3YAAz30zTRgq/QP4khAkujdDD3tWMMNxhe2MglrhFZ9AYT2Mut3HrAX2Q
         3clhYXkVNyvEVz3KzNu11TGk6Uaixo51T2FQf1DJjPkDvNpWnQ9pZF+66gDyNASVbOUT
         7nDA==
X-Gm-Message-State: APjAAAUrmK5pMa/1i+Lcu7Q6myx0Sx6YQPFEV6PNhvLdqir3ecjgjwWJ
        u+D599n+Jw6U2sAFNLk6SPWJrIJ3JNfb99OZfgP/lRi1IxuQzX075NO9AYWFHdiy4NvjxMe4WHC
        T/cd5XgsX0uuUArEfq2x+PbU4xOQ8gS7eVkGZZ68ZYg==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr11396996pgm.413.1565246439459;
        Wed, 07 Aug 2019 23:40:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyCC/9Sa5BPRZy+RR5FexWvctk+jCAEtO3eVujnO8PsCr5So5Y7KoFCZ0L6y07X3R/2s7tBdg==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr11396964pgm.413.1565246439050;
        Wed, 07 Aug 2019 23:40:39 -0700 (PDT)
Received: from 2001-b011-380f-37d3-00e0-0f28-6109-9f39.dynamic-ip6.hinet.net (2001-b011-380f-37d3-00e0-0f28-6109-9f39.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:e0:f28:6109:9f39])
        by smtp.gmail.com with ESMTPSA id z68sm85843578pgz.88.2019.08.07.23.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 23:40:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven series
 (v2)"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <MN2PR12MB3309680845257BC66644133CECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
Date:   Thu, 8 Aug 2019 14:40:35 +0800
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
Content-Transfer-Encoding: 8bit
Message-Id: <94CAE10C-1C2D-4A62-A26B-971A8EEE277A@canonical.com>
References: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
 <MN2PR12MB330979BAFF5BCC758258D54CECD40@MN2PR12MB3309.namprd12.prod.outlook.com>
 <624BFB8F-B586-492E-BEA6-4B138DAEC831@canonical.com>
 <MN2PR12MB3309680845257BC66644133CECD70@MN2PR12MB3309.namprd12.prod.outlook.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 14:29, Huang, Ray <Ray.Huang@amd.com> wrote:

>> -----Original Message-----
>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Sent: Thursday, August 08, 2019 1:45 AM
>> To: Huang, Ray <Ray.Huang@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
>> <David1.Zhou@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>;
>> dri-devel@lists.freedesktop.org; LKML <linux-kernel@vger.kernel.org>;
>> Anthony Wong <anthony.wong@canonical.com>
>> Subject: Re: [Regression] "drm/amdgpu: enable gfxoff again on raven series
>> (v2)"
>>
>> Hi Ray,
>>
>> at 00:03, Huang, Ray <Ray.Huang@amd.com> wrote:
>>
>>> May I know the all firmware version in your system?
>
> Seems to the issue we encountered with IOMMU enabled. Could you please  
> disable iommu in SBIOS or GRUB?

Yes, "amd_iommu=off" can workaround the issue.

Kai-Heng

>
> Thanks,
> Ray
>
>> # cat amdgpu_firmware_info
>> VCE feature version: 0, firmware version: 0x00000000
>> UVD feature version: 0, firmware version: 0x00000000
>> MC feature version: 0, firmware version: 0x00000000
>> ME feature version: 40, firmware version: 0x00000099
>> PFP feature version: 40, firmware version: 0x000000ae
>> CE feature version: 40, firmware version: 0x0000004d
>> RLC feature version: 1, firmware version: 0x00000213
>> RLC SRLC feature version: 1, firmware version: 0x00000001
>> RLC SRLG feature version: 1, firmware version: 0x00000001
>> RLC SRLS feature version: 1, firmware version: 0x00000001
>> MEC feature version: 40, firmware version: 0x0000018b
>> MEC2 feature version: 40, firmware version: 0x0000018b
>> SOS feature version: 0, firmware version: 0x00000000
>> ASD feature version: 0, firmware version: 0x001ad4d4
>> TA XGMI feature version: 0, firmware version: 0x00000000
>> TA RAS feature version: 0, firmware version: 0x00000000
>> SMC feature version: 0, firmware version: 0x00001e44
>> SDMA0 feature version: 41, firmware version: 0x000000a9
>> VCN feature version: 0, firmware version: 0x0110901c
>> DMCU feature version: 0, firmware version: 0x00000000
>> VBIOS version: 113-RAVEN-103
>>
>> Kai-Heng
>>
>>> Thanks,
>>> Ray
>>>
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Wednesday, August 7, 2019 8:50 PM
>>> To: Huang, Ray
>>> Cc: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); amd-
>> gfx
>>> list; dri-devel@lists.freedesktop.org; LKML; Anthony Wong
>>> Subject: [Regression] "drm/amdgpu: enable gfxoff again on raven series
>>> (v2)"
>>>
>>> Hi,
>>>
>>> After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven
>> series
>>> (v2)”), browsers on Raven Ridge systems cause serious corruption like  
>>> this:
>>> https://launchpadlibrarian.net/436319772/Screenshot%20from%202019-
>> 08-07%2004-20-34.png
>>> Firmwares for Raven Ridge is up-to-date.
>>>
>>> Kai-Heng


