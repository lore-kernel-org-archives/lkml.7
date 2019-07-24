Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E28C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAA22ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4xIq3yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfGXOSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:18:07 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44183 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfGXOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:18:07 -0400
Received: by mail-qt1-f175.google.com with SMTP id 44so14604446qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4Z7NceRYmsd4mWj9JDUNB9v0QmsmFhuBmenBnT38Iog=;
        b=m4xIq3yRVJW0kxd1xSkW/21rcobDF5TddzNVTZ1fwY9hughmP+OlYTaeKcDTy67WG6
         DBlsIAr/tKJJ8gEfc/jFgXOiT36nCdxnHjD8ugTQNW2aCHNPmdnGmU+cpNpNRQ2xNSB7
         IQFRtXdNHd8iAVAud2/g1ewOOXj8Im3LJCSwtL6Mx8xoXYR4ikG6cAMzdXfhHQNv8pbs
         AYbkIgxmlj9jplcT6noutzZUscT+QOH1S7G2SWpEwmTZlRjWcUpielJHDBZfPh60pVvK
         Q48+IDqr+r3VYCx/+UTTiVSAZj3kiyvkRIBf3Zoftyp1eLKROPVH5dT0S0hnqA45JkcA
         3/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4Z7NceRYmsd4mWj9JDUNB9v0QmsmFhuBmenBnT38Iog=;
        b=iWECEHFgqOsPE2LBkT9fdspbbMwRx1enH1NvXV+XVS4AxQy8l4IkiaX9POboOl1HBM
         G94MFx5wFTuovoDkq6QL7Fm6ZvH58C1832V2zxqYSTTuYdYGEH5SmmJjGk18oT2UjNNY
         aQycRx09EaRuQjZJEHKt+MURSkmzjrSNAS/PvGuLP4R6jdbSa03g/1QYov/I2NGLATR2
         GfoFVSj2bm9mMaRWS9iA1FEm5V/+q33RdeBOqAEUIzcXvQgfCsYmbtpewPpL4AMPnLvx
         sxrP6xsBocCgelcvCcH96rS1VAHBA5XKCqG1DKUVuLa2Gpycv3t5C9uOX6v1Dzno79IW
         MNUQ==
X-Gm-Message-State: APjAAAVq/3ZhZmMr7dVR0PholFcEuitZXiWcEK3VAU6SrXSasVw6ZNdc
        ltNNY1llF0bzRorYC5ra8ox6Kho9YbVNOrrzNB6D50js
X-Google-Smtp-Source: APXvYqx0fQpMpc3+dt/dgtbDwqdkAWPE94gAyxxd02MLjxJqiq/qwdpcg/T+wVNem3jaqcUEpLzjD673gxGuDyqGPdg=
X-Received: by 2002:a0c:d251:: with SMTP id o17mr60155947qvh.109.1563977885709;
 Wed, 24 Jul 2019 07:18:05 -0700 (PDT)
MIME-Version: 1.0
From:   Gilberto Nunes <gilberto.nunes32@gmail.com>
Date:   Wed, 24 Jul 2019 11:17:29 -0300
Message-ID: <CAOKSTBs-cHMr7xbJVVUjZ9C3__bY6jZU-_TZ0RmMRMJ3dBk3PA@mail.gmail.com>
Subject: AMD Drivers
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I am usging Linux mint here 19.1.
My laptop has the following configuration:

CPU - AMD A12-9720P RADEON R7, 12 COMPUTE CORES 4C+8G
GPU - Wani [Radeon R5/R6/R7 Graphics] (amdgpu)
Network Interface card:
01:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)

When I install kernel 4.18.x or 5.x, the network doesn't work anymore...
I can loaded the modulo r8169 andr8168.
I saw enp1s0f1 as well but there's no link at all!
Even when I fixed the IP none link!
I cannot ping the network gateway or any other IP inside LAN!
Right now, I booted my laptop with kernel
Linux version 5.2.2-050202-generic (kernel@kathleen) (gcc version
9.1.0 (Ubuntu 9.1.0-9ubuntu2)) #201907231250 SMP Tue Jul 23 12:53:21
UTC 2019

The system boot slowly, and I have a SSD Samsung, which in kernel
4.15, boot quickly.
And there's many errors in dmesg command, like you can see in this pastbin

https://paste.ubuntu.com/p/YhbjnzYYYh/

The system get stuck for 5 seconds and then the X login screen appears!
Also, I get this message:
dmesg | grep stuck
[   40.231513] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:1:7]
[   68.231511] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kworker/0:1:7]
[  104.231513] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:0:5]
[  176.239514] watchdog: BUG: soft lockup - CPU#3 stuck for 23s!
[kworker/3:3:593]

Which make the system freeze for a while and then return to normal!
Oh! By the way, the network card r8169 are work wonderful!



Thanks a lot.
---
Gilberto Nunes Ferreira

(47) 3025-5907
(47) 99676-7530 - Whatsapp / Telegram

Skype: gilberto.nunes36
