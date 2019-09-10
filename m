Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62063C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211F3217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wiqoJdzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436927AbfIJQrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:47:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45254 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436758AbfIJQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3N//E0zcW7kRGKgSwYJTLOJfeK8dM1KlFJHe42qIo4U=; b=wiqoJdzGZHQ7dsTr38TSaB5P+
        cta9fRgOiJ/ZTzQP/DDDoMC/vEtYnu6PAXEwTVwDa0gstcCWZJls1EwitVBVZLNv+hhssniiGNquj
        70BDI3avTTV851UwbBZq7ch010410u0p2YJqBTSZ/PM6yzP0CTnoSCvGCI4qkeS0TsELT+DsINR1k
        MewdfyvFEfv0PUNRhZc7Hyv8GCVmPBE/lXRvAHHqmgFyRiyrpwZ5A2SF45JDW0eLdnH2GvJ4spaEn
        VejQayvONza3cFDRvB7aI3TEUfMtMCM9pJ1jXOKSwj3iBUY/knwaP8JL8RqnGoyUnGZLj6t5tsrEk
        JDPec4SgA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58608)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i7jI5-0001Dm-W7; Tue, 10 Sep 2019 17:46:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i7jI2-00038s-NO; Tue, 10 Sep 2019 17:46:50 +0100
Date:   Tue, 10 Sep 2019 17:46:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     tinywrkb <tinywrkb@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190910164650.GS13294@shell.armlinux.org.uk>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910155507.491230-1-tinywrkb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 06:55:07PM +0300, tinywrkb wrote:
> Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the

That statement is false, sorry.  All boards support 1G.

> Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.
> 
> Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
> genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.
> 
> This adds a phy node to the MicroSoM DTS and a 100Mb/s max-speed limit
> to the Cubox-i Solo/DualLite carrier DTS.
> 
> Signed-off-by: tinywrkb <tinywrkb@gmail.com>
> ---
> This patch fixes ethernet on my Cubox-i2-300-D which is limited to 100Mb/s,
> afaik due to the carrier board  magnetics, and was since commit 5502b218e001
> ("net: phy: use phy_resolve_aneg_linkmode in genphy_read_status")
> 
> The AR8035 PHY on the CPU module reports to the driver as 1GbE capable
> via MII_BSMR's BMSR_ESTATEN status bit, the auto-negotiation sets the
> speed at 1GbE while the carrier board can't support it.
> Same behavior with the generic phy_device and the at803x drivers.
> 
> While the PHY is on the CPU module board I added the max-speed limit to
> the cubox-i carrier DTS as I suspect that if the Solo or DualLite v1.3
> MicroSoM will be connected to a 1GbE capable carrier board then it would
> work correctly with 1GbE.
> 
> I can confirm that this commit doesn't break networking on the my
> Cubox-i4Pro Quad (i4P-300-D) with it's 1GbE capable carrier board, and
> was tested separately with the generic phy_device and at803x drivers.
> 
>  arch/arm/boot/dts/imx6dl-cubox-i.dts  | 4 ++++
>  arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> index 2b1b3e193f53..cfc82513c78c 100644
> --- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> @@ -49,3 +49,7 @@
>  	model = "SolidRun Cubox-i Solo/DualLite";
>  	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
>  };
> +
> +&ethphy {
> +	max-speed = <100>;
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> index 6d7f6b9035bc..969bc96c3f99 100644
> --- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> @@ -57,6 +57,15 @@
>  	phy-reset-duration = <2>;
>  	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> +	phy-handle = <&ethphy>;
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
>  };
>  
>  &iomuxc {
> -- 
> 2.23.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
