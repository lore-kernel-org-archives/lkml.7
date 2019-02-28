Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971C62084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378107;
	bh=T4vz1wrCwXI1jz2pATD6mgBJRmgYJNxRp7r3FUwdKyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HekVyltiSrCsfc5CYpLm8YQhOHPOojo/iaIDhsZqrcmxzcoFzF7XGwwGvzH3syEdK
	 rigtmrwSRYRYSuKKPurBvZEH9F+Z9728aXsmXbAF817D8x0q2wmY2A3Wt3bteQsZbT
	 tYummxbBWD+6Rn74n3F89ZzBqBqi+St8Oy4sJFns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfB1SVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:21:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32978 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbfB1SVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:21:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id q24so18597634otk.0;
        Thu, 28 Feb 2019 10:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXMRdphL6kd9UzYovrsbOamX2rIv9CqwoFhOUVZxEes=;
        b=TWVM29VUFYqSNjdbqQnlTIqP63Lmjyk+DaEmSqMkno9aL6Bi1ayOXdR4vp98k7s+ak
         x/+nI/OPVJtanG/hNG56kO4q0l8hCLXcivhThKaEXPcNrsQR/wtFwhWpn3jEvYRxJkie
         alewoMFz74GRLeRbN3+t8x1/zJSiPOjAw9iRuHtz462iFTo6t+YVw9uqs0zucoK1NUB7
         hjwOPKUYL42vUlbTSSOBCH9dRYwQWwM1KaQxfh3Y3udF8NE+yL3ag7ojE/HaJcHWpyiJ
         SajxiT3juGjE2v9f7aY4aCqWNojqz2ij3QCfaMBkVGAgzXoA/qYsDg0WJSM1mHMPA9oH
         6q3A==
X-Gm-Message-State: APjAAAVMt04qzlXc5cL16cbjwIcrigVGZBlST/XxoUSDuYxasdOk8sui
        uU4IZgITdZ9WDETFBeGoZQ==
X-Google-Smtp-Source: APXvYqzbnWrQ9tizJSc9FPgK/tcGOpyCXP+oMmv8Uep9g92zsahWILpLF3EFkYkO/HuO4mqzziGraA==
X-Received: by 2002:a9d:4c95:: with SMTP id m21mr678987otf.43.1551378104452;
        Thu, 28 Feb 2019 10:21:44 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id 124sm9186994oia.55.2019.02.28.10.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:21:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:21:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: gpu: add bindings for the ARM Mali
 Bifrost GPU
Message-ID: <20190228182141.GA5362@bogus>
References: <20190212163838.22644-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212163838.22644-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 05:38:38PM +0100, Neil Armstrong wrote:
> Add the bindings for the Bifrost family of ARM Mali GPUs.
> 
> The Bifrost GPU architecture is similar to the Midgard family,
> but with a different Shader Core & Execution Engine structures.
> 
> Bindings are based on the Midgard family bindings, but the inner
> architectural changes makes it a separate family needing separate
> bindings.
> 
> The Bifrost GPUs are present in a number of recent SoCs, like the
> Amlogic G12A Family, and many other vendors.
> The Amlogic vendor specific compatible is added to handle the
> specific IP integration differences and dependencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Changes since v1:
> - adding missing G31 and G52
> - fixed example
> 
>  .../bindings/gpu/arm,mali-bifrost.txt         | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> new file mode 100644
> index 000000000000..04a1d63ee578
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
> @@ -0,0 +1,96 @@
> +ARM Mali Bifrost GPU
> +====================
> +
> +Required properties:
> +
> +- compatible :
> +  * Must contain one of the following:
> +    + "arm,mali-g31"
> +    + "arm,mali-g51"
> +    + "arm,mali-g52"
> +    + "arm,mali-g71"
> +    + "arm,mali-g72"
> +    + "arm,mali-g76"

Given that these flavors are all fully disoverable, we could probably 
just have 1 compatible here. It's not often that I suggest this. :)

We allowed this with vivante as all the version and feature information 
is discoverable.

> +  * which must be preceded by one of the following vendor specifics:
> +    + "amlogic,meson-g12a-mali"

We should keep these for any integration differences though.

Rob
