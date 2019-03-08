Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF12F2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552076004;
	bh=Kl6ykKFNy6KXvQDRDRHtKq5bkgkz91IES4bG/yPV1dA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rp8NLXgtiLXtvpUSsHekQe4Bgr2SLbTrWTTDzhtoQ8TQnC8axwJrL1qI/RIufVNfg
	 OAnOwCyMswUSWlW/M0WKRXrPmgfuvhv45dbq3U4isuoiM1MlnT2nwfYudnkMpu934f
	 ZUMd0uWvzS5h1tOm5MJxx6HQzjEJRoStFi0ejjY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfCHUNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfCHUNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:13:23 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D1C208E4;
        Fri,  8 Mar 2019 20:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552076002;
        bh=Kl6ykKFNy6KXvQDRDRHtKq5bkgkz91IES4bG/yPV1dA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHnUYWqSczerpzkdruqTX1wDYppjCdCNYsfbmiR109FWpCiU1MESHbz928XQNr4BN
         dVKKU4QvKmH3urbKP87+/0wpfghp37uuLW97Q/Ya79aCdirWI3NPuCWnUCVH901m+C
         zqpFmhGcBjcG0cBqSRypyl1lzWIBiKZ+w00gDlHM=
Received: by mail-qt1-f181.google.com with SMTP id v10so22645963qtp.8;
        Fri, 08 Mar 2019 12:13:22 -0800 (PST)
X-Gm-Message-State: APjAAAUIOGtTdLaV3Y7OQ5AreJg6Al/Hzm/5U56qpn3zWSCu9tO4Phz+
        Gzhf9Y0y/1WQ3mHDoMc+t5AGnITQo9h52QUwFg==
X-Google-Smtp-Source: APXvYqxTEfqBPgeP7VEV31F8ceEdpH+6danCQtvNV/N836pisk76aCukZ2zIo+tKMsH4rMFomRUSWHHXmZS7YdiJleg=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr16388598qtk.26.1552076001419;
 Fri, 08 Mar 2019 12:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20190308181202.11607-1-jagan@amarulasolutions.com>
In-Reply-To: <20190308181202.11607-1-jagan@amarulasolutions.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Mar 2019 14:13:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkyfd0Tvuxn_i-24gCReo=CNhtb65zG6xxqVYJasDZrQ@mail.gmail.com>
Message-ID: <CAL_JsqLkyfd0Tvuxn_i-24gCReo=CNhtb65zG6xxqVYJasDZrQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add Nanopi NEO4 initial support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Akash Gajjar <akash@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:12 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> FriendlyElec NanoPi NEO4 is known to be a revision 4 based
> NanoPi4 series of boards.
>
> Most of know peripherals are shared between Nanopi M4 vs NEO4, except
> - 1GB DDR3
> - USB Host ports
> - Missing DSI port
> - USB 2.0 Host with USB2PHY0 (no USB2PH1)
>
> Add support for it, by reusing existing rk3399-nanopi4.dtsi
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |  1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3399-nanopi-neo4.dts  | 50 +++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-neo4.dts

Reviewed-by: Rob Herring <robh@kernel.org>
