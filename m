Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C95FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A224679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576790753;
	bh=Hr3A52RHcjmG1auaTGUXBvxSO4ri6tQxYw9jNYLxq6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SWMWZpkDvpkiUWtdl++Uk1LxaYD/KUjPz7azh4Dlc72IiliZrE5WKISSO+EdmoKb+
	 +21sYnw3RS6d3EXAruuHRBWlcCvL/6DH2vCMxW6MzSUYFv6QW1mkohartYAZanszhR
	 rDzgLCTjsqUuIbFJkds7yaO/p3C55Rhc/A514mYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLSVZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:25:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:47051 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:25:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id p67so3715741oib.13;
        Thu, 19 Dec 2019 13:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdaDqv389nwuJfMr+9dWIhmrpQWZvQQTZ6l0w6zcmrw=;
        b=ldxA4KeDrKr4iTvlEahUdcsA6FfaswGNh3zgTNfqRyCel/WwpFjwuDMcO4SQ3nrxUr
         k9Y8Dntjq2RjFd4n3tZRTwMVbV9770fPj8INhBfzrE4Llbb9XOsHd+a8uVpQtRhNgsx8
         0GTUOD2uHn33Eo4cWNSdYQQq5HKH9p0hGDxtdQw/g/VrMnIV7JA+GqLKKAf4noVX4EQR
         TUzrd68OvNHl8R5D//Y2I9vBefagoFeuQpHz661NxkEvcTIe9Ut5DvI/KErYTZDrP+R7
         DciMdSUv/YdqvM4amQtJVzqMgg76sBkZ8bsUVNSzjxbaLeMVImGVk0NFkip6xlKZwqPt
         CIKw==
X-Gm-Message-State: APjAAAXcONpqVvnPrG8FbxUMOISd3gYZBdeM0S0/hWTxzoA5x42Wjmzv
        ZAjcRmvBAqiiUjImDTfvww==
X-Google-Smtp-Source: APXvYqwuflBeMf3NnXJqeB759MW7dgiGU+PZzQooZ8wP5La+lozOJLuQYKSin8mu5r+taziTEOI2Sg==
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr3170983oij.4.1576790751013;
        Thu, 19 Dec 2019 13:25:51 -0800 (PST)
Received: from localhost ([2607:fb90:1cdf:948a:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id 4sm2633539otu.0.2019.12.19.13.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:25:50 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, jsarha@ti.com,
        tomi.valkeinen@ti.com, praneeth@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [RESEND PATCH v1 14/15] dt-bindings: phy: phy-cadence-torrent:
 Add platform dependent compatible string
Message-ID: <20191219212546.GA30631@bogus>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-15-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576069760-11473-15-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:09:19PM +0100, Yuti Amonkar wrote:
> Add a new compatible string used for TI SoCs using Torrent PHY.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 8069498..60e024b 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -15,7 +15,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: cdns,torrent-phy
> +    anyOf:

Should be an enum or if both strings can be present then you need 2 
oneOf entries for 1 string and 2 strings.

> +      - const: cdns,torrent-phy
> +      - const: ti,j721e-serdes-10g
>  
>    clocks:
>      maxItems: 1
> -- 
> 2.7.4
> 
