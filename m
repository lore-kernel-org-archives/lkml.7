Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A542067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vgjP1hhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfDYWkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:40:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44878 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYWkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ANlhMA8OSLhl7BEkvSnuas7Ukh7w7tUAqQmlhqFrG+c=; b=vgjP1hhAhD9DL9yh6rElmRBHvd
        QRQuKfUjLiwu19KPtMFUus1cIwHMdZu2vPuyiFVcYRM5XlAbzRozpssrAVYhb9SmJEhGT6NAEMCfr
        4VHjhukG53PhBbAOQZrw1mMM5fO/jP966YRUvojN8Bog14a3uFzPAGwjDCJtEYgFuBxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJn2T-000263-Nv; Fri, 26 Apr 2019 00:40:21 +0200
Date:   Fri, 26 Apr 2019 00:40:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
Subject: Re: [RFC PATCH v3 net-next 06/11] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Message-ID: <20190425224021.GA4041@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +Required Sub-nodes:
> +- ports	: contains CPSW external ports descriptions
> +	Required properties:
> +	- #address-cells : Must be 1
> +	- #size-cells : Must be 0
> +	- reg : CPSW port number. Should be 1 or 2
> +	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
> +	- phy-mode : operation mode of the PHY interface [1]
> +	- phy-handle : phandle to a PHY on an MDIO bus [1]


> +		cpsw_port1: port@1 {
> +			reg = <1>;
> +			ti,label = "port1";
> +			/* Filled in by U-Boot */
> +			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 1>;

Hi Grygorii

phy-mode and phy-handle are required, but missing from your example.

Otherwise, this looks like a reasonable binding.

	   Andrew
