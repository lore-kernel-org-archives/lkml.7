Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5BDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F4E22521
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256801;
	bh=fUd3tZx87qdnG6CwilRNMyUR8d2QluCbndXsUwHsrKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oleL35DlOWQIyQKnzHpkp7DoQikUA9pcZbe8Ata9tTDvpM5tCODvrbKbsjBaYCf1F
	 6LC4wUD13acbQyQ/49PCTMn51rrzpuTpFRZue2lhU7aA/MZtvSIiu7bOvTFH+Vh1fs
	 lP+V3a8lwHHjvYkueBDMQAFTjTsGSqUv5bfXviXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfKTNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbfKTNdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:19 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA8022521;
        Wed, 20 Nov 2019 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256798;
        bh=fUd3tZx87qdnG6CwilRNMyUR8d2QluCbndXsUwHsrKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n6zizZh2Ogrr7jK95g8XBlS4G/sFVvXPPu1bz5ZrWk5Csxwu/ysU31PfNzk6MLFxB
         2xQ9VCyLVkHtrh6b+UsdQ7SkDo6EOh0xKPKC+oHcwRA0RiLHEW7QyZ5+fUSjfoRcMq
         W/Yui2vNYyc5iCpIquvBd3FnhEXMWuvaPrzf/vKQ=
Received: by mail-qv1-f45.google.com with SMTP id cv8so9538478qvb.3;
        Wed, 20 Nov 2019 05:33:18 -0800 (PST)
X-Gm-Message-State: APjAAAV49mLF18TiUKxP6vjkCGlKS0y/nKaexbcvUaZcZfswsNNFm+Tx
        rroHtd0FjBCUVA7oYyCVMPgaixTMSbtz0h9HIQ==
X-Google-Smtp-Source: APXvYqwbpzn2fJraSCYad28+nndI8XWhSNe0EYjVvJZpgDz4z7+/dr0W/0EkM+wEC57Uvdy13UVXGH7HREtILCij3Ig=
X-Received: by 2002:a0c:ca06:: with SMTP id c6mr2416351qvk.136.1574256797274;
 Wed, 20 Nov 2019 05:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20191120121720.72845-1-stephan@gerhold.net>
In-Reply-To: <20191120121720.72845-1-stephan@gerhold.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Nov 2019 07:33:05 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a3zLhRpTYXOOoOt2Ct4SUeiYsPz=QvJXUm1w2aoMEGA@mail.gmail.com>
Message-ID: <CAL_Jsq+a3zLhRpTYXOOoOt2Ct4SUeiYsPz=QvJXUm1w2aoMEGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add yet another for ST-Ericsson
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 6:19 AM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Unfortunately the vendor prefix for ST-Ericsson is used very
> inconsistently. "ste," and "stericsson," are already documented,
> but some things in the kernel use "st-ericsson," which is not
> documented yet.
>
> st-ericsson,u8500 is documented in bindings/arm/ux500/boards.txt,
> and is used to match the machine code and the generic DT cpufreq
> driver.
>
> Add it to the list of vendor prefixes.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c5ec0a..c9b0bab8ed23 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -909,6 +909,8 @@ patternProperties:
>      description: ST-Ericsson
>    "^stericsson,.*":
>      description: ST-Ericsson
> +  "^st-ericsson,.*":
> +    description: ST-Ericsson

Please add 'deprecated: true' to the 2 that are not preferred. Looks
like 'stericsson' should be preferred as it is used the most.

Rob
