Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10354CA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9134218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572313792;
	bh=3lZc7nhSifx1Fqn9vDT6E/43lgXpCcDFpvwekOjoBxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q3fwBbyU4FdYYC/ErRP4wowsKybF5py0qphvXGcUUI6YTG+AfQ9mqlU5CxUKNJaRQ
	 kGmL+mUNofUEglDy9rLHySmcMlMEK4u80kb2Tuca1OYnNy/wbPgzMG8fopRaLA6VQf
	 +XYwqMPFzEwP44hoKznVKmyeW0rIY9JnaVjLezh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfJ2Btv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:49:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44594 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfJ2Btv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:49:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id n48so8393208ota.11;
        Mon, 28 Oct 2019 18:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OwO97DxpTpJcLYlkzMeOuj/rD0CUwDcPUCTNwf6RveY=;
        b=Q2/i+7IGJ52a7bcTXmokmxqaVqsYTgZ0X+xh6ZVrAdyM6EGiboOBB1Vpw2fMRQPSw1
         dju7wjM+2oUV+JugYTzWVtL3BPIih0CD6rzaoT5jLeGeFL47kqok6bXHVUalsL7Nij2V
         6TwLchfiuXZ9WmJQplnpsBp249/7M7sErkZxVg+ExCXDSWENqjbRe8NO6Yk83kzV4avt
         gOMCkMji9059bwPb8oDazkqnt9w4Et9YBTkThpDmi4GgSrRhKvx6cDul5N3B+w/svGgk
         NvZYXpXJCuAjuOv6DDZ846TIjGUSgnx1jLe4OfXqkev6yYvku1gfsvAHJT4TkS5P+r3c
         U+ow==
X-Gm-Message-State: APjAAAXagRsdLzb2Fj0bXXuWzQ5ZnUDUCd+Z8YPben0DccwEvfycWchv
        O6N0ZnyDVSCsRDNkiF4E5IxDIWo=
X-Google-Smtp-Source: APXvYqxb+Q+XI/gBXpbL/OnoFUprupV1+asYGZRYItetzH0XJsjrBhjrnc7oNJmispxysnmUIHX34g==
X-Received: by 2002:a9d:4c04:: with SMTP id l4mr8138995otf.303.1572313790495;
        Mon, 28 Oct 2019 18:49:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm2051438otr.5.2019.10.28.18.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:49:49 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:49:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: at91: Document Kizbox2 boards
 binding
Message-ID: <20191029014949.GA22009@bogus>
References: <20191017085405.12599-1-kamel.bouhara@bootlin.com>
 <20191017085405.12599-2-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017085405.12599-2-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:54:04AM +0200, Kamel Bouhara wrote:
> Document devicetree's bindings for the SAMA5D31 Kizbox2 boards of
> Overkiz SAS.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.yaml   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index c0869cb860f3..7636bf7c2382 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -80,6 +80,41 @@ properties:
>            - const: atmel,sama5d3
>            - const: atmel,sama5
>  
> +      - description: Overkiz kizbox2 board without antenna
> +        items:
> +          - const: overkiz,kizbox2-0
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: Overkiz kizbox2 board with one head
> +        items:
> +          - const: overkiz,kizbox2-1
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: Overkiz kizbox2 board with two heads
> +        items:
> +          - const: overkiz,kizbox2-2
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: Overkiz kizbox2 board with three heads
> +        items:
> +          - const: overkiz,kizbox2-3
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5
> +
> +      - description: Overkiz kizbox2 board Rev2 with two heads
> +        items:
> +          - const: overkiz,kizbox2-rev2
> +          - const: atmel,sama5d31
> +          - const: atmel,sama5d3
> +          - const: atmel,sama5

These can all be made a single items list with the 1st entry being an 
enum of all the boards. The board description can be a comment.

Rob
