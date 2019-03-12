Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6837F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416160;
	bh=RPmd0phV45BmO/eEtxjs5EclLEwW+REHnhM2vgNw+Fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tp0xBv7s0506ct4CDV76wJyNQe9FS23H8B0Xj3xBhWrfZW/Z+qKa1JLrxU72fyLD7
	 GahM1PZgHFTu3wzOR/UplpenT2xBMd9ZVQfO1T3OXjYS1+dfV8ZNaBviPqC+aubZgA
	 t+vEvqxx2vWYwp6SUkiJy5lwV236P3MCGx+eQGQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfCLSmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:42:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43741 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:42:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id i8so2951922oib.10;
        Tue, 12 Mar 2019 11:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LoQ/p+bOTVhLP4bD27EYkJRWqyYOsYb+bL3tF1Naiw=;
        b=bAeiQDq1HIK/plZFQWrG8xl8mrGgjG6MY7KWzyn7IzyBm9Euji7JI8HUriFtl1T2XC
         9mP9mRsMCV+zXNZXtXkWihG/Xk2HNfeNCOe0ab7WDuLzMQCEkDLpRMTfznj4bYTsDd5z
         i8Cw+rBBu4Ti3Q96guI/1OJLTONsxahfWCi8cDk1rgOBgvPf9WsRb6ELL4rkiuaW445D
         pgIohA6ZL4uDm3Ilcqobo2axRnOYUvoJJRa72YZqqKRBqv4LKSVGYpnYpTczDPFByLWG
         ZViecq2QtZrXj3/G+gOyYBacQj1jDdhcZCIXBw4f9ITxHgxW5+VfdwKT5DJl7Y2ZLE5C
         LGBQ==
X-Gm-Message-State: APjAAAVVIt/RK/WyNZLXjne2lZGZvwgVP+DjXoxfn8KPj2ixRlv6AISn
        3e3Gq3GlMf+RFb6ARp9RwA==
X-Google-Smtp-Source: APXvYqzazpqwamVJmnPSHLUc+nQJlh2+UgWjpKqJZHLLCswr/OfwkNa0C5HMGsrzTHrgKqEaKc12Mw==
X-Received: by 2002:aca:aac7:: with SMTP id t190mr2472168oie.43.1552416157587;
        Tue, 12 Mar 2019 11:42:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k25sm3597071otl.58.2019.03.12.11.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:42:37 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:42:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Add binding for
 Armada framebuffer
Message-ID: <20190312184236.GA12049@bogus>
References: <20190304202006.3863-1-lkundrak@v3.sk>
 <20190304202006.3863-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304202006.3863-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 21:20:02 +0100, Lubomir Rintel wrote:
> This is the binding for memory that is set aside for allocation of Marvell
> Armada framebuffer objects.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Moved from bindings/display/armada/
> - Removed the marvell,dove-framebuffer string
> - Added to the MAINTAINERS entry
> 
>  .../marvell,armada-framebuffer.txt            | 22 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/marvell,armada-framebuffer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
