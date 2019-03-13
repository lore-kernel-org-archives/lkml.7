Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4900C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1C3213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552506891;
	bh=wi6y8mM77vpmoNRFF7mr5+588IsMZDv9uEZHQGTKgvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zs5oT1ElMPXbVdY4eQIw1g/HG552VuxQY8w4/eGI+VYUDR+CCmciBYMdLxY3Jbqb9
	 9nNwOKIjYt9HRfeOC14wbtxY/szdX9F7WS5KVETm1yYhz8rZpKZuqm1JirMLgR5+j/
	 mG8i3v2R2VlqnPs0JCmIcWSaS+hqG8olOfVdD100=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfCMTyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfCMTyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:54:50 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CDA2146E;
        Wed, 13 Mar 2019 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552506889;
        bh=wi6y8mM77vpmoNRFF7mr5+588IsMZDv9uEZHQGTKgvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XvRnWuGp15p+sqSeqafipoBeSOKrWRvLVJv14+LLpUPhqA0z4v49x4BS82OXcqHGA
         nXk+R6KQC6uixPTnIAvFOQs5Tvpvpj3Lx6QJf/mSNWx1GErX46tu4273ABIKzrv3Wj
         3ZKQWiS70NZwq9O8kXI9m9wMOmeJrFwjhSiIV08E=
Received: by mail-qk1-f170.google.com with SMTP id n6so1905530qkf.1;
        Wed, 13 Mar 2019 12:54:48 -0700 (PDT)
X-Gm-Message-State: APjAAAX49ble4w0EvihrqCsDU6PF3phNQTVat1kOtuapdCdK2jFzkZo9
        zRfJGNLUOaF6sjwiaTKOsR3cwtyAXwxbsOZJWg==
X-Google-Smtp-Source: APXvYqxKPkCTGBdeJO9assOeqojAuVhOhfs3pS2lZ7Jw1v5RWLx06ZE6lEEebvbOj7Fdk2HZdsc+X8AUTp6zkjaXtlM=
X-Received: by 2002:a37:5947:: with SMTP id n68mr167128qkb.326.1552506888146;
 Wed, 13 Mar 2019 12:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163051.155405-1-venture@google.com>
In-Reply-To: <20190312163051.155405-1-venture@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Mar 2019 14:54:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
Message-ID: <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Patrick Venture <venture@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:30 AM Patrick Venture <venture@google.com> wrote:
>
> Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
> Changes for v7:
> - Moved node under the syscon node it requires
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
>  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> new file mode 100644
> index 000000000000..088cc4e3dc54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> @@ -0,0 +1,48 @@
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
> +       - "aspeed,ast2400-p2a-ctrl"
> +       - "aspeed,ast2500-p2a-ctrl"
> +
> + - syscon: handle to syscon device node controlling PCI.
> +
> +Optional properties:
> +===================
> +
> +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> +               to AHB mapping
> +
> +The p2a-control node should be the child of a syscon node with the required
> +property:
> +
> +- compatible : Should be one of the following:
> +               "aspeed,ast2400-scu", "syscon", "simple-mfd"
> +               "aspeed,g4-scu", "syscon", "simple-mfd"
> +               "aspeed,ast2500-scu", "syscon", "simple-mfd"
> +               "aspeed,g5-scu", "syscon", "simple-mfd"
> +
> +Example:
> +
> +g4 Example
> +----------
> +
> +syscon: scu@1e6e2000 {
> +       compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> +       reg = <0x1e6e2000 0x1a8>;
> +
> +       p2a: p2a-control {
> +               compatible = "aspeed,ast2400-p2a-ctrl";

If there's a defined register range, then you could add a reg property
(even though Linux doesn't use it).

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
