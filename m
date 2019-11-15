Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78896C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508AC2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 15:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKOPZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:25:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:40727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfKOPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:25:03 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnaY1-1i4JTM2kjN-00jbq0 for <linux-kernel@vger.kernel.org>; Fri, 15 Nov
 2019 16:25:01 +0100
Received: by mail-qk1-f182.google.com with SMTP id z23so8350973qkj.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 07:25:01 -0800 (PST)
X-Gm-Message-State: APjAAAWkokZkfy9OE/V7hu3FOi/PmCKzRhlhRHCakz8Ajr2KjH8mLO7H
        xHizmxPQyX/jYtRp5mJmJ8EwYr09c3XxEX9QQeQ=
X-Google-Smtp-Source: APXvYqy8dMVukKj8OZlWxjuWzWZMk1KwdHT2dkvcKDjQCzPCanUtmwdZnLb2X9QPsxj5Z4xTa9r/kW0G6wcFxWdz6Mk=
X-Received: by 2002:a37:58d:: with SMTP id 135mr13036950qkf.394.1573831500565;
 Fri, 15 Nov 2019 07:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20191112151642.680072-1-arnd@arndb.de> <20191112151642.680072-9-arnd@arndb.de>
In-Reply-To: <20191112151642.680072-9-arnd@arndb.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 16:24:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1FERLEZq3BFUJ9Hi6GP3rGKazJX9cbEQAw0O5tSB8H_Q@mail.gmail.com>
Message-ID: <CAK8P3a1FERLEZq3BFUJ9Hi6GP3rGKazJX9cbEQAw0O5tSB8H_Q@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
To:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NWnnIHjJxOEFtqbVUz601t7aVdy9BAfazy2cDuiJEhRMnnw4Xm4
 sOfqLo8z5+3GNmzGtKSvkyGRymL3SwPqSWKQJKBKvwCcXip1ZzDaGgqZrw0RV4T8hlvUi9n
 7BZA08RqwsG5usEn3a2QFiwabTx5gfyOzr2xdxHyyW8Hoiw3mI/7CE1zlwqBhcEQ9MPnfXT
 4ye6Drmo7L7JB0PTZNREA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:duvyq59C5E0=:UiwzFiwb2Os5azctIp4dk/
 7GT+nIWTgfNLScWQQnj2k54C9J6zWkCdGf3Lsyy1aWGEP9Y1aXlBE9oNEeTj2TZih7vp0MgLT
 Bod4ll27qWNgeNtPu35UnJESOSMKwaeJ+8Jh3jx3ysHxkf7lfcQ1vNQqmkbMnT++X0cpbHXLf
 EQGzFpF1wueJE9OarMUeVz/7cd/ZobCjJlnjCN7wb3PTDikiW5m5sZ00ajNhU6iiknFPZEWyh
 sdqkGHW7S88K2O00hQUXKRe1Bbeq2WHY6OLE/e6TyJtZZ5O91jBpSkzu8q7whwiWwIqoYcAqZ
 z1vMpxT8b/i4X8K+sKaxFO2TBJpgnRrrVPeR3oQNpskHRPitVIURamjNKb3u9YA6Ih0skxwAg
 UZBc01PGCVbNDjhzv48Mh2bdVo94oMLU8YZ6hln0E6Gp/v8j/NVKb4LKME9NCBlA4jQ99fRLx
 U1xFmoPrvgOZNIxUlNIHgnxKk95NM7gvYvWVfXWpKJweRAqzLXjTNDtYAXSpOsj0DHqbCVIU0
 FgScQdU/xKcHZ74O+C/bMfNChJ5joxdPHeu9x9eOpRfX6NxKiPH6SgljbOlmxL2+tNIgO3Oao
 4xOEMshBIAqW1VykPhnNtxrlJFnmhHOGxqRzEs9sniG/+BUAOgd33ixqBpZpJwXZVAzTVAdPp
 AJLwifFf4TdszxPOpHyIA5/CUL8H2t9bOFPr1V799BIBbmmrxARXptMQVPp5tatq0Mu5LVrFm
 9FSCt04bHAP1GfnXzbR3gY8yB1HPvxJ5ykqXuFNB98lQedc8zipSn3uhjtZakjob9I9B5WWNf
 RwJ1TeZti2LEwD7Zw48mSflHk0XCiP7ev936GpRuKDsgHk9VrsXjtP9WVV2nVpkA38yT+s9XY
 CE3rFwXc2JHpGtmsj5Cg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 4:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Co-developed-with: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/sound/asound.h | 106 ++++++++++++++++++++++++++++++++----
>  sound/core/pcm_compat.c     |  30 +++++-----
>  sound/core/pcm_lib.c        |  10 ++--
>  sound/core/pcm_native.c     |  39 ++++++++-----
>  4 files changed, 143 insertions(+), 42 deletions(-)

I found one more use of 'struct timespec' remaining in there, and have amended
this patch with a small change now to hide that as well.

       Arnd

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index c5d8e7f134d0..e6a958b8aff1 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -502,7 +502,11 @@ struct snd_pcm_status {
 #define __snd_pcm_mmap_status64                snd_pcm_mmap_status
 #define __snd_pcm_mmap_control64       snd_pcm_mmap_control
 #define __snd_pcm_sync_ptr64           snd_pcm_sync_ptr
+#ifdef __KERNEL__
+#define __snd_timespec64               __kernel_timespec
+#else
 #define __snd_timespec64               timespec
+#endif
 struct __snd_timespec {
        __s32 tv_sec;
        __s32 tv_nsec;
