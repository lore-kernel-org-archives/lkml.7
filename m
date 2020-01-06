Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE2C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B7207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgAFXTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:19:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37614 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgAFXTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:19:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id AE4212911A6
Subject: Re: next/master bisection: boot on sun7i-a20-olinuxino-lime2
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        tomeu.vizoso@collabora.com, mgalka@collabora.com,
        Alexandre Torgue <alexandre.torgue@st.com>, broonie@kernel.org
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <5e13b89c.1c69fb81.c8c2e.1609@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <499551d9-5f65-70e7-91af-3b7d57118cfc@collabora.com>
Date:   Mon, 6 Jan 2020 23:19:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5e13b89c.1c69fb81.c8c2e.1609@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2020 22:45, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: boot on sun7i-a20-olinuxino-lime2
> 
> Summary:
>   Start:      9eb1b48ca4ce Add linux-next specific files for 20200106
>   Details:    https://kernelci.org/boot/id/5e12e663019cf4926197312f
>   Plain log:  https://storage.kernelci.org//next/master/next-20200106/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-baylibre/boot-sun7i-a20-olinuxino-lime2.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20200106/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-8/lab-baylibre/boot-sun7i-a20-olinuxino-lime2.html
>   Result:     5253fe05bb47 phy: core: Add consumer device link support

This report should have been sent only once, it looks like a
corner case bug.  Taking a look now, sorry for the noise.

Guillaume
