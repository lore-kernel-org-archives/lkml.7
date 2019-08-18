Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B3C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5566120B7C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHRP3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:29:14 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:43854 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:29:14 -0400
Received: from [192.168.0.253] (rev-81-92-251-195.radiolan.sk [81.92.251.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id D8DD47A03D5;
        Sun, 18 Aug 2019 17:29:12 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: nouveau: System crashes with NVIDIA GeForce 8600 GT
Date:   Sun, 18 Aug 2019 17:27:03 +0200
User-Agent: KMail/1.9.10
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190817125033.p3vdkq3xzz45aidz@alex-chromebook>
In-Reply-To: <20190817125033.p3vdkq3xzz45aidz@alex-chromebook>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201908181727.04076.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 August 2019 14:50:33 Alex Dewar wrote:
> Hi all,
>
> I'm getting frequent system crashes (every few hours or so) and it seems
> that the nouveau driver is causing the issue (dmesg output below). I see it
> with both v5.2.8 and the v4.19 LTS kernel. Sometimes the system
> completely freezes and sometimes seemingly just the nouveau driver goes
> down. The screen freezes and colours stream across it. Often after I
> reboot the BIOS logo is mangled too until the first modeset. The crash
> seems to be happening in nv50_fb_intr() in nv50.c.
>
> I'm not sure if this is related, but the system now often freezes on
> suspend or resume since I switched from using the old (recently
> abandoned) proprietry NVIDIA drivers, again both with 5.2 and 4.19
> kernels. Blacklisting the nouveau driver doesn't seem to fix it however,
> though I guess the graphics card could still be causing issues in some
> other way? I never had problems with suspend and resume before.
>
> Any suggestions about how I could debug this further?

Is it really a software problem (does it still work fine with proprietary 
driver)?
These nVidia chips are known to fail and corrupt BIOS logo suggests that.

-- 
Ondrej Zary
