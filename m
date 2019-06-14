Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEDD20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfFNTdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:33:21 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44406 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfFNTdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:33:21 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbrwn-00078h-3Q; Fri, 14 Jun 2019 21:33:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: add display nodes for rk322x
Date:   Fri, 14 Jun 2019 21:33:12 +0200
Message-ID: <13456600.FWPkgmLa5g@phil>
In-Reply-To: <19cea8f7c279ef6efb12d1ec0822767d@risingedge.co.za>
References: <20190614165454.13743-1-heiko@sntech.de> <20190614174526.6F805217D6@mail.kernel.org> <19cea8f7c279ef6efb12d1ec0822767d@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. Juni 2019, 20:32:35 CEST schrieb Justin Swartz:
> On 2019-06-14 19:45, Stephen Boyd wrote:
> >> diff --git a/arch/arm/boot/dts/rk322x.dtsi 
> >> b/arch/arm/boot/dts/rk322x.dtsi
> >> index da102fff96a2..148f9b5157ea 100644
> >> --- a/arch/arm/boot/dts/rk322x.dtsi
> >> +++ b/arch/arm/boot/dts/rk322x.dtsi
> >> @@ -143,6 +143,11 @@
> >> #clock-cells = <0>;
> >> };
> >> 
> >> +       display_subsystem: display-subsystem {
> >> +               compatible = "rockchip,display-subsystem";
> >> +               ports = <&vop_out>;
> >> +       };
> >> +
> > 
> > What is this? It doesn't have a reg property so it looks like a virtual
> > device. Why is it in DT?
> 
> This is a virtual device.
> 
> I assumed it would be acceptable to it find in a device tree due to 
> binding documentation, 
> "Documentation/devicetree/bindings/display/rockchip/rockchip-drm.txt, 
> which states:
> 
> <quote>
> The Rockchip DRM master device is a virtual device needed to list all
> vop devices or other display interface nodes that comprise the
> graphics subsystem.
> </quote>
> 
> Without the "display_subsystem" device node, the HDMI PHY and 
> rockchipdrmfb frame buffer device are not initialized.
> 
> Perhaps I should have included this in my commit message? :)

As Justin said, that is very much common as the root of the components
that make up the drm device and pretty much common in a lot of devicetrees
for the last 5 years and longer ;-) .

Also gpio-keys also don't have a reg property ;-) .

Heiko 


