Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7ABC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2762467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLTLhc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:37:32 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47840 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLTLhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:37:32 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iiGb0-0000CY-Vd; Fri, 20 Dec 2019 12:37:27 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH RESEND 1/2] dt-bindings: phy: drop #clock-cells from rockchip,px30-dsi-dphy
Date:   Fri, 20 Dec 2019 12:37:26 +0100
Message-ID: <3795174.JdKOkfR0EK@diego>
In-Reply-To: <45c59145-5705-90f9-ff0e-c84cf8d17e8b@ti.com>
References: <20191216122448.27867-1-heiko@sntech.de> <12525836.FhlgEYrHGb@diego> <45c59145-5705-90f9-ff0e-c84cf8d17e8b@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Am Freitag, 20. Dezember 2019, 12:21:28 CET schrieb Kishon Vijay Abraham I:
> 
> On 16/12/19 11:31 pm, Heiko Stübner wrote:
> > Hi Rob,
> > 
> > Am Montag, 16. Dezember 2019, 18:56:15 CET schrieb Rob Herring:
> >> On Mon, 16 Dec 2019 13:24:47 +0100, Heiko Stuebner wrote:
> >>> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> >>>
> >>> Further review of the dsi components for the px30 revealed that the
> >>> phy shouldn't expose the pll as clock but instead handle settings
> >>> via phy parameters.
> >>>
> >>> As the phy binding is new and not used anywhere yet, just drop them
> >>> so they don't get used.
> >>>
> >>> Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
> >>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> >>> ---
> >>> Hi Kishon,
> >>>
> >>> maybe suitable as a fix for 5.5-rc?
> >>>
> >>> Thanks
> >>> Heiko
> >>>
> >>>  .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      | 5 -----
> >>>  1 file changed, 5 deletions(-)
> >>>
> >>
> >> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> >> there's no need to repost patches *only* to add the tags. The upstream
> >> maintainer will do that for acks received on the version they apply.
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> > 
> > sorry about that. The original response somehow did not thread correctly
> > in my mail client, probably some fault on my side, so I've only found your
> > mail just now by digging hard.
> > 
> > @Kishon, the original mail already got an
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> merged now, Thanks!

thanks ... just to make sure, did you also see the driver changes in patch2?
As I don't see them in either of your branches :-)

Thanks
Heiko


