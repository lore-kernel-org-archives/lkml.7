Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053D8CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68B21734
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572352742;
	bh=7ES2LXWL7aQiviFxtkFrH60RGqlSblaAAKuQS5UM9jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oy5PlXTQRqX6f8XV/kcprU1GXd5whlFkkbegnwWvIMzPNC+RCyAM+M2h/ufbe6Bz3
	 4dZAs8gN0CgdpToovSxax5n3OFzumML/HdpGP6b9oU7NYSoJhyhlP0warMqoDwrwg9
	 kgftG5Nx6cCXLcDHAPgQfCfNEnjIzAG3W3hGNGsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbfJ2MjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:39:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39420 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfJ2MjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:39:01 -0400
Received: by mail-oi1-f196.google.com with SMTP id v138so8765307oif.6;
        Tue, 29 Oct 2019 05:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0pAlxPefnZPIRefBhrT3Sgrq5uaOunz9Aa6ST/gasM=;
        b=a9GMEaVy6BI23jdRobm7TRmkyUXXe7W0Fijpt3f6MBnFaEa50XUXGjv+HjHtTk89Rq
         7GoPuaVez8Tg6NoctCtE9GZY76eEV6WXh7hk3A9Yo02OcUM6/+GgUKW3U0kGwVBD9OSk
         Lk2YKCH4IV8sQhdn49eJ2IT6nUSiHOlhBjUukOBTn+s6uA7D0bz0LI6HfLmIx8Hy2kc7
         o53mV9WubZ0mEdA0a7G+I3pFvGYX5Msh4pjyPNzHnZ/AvPtR2sac0DazgaYhlXhp08iV
         aBunKKxy7tlnmW2YDJtCipcRQB+bl4PPKO242guzwo/ET9zJlOcoEXI0TObLUBDLmVky
         Qb+A==
X-Gm-Message-State: APjAAAWwAfUFMLCxl+my3cJKfDFjk02+mvWmcR3q1ZfafaBTrrZaCLam
        eTtxkm7elZ7HjWCWZ52+lA==
X-Google-Smtp-Source: APXvYqxt+//5ED9g7iyU7AWAtvtc4k6r5HOC14j46hy0je9ALb9EwgOj5H8dxKh8G41DIjRra9VFYg==
X-Received: by 2002:a54:4885:: with SMTP id r5mr3723686oic.3.1572352740007;
        Tue, 29 Oct 2019 05:39:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm3873234oib.49.2019.10.29.05.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:38:59 -0700 (PDT)
Date:   Tue, 29 Oct 2019 07:38:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: Document SmartKiz board
 binding
Message-ID: <20191029123858.GA24145@bogus>
References: <20191018140658.31703-1-kamel.bouhara@bootlin.com>
 <20191018140658.31703-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018140658.31703-2-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:06:57PM +0200, Kamel Bouhara wrote:
> Document devicetree's bindings for the SAM9G25 SmartKiz board of
> Overkiz SAS.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 666462988179..f8053268cfa5 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -49,8 +49,16 @@ properties:
>            - const: atmel,at91sam9x5
>            - const: atmel,at91sam9
>  
> +      - description: Overkiz SmartKiz Board
> +        items:
> +          - const: overkiz,smartkiz
> +          - const: atmel,at91sam9g25
> +          - const: atmel,at91sam9x5
> +          - const: atmel,at91sam9
> +
>        - items:
>            - enum:
> +              - atmel,at91sam9g25
>                - atmel,at91sam9g15
>                - atmel,at91sam9g25

Duplicated... You did check this with 'make dt_binding_check', right?

>                - atmel,at91sam9g35
> -- 
> 2.23.0
> 
