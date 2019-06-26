Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66181C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348652054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561540460;
	bh=g4DUkrrjfFj7xHESarAI2dRhed/w7oKp4416qFpgZRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SwSGr9Cvu0vaE/J8FVe8gusbQO3DhE798s3PH/mQUMaKrcVl1T5zESAQG3leYwaA3
	 0RdWqHh9MgwlY/rGi8RVhibH5xcQ7hyI3WOaF85Ojcmu5oSagsrfhv0usKktVPq02f
	 Gq3DhV4K5H0WAK9GGIfKFcgoAHcUxpdiy/JIM010=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFZJOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfFZJOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:14:18 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8484420B7C;
        Wed, 26 Jun 2019 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561540457;
        bh=g4DUkrrjfFj7xHESarAI2dRhed/w7oKp4416qFpgZRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=04n10WVyRHzd2WJpVjUcfjocTAX38tMp7ZVDMnyZ1/Y+vTeX1YXynvXcyk847krQE
         ndxGNtw2KD70rHuXPwJKF25ohyUe4IEzt6HS/DMhx83b+wSxLyb9UWW1AxvZl74xCx
         OPAxyIJyDvF6PpBu2fZnq5DfgSmRfOi2Rza2kIyM=
Received: by mail-lf1-f46.google.com with SMTP id j29so1039092lfk.10;
        Wed, 26 Jun 2019 02:14:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUnU8H06ieaByzPTPE/SOEmITgETD33BuRjn2RzXCmjT/iz9eXr
        +M5ogbdTZjj5FCk8i+F3HMBBXCwe+B7a/bvTgjk=
X-Google-Smtp-Source: APXvYqxyflZNdBFIUXAD5rBef4z4NLETV6l0FfCDdosZdM/KpjcmBy4iI0hm/rxk5/cFZrEESI5AZP6IaTMNv3wTk5s=
X-Received: by 2002:ac2:5601:: with SMTP id v1mr2104868lfd.106.1561540455758;
 Wed, 26 Jun 2019 02:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190625193451.7696-1-krzk@kernel.org>
In-Reply-To: <20190625193451.7696-1-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 26 Jun 2019 11:14:04 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeCQZPsF1kGKmhSWgxsWSsb4cre6mhS=n=kJbH63LjmUQ@mail.gmail.com>
Message-ID: <CAJKOXPeCQZPsF1kGKmhSWgxsWSsb4cre6mhS=n=kJbH63LjmUQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: defconfig: Samsung/Exynos for v5.3
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 at 21:35, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-defconfig-5.3
>
> for you to fetch changes up to dd50a69b5697532666023766688c6ea642e5a443:
>
>   ARM: exynos_defconfig: Enable Panfrost and Lima drivers (2019-06-19 19:23:35 +0200)
>
> ----------------------------------------------------------------
> Samsung defconfig changes for v5.3
>
> 1. Trim several configs with savedefconfig.
> 2. Enable Lima and Panfrost drivers for Mali GPU.

Hi,

I forgot to mention possible merge conflicts (although Stephen Cc-ed
you on mails). Resolution is to accept both sides:

--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@@ -4,12 -5,7 +5,8 @@@ CONFIG_PREEMPT=
  CONFIG_CGROUPS=y
  CONFIG_BLK_DEV_INITRD=y
  CONFIG_PERF_EVENTS=y
- CONFIG_MODULES=y
- CONFIG_MODULE_UNLOAD=y
- CONFIG_PARTITION_ADVANCED=y
  CONFIG_ARCH_EXYNOS=y
- CONFIG_ARCH_EXYNOS3=y
 +CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y

--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@@ -181,10 -178,11 +178,10 @@@ CONFIG_CFG80211=
  CONFIG_MAC80211=m
  CONFIG_MAC80211_MESH=y
  CONFIG_MAC80211_LEDS=y
 -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
  CONFIG_MTD=y
+ CONFIG_MTD_CMDLINE_PARTS=y
  CONFIG_MTD_REDBOOT_PARTS=y
  CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
- CONFIG_MTD_CMDLINE_PARTS=y

--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@@ -18,9 -15,12 +15,11 @@@ CONFIG_MACH_HMT=
  CONFIG_MACH_SMARTQ5=y
  CONFIG_MACH_SMARTQ7=y
  CONFIG_MACH_WLF_CRAGG_6410=y
- CONFIG_AEABI=y
  CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc
initrd=0x51000000,6M ramdisk_size=6144"
  CONFIG_VFP=y
 -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+ CONFIG_MODULES=y
+ CONFIG_MODULE_UNLOAD=y
+ # CONFIG_BLK_DEV_BSG is not set

Best regards,
Krzysztof
