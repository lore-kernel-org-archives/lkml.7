Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011DB214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552342815;
	bh=w6pS2brSBI9SrCDSiw+dfIVx6SjRQkHYPBAt7xIT4UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lDaAjmF6icmWnxob6cTqmbcApn/mTPcGxz8x5MDBc6Dk6dIIZTrsDlkJBKeeGQgau
	 aMmHWrtTNmagEu3FXtUvqRr4jh+LfgAw0FV9YF9JhcYizcpGU0ew7/jwTwZApjvRID
	 auGhTKRqkM3gY90p/I02232nKD92vCxCdOwWvcKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfCKWUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:20:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46318 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKWUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:20:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18so644632otl.13;
        Mon, 11 Mar 2019 15:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=usWh8C0ICesDz2nDaUJkmxEPx4LYxLwV+TsuQDQXA8s=;
        b=RWMtkXYAUPF8tW7cvaFr9t/QAkpWyDeij5vCVzEWxIGWUGoSGfluIz46Pxc9H7DGl/
         c8oOqaaf7lhOYnZ5gpRebLp+KveDePDTWGcJWrrRT1yJ4A2hNTupPHsSJtj2cr2qiFWV
         11M6FP2qS8UJv93SqWGPr8nR+fZ0/XMu+z2a1eJwgesYsabIb+tY8aj8cnsVaqGT0JOZ
         EBa/JQErWVSjEI5kQwU3KSQ+W9DeY8XQirq0p9QLk2RQ/4/JVfkKki1/XIne5DqGx1yM
         b8l+YcPSGlbplcqyUs5SQHHe/zm0C1w2Rv8PteXgZe5aaxqedEjRWklu73Y2AnXRCcz3
         bQJw==
X-Gm-Message-State: APjAAAXK2Httj2ZdYwoBpzEY93sGTcwJs30/8AbJBoSTTN2liFQSzkv9
        CyMwlfhXBEw5dMfEoDExCg==
X-Google-Smtp-Source: APXvYqymLIJ8cnmYoFBplREficKBEFMrxWR2PYwpRoh7lgJhJqFmNfK765NcIXpBDd8F6MMLtSoWbg==
X-Received: by 2002:a9d:740c:: with SMTP id n12mr21374816otk.312.1552342808544;
        Mon, 11 Mar 2019 15:20:08 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b20sm2719797otl.55.2019.03.11.15.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:20:07 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:20:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Venture <venture@google.com>
Cc:     mark.rutland@arm.com, joel@jms.id.au, andrew@aj.id.au,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
Message-ID: <20190311222007.GA16254@bogus>
References: <20190304185536.211084-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304185536.211084-1-venture@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:55:36AM -0800, Patrick Venture wrote:
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> 
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - None
> Changes for v3:
> - None
> Changes for v2:
> - Added comment about syscon required parameter.
> ---
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 000000000000..1092d62d1c92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,32 @@
> +======================================================================
> +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> +======================================================================
> +
> +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> +In this case, the host has access to a 64KiB window into all of the BMC's
> +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> +has read access to all the regions of memory, however the host only has read
> +and write access depending on a register controlled by the BMC.
> +
> +Required properties:
> +===================
> +
> + - compatible: must be one of:
> +	- "aspeed,ast2400-p2a-ctrl"
> +	- "aspeed,ast2500-p2a-ctrl"
> +
> + - syscon: handle to syscon device node controlling PCI.
> +
> +Optional properties:
> +===================
> +
> +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> +		to AHB mapping
> +
> +Example:
> +
> +p2a: p2a-control@1e6e2000 {
> +	compatible = "aspeed,ast2400-p2a-ctrl";
> +	memory-region = <&reserved_memory>;
> +	syscon = <&syscon>;

Make this node a child of what you are pointing to instead if this the 
only control interface.

Rob



