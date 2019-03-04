Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F0E2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfCDWKU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:10:20 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:10:20 -0500
Received: from oxbaltgw04.schlund.de ([172.19.246.10]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjOl-1hPEyC3K1r-00lH1a; Mon, 04 Mar 2019 23:10:07 +0100
Date:   Mon, 4 Mar 2019 23:10:05 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Helen Koike <helen.koike@collabora.com>, eric@anholt.net
Cc:     devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, lkundrak@v3.sk,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Message-ID: <149506090.292981.1551737405671@email.ionos.de>
In-Reply-To: <20190304214837.9045-1-helen.koike@collabora.com>
References: <20190304214837.9045-1-helen.koike@collabora.com>
Subject: Re: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd gpio pull
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev51
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:WeKVHahX1TKdqxf2ty4weRgmtHe7E0N1oLFDqbPrHL2AipL8HO1
 +vFgl+jhLxyJVHJHrryUpwxy1wT9czmxItQQBqwa/B/a33H3jPpCSUhiggz8solxM+YztFK
 eepK0Mnku73bh0+z8Q4tB0Kt9pn1cgg2tXQJXbxec3Erf98yXB/94dhF+50BoTa+IMiJPfe
 POjvhCl9D3aAR3HjTd6Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mgh8TntDZkI=:wuaTUn7fEk25FM/XrCFVP8
 xAItnyUoBDtSELP6bOS1t37ocaGq/iV1uZIEpdI5vos8s/14S6fcZOCYI8SQjRtIr0hT5kovg
 uWWy6zS33DW8BRpP1FPke3zcjF2blUGjhP+TNfHya+woI91F/lud9n8UcwyDJhi9UGo8JXG5m
 Y2KVpP7mVjOyJub4Wp9V2eiERBq8K44sGCfdBX9qwAP1qQQZhOcV0cn6VXJoIe72WpR3Dq8zw
 qOCszqTI2h8R9ZTUYw8HWxEN6ahrz3mwV9rmgQs45Xe9YP/mush+PWTy0KXw2NPYT0OeGWXZi
 mnUGj+8Pup0PUbReB4OhBANnX5Lbk2/qR68gULQhFbhijp05HXhlG4aiB0lEa4KHXmuxjROCo
 VZmBNCu5j+d96PZOy5kePa2fGemWABdyhsWN+lqr3lI9cfXN6NgrGrqXAdk3AL4A03jQojyf6
 t82UrlkHunjm9BYooEl/boR/ShDU+mYSN8iGYhoeV6tsafGa/5TOCNEG6QcT656pAXroOlOqU
 fkUHHl5I0yRFgIaSXfBj9upJB8IxJzS3qK3A3sZt8WofmaYtEPPX6uMhcCg46gZZF95dccps9
 BMWlyNauKwLOBT4UJQKsoLuilJMGskrjDWZ3oXVzV02eRmpu8hxOtXAfS+5eTL3Ru3I0PCHUA
 +1gea3Lv1p8WDGqvYX3bhrF0fXy+osG/so4d53bRPol2gyXra1ycgDJX6G430WL4KA1JnE1D2
 E6sIxjv6WyCFCsGPxGOzxSBbO8LAgeUhvcFpq2Qw8/0vttnSFW1YTug/H+U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since this patch change only one board, the subject could be more specific:

ARM: dts: bcm2835-rpi-b-rev2: Fix hdmi hpd gpio pull

> Helen Koike <helen.koike@collabora.com> hat am 4. März 2019 um 22:48 geschrieben:
> 
> 
> Raspberry pi board model B revison 2 have the hot plug detector gpio
> active high (and not low as it was in the dts).
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>

I think we should add a Fixes tag here, so it could be backported.

@Eric: Feel free to take V2

Thanks
