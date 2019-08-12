Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8303F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565637076;
	bh=zGXxYRVN5FWM3TPyMY1MjGb5RqFeMmER7+0sGSVq3TQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I4Dr5sDv2yetiFr2BT2BuEjtbiZC340F1YrorC5igkY9mw+xpVGXrsZhV77qkQ9qy
	 AC+PxWrkM9owBrDlcUgUoIeKM9ecrIZhod59GAkyT8Z+nvZBEjDrs6zG9Tmnihsdqw
	 5+GApaffcjZNpvdDIa6c1IzjsNV/mpTp0zmsoO08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfHLTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHLTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:11:15 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272392075B;
        Mon, 12 Aug 2019 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565637074;
        bh=zGXxYRVN5FWM3TPyMY1MjGb5RqFeMmER7+0sGSVq3TQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVvmCjxI+kPRG+nJNG4XkRKgxw3Tm4bRcUjOq2ildmS1J/5hfn/ngXlYQvqmCA5VO
         ftcD6Ez9A2x1hDGlfIwOKR7NScXJU1VmmojMEo32y7dszjMlrd7OiuUwAR3T4RVQCF
         JCEhrBCiHDtlJbdBgfbjP8owpJ79pzvpZTcSHDY8=
Received: by mail-qt1-f182.google.com with SMTP id e8so3435128qtp.7;
        Mon, 12 Aug 2019 12:11:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXgipOGHYBhCKevQ454Eo7KloUEpXTnSCZz2pz2euBXr3ckEHyL
        xNwkJXZI+ZiD5AGT1GGISKMBO5tdOzhojF0JUA==
X-Google-Smtp-Source: APXvYqy53vey6GYtzUmgKLgpgbiBPv+fXnb+bYVHJBev6DG0D+8uR8ZPe/236TEwvcCDWern5cLCJluC0mBiGyCQMWU=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr23691492qtq.136.1565637073361;
 Mon, 12 Aug 2019 12:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190811230015.28349-1-justin.swartz@risingedge.co.za>
In-Reply-To: <20190811230015.28349-1-justin.swartz@risingedge.co.za>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Aug 2019 13:11:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpNgVcM-Ou7BKWv0qxvkJx3=NuSHRTHonQ-XSz-NXb1w@mail.gmail.com>
Message-ID: <CAL_JsqKpNgVcM-Ou7BKWv0qxvkJx3=NuSHRTHonQ-XSz-NXb1w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: add device tree for Mecer Xtreme Mini S6
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 5:01 PM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> The Mecer Xtreme Mini S6 features a Rockchip RK3229 SoC,
> 1GB DDR3 RAM, 8GB eMMC, MicroSD port, 10/100Mbps Ethernet,
> Realtek 8723BS WLAN module, 2 x USB 2.0 ports, HDMI output,
> and S/PDIF output.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml          |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/rk3229-xms6.dts                  | 283 +++++++++++++++++++++
>  4 files changed, 291 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3229-xms6.dts

Reviewed-by: Rob Herring <robh@kernel.org>
