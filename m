Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616B2C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F74A21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfIYJmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:42:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIYJmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:42:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 32CE828E2F3
Subject: Re: [PATCH] drm/rockchip: Add AFBC support
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
References: <20190923122014.18229-1-andrzej.p@collabora.com>
 <20190925093913.z4vduybwcokn3awi@DESKTOP-E1NTVVP.localdomain>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <e5fdc7ff-6171-6190-1bca-9f517f69b03c@collabora.com>
Date:   Wed, 25 Sep 2019 11:42:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925093913.z4vduybwcokn3awi@DESKTOP-E1NTVVP.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

W dniu 25.09.2019 o 11:39, Brian Starkey pisze:
> Hi Andrzej,
> 
> Thanks for the patch, it's nice to see another AFBC implementation
> coming in.
> 

I did a false start, though. But the work is in progress. Thanks for the review, 
anyway.

> For future versions, could you please Cc ayan.halder@arm.com? It would
> have been nice to have someone @arm.com on patches which use/impact
> Arm modifiers. Sadly I don't know how to make get_maintainer.pl help

Of course.

Andrzej
