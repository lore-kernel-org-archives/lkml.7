Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE167C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910C024672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782523;
	bh=Js6X5SsOeLFUHYBHfVY7eqsoo3cTgYSsN8i1+gkkdKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VB5d+a1D2bepoz0cZTOUInW2kniFwb8omt4SSpWGk5jONOsTmSnPFXjaNR6tVJmsw
	 uTDoArPI2hFtje6IzwYqzc4Ij1XBaiyO88b/u1oZvxhbqPktraqMJS681ee1NaatqR
	 JEemv01VHtCX8IJDPIpn83nnPJ+RM+1j4Whoa548=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfLSTIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:08:38 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45785 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfLSTIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:08:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so8429083otp.12;
        Thu, 19 Dec 2019 11:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QsMq4tK6Zqo8Cpzm50yk74qQajXSjQqRrWgVIrvvuts=;
        b=Xk2P4fp4Ski6KcDfQzGm5eFD3wPRRBveSrwLC3srh3QUtbuP4Lx1YfIplB3Nkn86gH
         3DtlbmCEt0sa4JboTQGfgh8Ubs2K5NarzZLIsvtRALPFOmt8bYX9AUPk6yqkuAsVdue5
         8tSTldj1a4+BIyIymz8BK38WfUfQIPMrPD76+8RphkPIwIl1Em6Uwb1lpiJ8inuKshhV
         GqpCxZsrSY8TPHQ9gioUg/hm9GNLfjp9/+FVSLW+XAKmnIqR1TxYeLOwPtauR/bxL/zL
         JiiC+8vHoGvzeH1lw74SRn0GnaWYn6rqaXjMInRy8llXO+Li6P5aIdyQ5IUmcWy8YUfB
         ujdg==
X-Gm-Message-State: APjAAAWTmf4Mk7JvDsmQ6liPAIjNOQhUl73bmSV/JD6hYshLShlgR7nS
        eKLYsDejM1NxtqpkQ0NlKw==
X-Google-Smtp-Source: APXvYqyA+C+YR9NLQNTQeygvAYER9H4Q3aJ5eWPMrh0WmckliHnJZQZLoczFwSIXApPVNHBCdP46/A==
X-Received: by 2002:a9d:4d99:: with SMTP id u25mr9960611otk.56.1576782516136;
        Thu, 19 Dec 2019 11:08:36 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id f3sm2403895oto.57.2019.12.19.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:08:35 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:08:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tomi.valkeinen@ti.com, praneeth@ti.com,
        yamonkar@cadence.com, sjakhade@cadence.com, rogerq@ti.com
Subject: Re: [PATCH 2/3] dt-bindings: phy: Add lane<n>-mode property to WIZ
 (SERDES wrapper)
Message-ID: <20191219190833.GA16358@bogus>
References: <cover.1575906694.git.jsarha@ti.com>
 <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 06:22:11PM +0200, Jyri Sarha wrote:
> Add property to indicate the usage of SERDES lane controlled by the
> WIZ wrapper. The wrapper configuration has some variation depending on
> how each lane is going to be used.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> index 94e3b4b5ed8e..399725f65278 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -97,6 +97,18 @@ patternProperties:
>        Torrent SERDES should follow the bindings specified in
>        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  
> +  "^lane[1-4]-mode$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2, 3, 4, 5, 6]
> +    description: |
> +     Integer describing static lane usage for the lane indicated in
> +     the property name. For Sierra there may be properties lane0 and
> +     lane1, for Torrent all lane[1-4]-mode properties may be
> +     there. The constants to indicate the lane usage are defined in
> +     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
> +     if its lane<n>-use property does not exist.

The defines were intended to be in 'phys' cells. Does putting both lane 
and mode in the client 'phys' properties not work?

Rob
