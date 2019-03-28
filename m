Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C5F2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553787762;
	bh=7W1yljRBvSIndmqSMX0YUQpbdeqZmA4x9L/HJMuag/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bS2CO7psv/DwyEzayFeycySFHd4RMxMQ9AfnDQbB7GkKE06ZAPYHspr5GU3Q6qARq
	 pE/Fjz/qtiAOpAiqLBu+NX5Tah843099bX+pGe0D3PUTjNtPwfG0TEyvUBEpmEdcMF
	 9BS7JbD9Y6ke2qgmdfaVGD/4+3/pIoCdcgTvMgFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfC1Pml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:42:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44290 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfC1Pml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:42:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so4228605otl.11;
        Thu, 28 Mar 2019 08:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4az+46DIMfUB/SNTIsMCQFGc8Fnlowh1OrOWXEomb4w=;
        b=VrXm1/64sjT25/Gg8RUJUD8av7Y8kN1OL6dNMfo/j4X9R7Y3aQo/NXFnitB1UncBAC
         p73EVG7OpvzBJ5+hNeH0BZVTMcluvJk8pjpwu3B0A8w9h/eC660Rk0ZvwLpMdft2AxPD
         eBhnPnu001DXRZ3D3MxzwA9NxKYB1gNVPkgL+8HV3lBmNjcKxYYM2yOMz7F551AmZIAB
         WFIRae2e0uXz5IW+hXvaElvfewhSzsrAcymlNodqcpg2PrlfGZsSBzdKFYhTW8VYb+e8
         ChlsxBh/F2mojeII0hNoSuYTlDtMYCBIl1QbIarz00AP/jIxZJkX1bkIkjJXqfMBbG0R
         5h6Q==
X-Gm-Message-State: APjAAAWl8nOxGg1nS9zQ/MjlibrJuWl+hT7rQwqBfVvJmiayDTwmET/S
        ojcjrXxk+RJHfKNz40HNFA==
X-Google-Smtp-Source: APXvYqxWekuyLQ5qCLs1b3xTvC3fEzjlccVvX52gn2dE+rZh0h2hIDf+mvkrEYzX+Y/EukoEhf+F9A==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr4973717oto.130.1553787760337;
        Thu, 28 Mar 2019 08:42:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm9298397oic.11.2019.03.28.08.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 08:42:39 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:42:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, neil@brown.name
Subject: Re: [PATCH 2/2] dt-bindings: phy: Add binding for Mediatek MT7621
 PCIe PHY
Message-ID: <20190328154238.GA20934@bogus>
References: <20190314132210.654-1-sergio.paracuellos@gmail.com>
 <20190314132210.654-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314132210.654-3-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:22:10PM +0100, Sergio Paracuellos wrote:
> Add bindings to describe Mediatek MT7621 PCIe PHY.

Binding should come before the driver.

> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/phy/mediatek,mt7621-pci-phy.txt  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> new file mode 100644
> index 000000000000..8addedbe815e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> @@ -0,0 +1,54 @@
> +Mediatek Mt7621 PCIe PHY
> +
> +Required properties:
> +- compatible: must be "mediatek,mt7621-pci-phy"
> +- reg: base address and length of the PCIe PHY block
> +- #address-cells: must be 1
> +- #size-cells: must be 0
> +
> +Each PCIe PHY should be represented by a child node
> +
> +Required properties For the child node:
> +- reg: the PHY ID
> +0 - PCIe RC 0
> +1 - PCIe RC 1
> +- #phy-cells: must be 0
> +
> +Example:
> +	pcie0_phy: pcie-phy@1e149000 {
> +		compatible = "mediatek,mt7621-pci-phy";
> +		reg = <0x1e149000 0x0700>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pcie0_port: pcie-phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +		};
> +
> +		pcie1_port: pcie-phy@1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +		};

If each phy port doesn't have its own resources, then you don't need 
child nodes. Just set #phy-cells to 1.

> +	};
> +
> +	pcie1_phy: pcie-phy@1e14a000 {
> +		compatible = "mediatek,mt7621-pci-phy";
> +		reg = <0x1e14a000 0x0700>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pcie2_port: pcie-phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +		};
> +	};
> +
> +	/* users of the PCIe phy */
> +
> +	pcie: pcie@1e140000 {
> +		...
> +		...
> +		phys = <&pcie0_port>, <&pcie1_port>, <&pcie2_port>;
> +		phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
> +	};
> -- 
> 2.19.1
> 
