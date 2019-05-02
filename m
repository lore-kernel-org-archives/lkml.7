Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F1FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A81020651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEBTmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:42:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:42:09 -0400
Received: from [192.168.1.110] ([95.117.102.184]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mae7u-1gkTii3ric-00cBpa; Thu, 02 May 2019 21:41:07 +0200
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
To:     Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <20190430140416.4707-1-esben@geanix.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a535c7b6-54e0-ab58-7626-f7f631773c18@metux.net>
Date:   Thu, 2 May 2019 21:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190430140416.4707-1-esben@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:D8hPpdY1OO8vv+VyuKhIoYmLojZgGU5xSg88u+CaUVpeXhJslsS
 +d9h80w8M1im8D7a5Apj/sDDTxO/uOkQ/jpoeimd3QvYiO6WPH9GFtO6nl7cK/Ns9OlJ2Zq
 UZRArJu0K5asxPzWtSyVjnOabVMcehgOkd4tBa4c2EMn4BEzYqnluIE1YjT9NbJpco5D/IT
 SSipn++UZVsfObLkTBVPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCvAS6/VJzQ=:jz5k+6E5nMadVaIGSsP2DG
 +C5cM4GUtpxEoEqPVGSqqEkzT7awgDwgvDCEiC3YnX0e9Ls1imhj2SL6e0AimF3VOkQ9KWf/0
 oFs8ecL3zjcasyHYWOx4xn34eXc0TP4lvQlky1ektE2Odwq+iLztDAYdvgeRLm+Qh935+8lse
 QgT/1NEOE6HzBH6FHthck40w56hUSbI1sQbtsRyVhfl2LncCL6Ngr984yNvgSCrOJPLvGQtx5
 MSVONG7Sq388EDRRs/sby4VWmAWbULfJb2FL7PWGODk08sqhYShTgKl+NXmfzxBEyPJA99t5R
 lESC1VPxwXiajrsanvV+T3t+vHNh433O2pK0nwZ+K4r6RSPMWqEDiSUmyGcZasUPluXF9ZH1t
 ZAvZPAbRqHFBu1lR4z3J4xW7ITRLiFwX2VWsrw8PvIp5Wd8JNTDtoLMYzTDaRJLRTPllwiVuG
 BeOh/8KWhOHdYXOKqUW1O+8efDd2tKcMpZT7Sqpa+vFUs/qGMMmPZ7JkWO9GW6JKhoZ6Ew1BS
 Y5QnvTYyYinqJoyNGNS5Xb8ecaLHMBSbbdvh1IiaHgRwf9U5AyW5VnjWPBvxKtRo88P1F4tBG
 Zmg/Om4aUpNMb9D4Jz1WmZwyLvfeau0bkdXEBSltdGVxxo9Qh+t7wxfY0KGRrBZqU56aRDlu7
 a6GDrUt9LAwsYk3LTbEuE2lATvJKq3d8sBgHC+kjLoQccX3MUsFlAx5iDqQlcASjpyZRe4SZr
 jHoHuhd/cHbM5iMe5crmNNBzMFRoP7SgMPSx6pnpJS79jRLY+EaC0Kr+qM0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.19 16:04, Esben Haabendal wrote:
> Allow getting memory resource (mapbase or iobase) as well as irq from
> platform_device resources.
> 
> The UPF_DEV_RESOURCES flag must be set for devices where platform_device
> resources are to be used.  When not set, driver behaves as before.
> 
> This allows use of the serial8250 driver together with devices with
> resources added by platform_device_add_resources(), such as mfd child
> devices added with mfd_add_devices().

I like the idea (actually, quite the direction I'd like to go), but
unfortunately it's more compilicated than that.

Some drivers don't use these fields, eg. 8250 determines the mapsize
based on several factors, at the time of the mapping is done. That's
one of the things my patches shall clean up.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
