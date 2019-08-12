Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D89C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D88D2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565653391;
	bh=B+8cznS14S49KDGzx/u43oN8Gr31SOmx59QuWw6kN3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c8yCtFDamP8jwkcvCnM5FG9/dL4XYNQhGMaIMKycutn1ipRAgLHFVcDvy2+nDOnAa
	 yEEWQj9ugiS5N0oPv04rstyzEd1S2PIycvWc+keHOfu8cigvuJtzPvtTIQPmypvSy+
	 fmnebziFPg24GaWT3tptz99Rmo91VmwxPj0GF70Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfHLXnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:43:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44542 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfHLXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:43:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so115434093otl.11;
        Mon, 12 Aug 2019 16:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=diWyFvgrxloUL25PWlMWiWVbWH7kFJmehbZp7USbjYs=;
        b=fgkWOZiorjsmoGF2Y1tkfNbeODCDl+evdLr2V1yO2y/WbPq2VIoUCcJwm7sHOxSEyr
         3ZPC+VgaSBjSlWv17rrEj2vjVUdm3SPhNerq7dIqyXtbTvFsa4VHnvPCY8eFwcNxiPDc
         V+ogQVCG/2j2DpP+FgpSDBPTUY+7tmkeVVZqq1iMCUG0fZtW9/rIcay5Jhi82vo+iZrE
         Lzz3WL0gXdFfffm1gVQ3M/y6oyhnIpYI5p7bMkW5wZmePTfYzvwoWE7Jp4R8PLwxgcGO
         xALwui6y14BKTzq//vCLbzgNZxDVivv1gnMc3Abnly6ba0HpzE3DuOfqlwYeiGW0TrLV
         Aw2A==
X-Gm-Message-State: APjAAAWoLbSvHZ7+BagbOckgkS5rdF/GkS8mNYsoYOv/nwZbss/zr13f
        1ejauWQh7eqvJcGGC9VvovzssaQ=
X-Google-Smtp-Source: APXvYqwndy9yeKK7tFiaiOXPhVbI3rSeHolHt/frXP4VHoOKfqggRaK6S1M22/SGQGdtX2xoGHuD3Q==
X-Received: by 2002:a5d:9448:: with SMTP id x8mr39885728ior.102.1565653388357;
        Mon, 12 Aug 2019 16:43:08 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c13sm20184641iok.84.2019.08.12.16.43.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:43:07 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:43:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt/bindings: mips: Document Ingenic SoCs binding
Message-ID: <20190812234306.GA28064@bogus>
References: <20190722175548.18434-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722175548.18434-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:55:47PM -0400, Paul Cercueil wrote:
> Document the available properties for the root node and the cpu nodes of
> the devicetree for the Ingenic SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/mips/ingenic-socs.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ingenic-socs.txt

Please convert this to DT schema.

> diff --git a/Documentation/devicetree/bindings/mips/ingenic-socs.txt b/Documentation/devicetree/bindings/mips/ingenic-socs.txt
> new file mode 100644
> index 000000000000..fea2e6ec10a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/ingenic-socs.txt
> @@ -0,0 +1,14 @@
> +Bindings for Ingenic JZ47xx family of SoCs
> +
> +Required properties for root node:
> +- compatible: One of:
> +  * ingenic,jz4740
> +  * ingenic,jz4725b
> +  * ingenic,jz4770
> +  * ingenic,jz4780
> +
> +Required properties for CPU nodes:
> +- compatible: One of:
> +  * ingenic,xburst-d0
> +  * ingenic,xburst-d1
> +  * ingenic,xburst-e1

Root node and cpu bindings should be separate files. The CPU nodes 
should have much more than just a compatible string.

Rob
