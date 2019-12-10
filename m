Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2047C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD3207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zQ7/HkMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLJQUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:20:24 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45018 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfLJQUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c6CPgm0IhvA3nyR/Q2z35omEWncDMQnrCCrPzyQjsqw=; b=zQ7/HkMyx7E/bQvQ8wnGiAEg69
        wrwuBNQHvjITFooDPHqXzjP+oYp8DjZlT8EbI6jDKG02xyQTeqeW4P2UMdJpe4ajwHur01GjPAu8P
        N5sULJJQTlq8XNVqXTSzm1RXsVpcuKum6ZnFH+oeLhI31klnpZfgG3VW/6sI72DN7mig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ieiF8-0005FM-Vd; Tue, 10 Dec 2019 17:20:10 +0100
Date:   Tue, 10 Dec 2019 17:20:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Landen Chao <landen.chao@mediatek.com>
Cc:     f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        davem@davemloft.net, sean.wang@mediatek.com, opensource@vdorst.com,
        frank-w@public-files.de
Subject: Re: [PATCH net-next 3/6] dt-bindings: net: dsa: add new MT7531
 binding to support MT7531
Message-ID: <20191210162010.GB27714@lunn.ch>
References: <cover.1575914275.git.landen.chao@mediatek.com>
 <1c382fd916b66bfe3ce8ef18c12f954dbcbddbbc.1575914275.git.landen.chao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c382fd916b66bfe3ce8ef18c12f954dbcbddbbc.1575914275.git.landen.chao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Example 4:
> +
> +&eth {
> +	gmac0: mac@0 {
> +		compatible = "mediatek,eth-mac";
> +		reg = <0>;
> +		phy-mode = "2500base-x";
> +
> +		fixed-link {
> +			speed = <1000>;
> +			full-duplex;
> +			pause;
> +		};
> +	};

2500Base-X, but fixed link speed 1000?

> +				port@6 {
> +					reg = <6>;
> +					label = "cpu";
> +					ethernet = <&gmac0>;
> +					phy-mode = "2500base-x";
> +
> +					fixed-link {
> +						speed = <1000>;
> +						full-duplex;
> +						pause;
> +					};

Same here!

     Andrew
