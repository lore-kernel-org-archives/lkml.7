Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DBBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CED720665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfF1JaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:30:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51920 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1JaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:30:00 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hgnCh-0006xe-1g
        for linux-kernel@vger.kernel.org; Fri, 28 Jun 2019 09:29:59 +0000
Received: by mail-pl1-f199.google.com with SMTP id t2so3204559plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JpLW+K7OayxQr1MZdjTeCDDOvE1m5y/oiZWdTifSQTI=;
        b=rXi8FW4+nVUSwg3GgZcQolngNK71mthrUzmU+DFR1OJ8GqZZb7gzFMY8bKLLVlupYk
         qKePwDlTDHIkUDF77EqFvFnLSkigE5TD9nRCTYoL4F6Yt0CPnK6fjstmPjfIB71rYm72
         gSl/KXKIKb7vu9peFiY/PupsvSbEarRaJhd3pCEC6jCjQUrDbcQINiZW3e8Cl/hJJXyP
         SatdCVFyNbx43+P10W0s5U/bZH/gZbvHAHN9Hm3XRIpZyzz6kHA1bHkulCYBtIToUg8X
         FexeugJTO2fmj/itzUzEtCPT70bAfxuTYmGTq2JBlQX1rHQNh/BlMJHhKydPI89Ib0pN
         ZsDA==
X-Gm-Message-State: APjAAAVfHXuRFXNsC0BA2rwJQDW5UxoBKkCfFJkSEp95R8GSm+IUuT+g
        dJ082GZ2GuYa+EzpSQ8Va2aFpawSRKfd4M1HA5ZOIeykvWGmn9htXUb0nV3x+Gsqr14F4bN8hlA
        cNXH84HGGvylrnDyQe4Y5lvFiaOvZ/SFdIMwYoRrQ1Q==
X-Received: by 2002:a63:f510:: with SMTP id w16mr8533928pgh.0.1561714197652;
        Fri, 28 Jun 2019 02:29:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYH4t/nUWH2KIkPbH0ff+IhP9Mn6sDdMJfBw1QPf53pEGNjrIVHvUMiEdDczOlcSjtmdb4Pw==
X-Received: by 2002:a63:f510:: with SMTP id w16mr8533897pgh.0.1561714197221;
        Fri, 28 Jun 2019 02:29:57 -0700 (PDT)
Received: from 2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net (2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net. [2001:b011:380f:3511:c09f:cbfd:7c09:2630])
        by smtp.gmail.com with ESMTPSA id y19sm1671911pfe.150.2019.06.28.02.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:29:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [alsa-devel] ca0132 audio in Ubuntu 19.04 only after Windows 10
 started, missing ctefx-r3di.bin
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hh88a6pig.wl-tiwai@suse.de>
Date:   Fri, 28 Jun 2019 17:29:54 +0800
Cc:     conmanx360@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <4E6239D9-3A70-4D66-9F88-453EB268DA2A@canonical.com>
References: <156097935391.32250.14918304155094222078.malonedeb@chaenomeles.canonical.com>
 <156113479576.29306.8491703251507627705.malone@gac.canonical.com>
 <B0FDD5B2-EA6F-4ABC-8BF5-6231AA31EB70@canonical.com>
 <s5hh88a6pig.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 17:13, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 28 Jun 2019 08:35:51 +0200,
> Kai-Heng Feng wrote:
>> Hi Connor,
>>
>> The bug was filed at Launchpad [1], I think the most notable error is
>> [    3.768667] snd_hda_intel 0000:00:1f.3: Direct firmware load for
>> ctefx-r3di.bin failed with error -2
>>
>> The firmware is indeed listed in patch_ca0132.c, but looks like
>> there’s no  corresponding file in linux-firmware.
>
> FYI, the firmware is found in alsa-firmware git repo for now.

Got it, thanks for the info. Didn’t know there’s alsa-firmware repo.

Kai-Heng

>
>
> Takashi


