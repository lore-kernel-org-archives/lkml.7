Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF20C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1543208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qK+LRlMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfFQPVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:21:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33450 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfFQPVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VPiSqz9zDu3TLiKvAA5/dkPAGEn9oo1+2IUb/J317IE=; b=qK+LRlMGfClzYjXPeqWOi3Zjfj
        Ie29SPyaUw3NOAG13kHWwOttcZ0+M4zajQoSmwd71JmrUurUE8QVuYaALkQl5ytGXN7Okyh5km8Xm
        lNmCSJieabeNw5jsmf0KslC8K03uB3SJUWDVUseGkZyf9kkjSOHUUHOml/1BF61ve6wg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hctRe-000061-9d; Mon, 17 Jun 2019 17:21:18 +0200
Date:   Mon, 17 Jun 2019 17:21:18 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        f.fainelli@gmail.com, netdev@vger.kernel.org, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, rafalc@cadence.com,
        aniljoy@cadence.com, piotrs@cadence.com
Subject: Re: [PATCH 6/6] net: macb: parameter added to cadence ethernet
 controller DT binding
Message-ID: <20190617152118.GJ25211@lunn.ch>
References: <1560642512-28765-1-git-send-email-pthombar@cadence.com>
 <1560642579-29803-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560642579-29803-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 12:49:39AM +0100, Parshuram Thombare wrote:
> New parameters added to Cadence ethernet controller DT binding
> for USXGMII interface.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  Documentation/devicetree/bindings/net/macb.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
> index 9c5e94482b5f..cd79ec9dddfb 100644
> --- a/Documentation/devicetree/bindings/net/macb.txt
> +++ b/Documentation/devicetree/bindings/net/macb.txt
> @@ -25,6 +25,10 @@ Required properties:
>  	Optional elements: 'rx_clk' applies to cdns,zynqmp-gem
>  	Optional elements: 'tsu_clk'
>  - clocks: Phandles to input clocks.
> +- serdes-rate External serdes rate.Mandatory for USXGMII mode.
> +	0 - 5G
> +	1 - 10G

Please use the values 5 and 10, not 0 and 1. This also needs a vendor
prefix.

       Andrew
