Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75147C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A42320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJJVX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:23:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33688 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:23:55 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIfuX-000786-Im; Thu, 10 Oct 2019 23:23:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: rockchip: Use interpolated brightness tables for veyron
Date:   Thu, 10 Oct 2019 23:23:48 +0200
Message-ID: <3947291.Wl2KGcTfji@phil>
In-Reply-To: <20191003094137.v2.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
References: <20191003094137.v2.1.Ic9fd698810ea569c465350154da40b85d24f805b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 3. Oktober 2019, 18:41:52 CEST schrieb Matthias Kaehlcke:
> Use interpolated brightness tables (added by commit 573fe6d1c25
> ("backlight: pwm_bl: Linear interpolation between
> brightness-levels") for veyron, instead of specifying every single
> step. Some devices/panels have intervals that are smaller than
> the specified 'num-interpolated-steps', the driver interprets
> these intervals as a single step.
> 
> Another option would be to switch to a perceptual brightness curve
> (CIE 1931), with the caveat that it would change the behavior of
> the backlight. Also the concept of a minimum brightness level is
> currently not supported for CIE 1931 curves.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.5

Thanks
Heiko


