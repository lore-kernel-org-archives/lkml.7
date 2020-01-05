Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89335C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBEC20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgAEUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 15:24:54 -0500
Received: from muru.com ([72.249.23.125]:50196 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAEUYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 15:24:54 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 53A9A80E2;
        Sun,  5 Jan 2020 20:25:33 +0000 (UTC)
Date:   Sun, 5 Jan 2020 12:24:49 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        agx@sigxcpu.org, lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        tomi.valkeinen@ti.com, jjhiblot@ti.com
Subject: Re: LED backlight on Droid 4 and others
Message-ID: <20200105202449.GC5885@atomide.com>
References: <20200105183202.GA17784@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105183202.GA17784@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [200105 18:32]:
> Hi!
> 
> It would be good to get LED backlight to work in clean way for 5.6
> kernel.

I agree, this is badly needed for many devices.

> [If you have an idea what else is needed, it would be welcome; it
> works for me in development tree but not in tree I'd like to
> upstream.]

I have some version of these patches working with modified dts in my
droid4-pending-v5.4 branch git branch, maybe try to diff against that.

Regards,

Tony


