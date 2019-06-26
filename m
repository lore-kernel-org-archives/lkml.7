Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED5C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00D120665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFZGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:50:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfFZGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:50:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 2DC2D285638
Subject: Re: [PATCH 0/2] Associate ddc adapters with connectors
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Emil Velikov <emil.velikov@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, dri-devel@lists.freedesktop.org,
        kernel@collabora.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
References: <cover.1561452052.git.andrzej.p@collabora.com>
 <20190625100351.52ddptvb2gizaepi@shell.armlinux.org.uk>
 <817ccfba-754c-6a28-8d75-63f70605fd43@collabora.com>
 <20190625133639.GA16031@arch-x1c3>
 <20190625140755.GT12905@phenom.ffwll.local>
 <20190625141032.5jiy2oekb3olaejd@shell.armlinux.org.uk>
 <20190625142031.GV12905@phenom.ffwll.local>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <3fb19371-db7d-f9dc-31a7-1ccd126f6784@collabora.com>
Date:   Wed, 26 Jun 2019 08:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625142031.GV12905@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 25.06.2019 o 16:20, Daniel Vetter pisze:
> On Tue, Jun 25, 2019 at 03:10:32PM +0100, Russell King - ARM Linux admin wrote:
>> On Tue, Jun 25, 2019 at 04:07:55PM +0200, Daniel Vetter wrote:
>>> Otherwise I like this. Biggest problem I'm seeing here is rolling this out
>>> everywhere, this is a lot of work. And without widespread adoptions it's
>>> not terribly useful for userspace.
>>
>> There will be cases where it's not possible, because the I2C bus is
>> hidden behind a chip that doesn't give you direct access to the DDC
>> bus.
> 
> Oh sure, plus lots of connectors where there's just not ddc bus at all.
> But if we only roll this out for a handful of drivers it's also not great,
> that's what I meant. Looking at
> 
> $ git grep drm_do_get_edid
> 
> there's only very few drivers where the ddc bus is hidden. There's a lot
> more where it's not, and I think a big series to tackle those would serve
> extremely well to make a case for this sysfs link.
> -Daniel
> 

I will respond with a v3 then, including as many drivers as possible.
Those will be compile-tested only, though.

Andrzej
