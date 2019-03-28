Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3726C2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779021;
	bh=qZdZPKINE4VZQS3zNVAxpGen9oQBLaGLjjPVdq9iDsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mM8yEP0JZvvqN58X1eue71N7Y2UyPC2fiTNHvHva4652mk2vIML72ddhvu9iQQBMd
	 U9B0KgXF0TOmnmtm7GN1uIFHLWpUIBbGgM1bJkWVn+N1HmaLOZspCy6jZCYhF2yoxF
	 Ih3VklXR4BzyZWJIfy8fxaEqVEUDRAps3HUGMyFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfC1NRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:17:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33595 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1NQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:16:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id e5so4128745oii.0;
        Thu, 28 Mar 2019 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pn3Ppnj79eCRo8oEYSf27YTL8dBpbQan26H5ouo+6fk=;
        b=Ah5xOzab66LmeI0l4u6JMolu6w5+JxYClF2swxR9ddRE+9O8FzwAzdCFvqtbKtiDKf
         eksQPvO8Q0nvhmu27GyD/f/jc0lsKNNFixfmBgjgtEcXhI/hpE4C0TIDvwyeLAk96F1M
         WYCZcu7iYC1s71HoEbrYQpZnlLmrU9pcWEt1AQk04pSLsERXSNe54PbKy6ILJ1VZj1/G
         jLUucJhOdH5n2hHDdHs2xqBEeFZAagq6nrOE1scEZHV30lyhz4/z9ttux8qF2Evpoa69
         UyuzWMY9enQHcdrAqbRgVp6G1mWs9n4kd0hiavrPMmom8RDvfDgGaYfReYv5dvKPJkiI
         ALUg==
X-Gm-Message-State: APjAAAWhGksshxSUdwXQ1mzzbpOTbNwwLlAWG65YkEl8OAx5igSY05kh
        wYbwM9+6oL5kvmY3hRzAjA==
X-Google-Smtp-Source: APXvYqzz402a4nMNaEgT6CIkteO4kbA6vgSKjCTdCz2dYVkON/TRQtLZcTpMrZY5tqHmMbyuJdR2Hg==
X-Received: by 2002:aca:c687:: with SMTP id w129mr22553037oif.134.1553779018613;
        Thu, 28 Mar 2019 06:16:58 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id k23sm10397135otr.6.2019.03.28.06.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:16:57 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:16:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        aou@eecs.berkeley.edu, bp@alien8.de, mchehab@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
Message-ID: <20190328131657.GA9056@bogus>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:51:00PM +0530, Yash Shah wrote:
> DT documentation for L2 cache controller added.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/edac/sifive-edac-l2.txt    | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> new file mode 100644
> index 0000000..abce09f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> @@ -0,0 +1,31 @@
> +SiFive L2 Cache EDAC driver device tree bindings
> +-------------------------------------------------
> +This driver uses the EDAC framework to report L2 cache controller ECC errors.

Bindings are for h/w blocks, not drivers. (And Boris may want a single 
driver, but bindings should reflect the h/w, not what Linux (currently) 
wants.

Are the only controls for ECC? Are all the cache attributes discoverable 
(size, ways, line size, level, etc.)? 

> +
> +- compatible: Should be "sifive,<chip>-ccache" and "sifive,ccache<version>".
> +  Supported compatible strings are:
> +  "sifive,fu540-c000-ccache" for the SiFive cache controller v0 as integrated
> +  onto the SiFive FU540 chip, and "sifive,ccache0" for the SiFive
> +  cache controller v0 IP block with no chip integration tweaks.
> +  Please refer to sifive-blocks-ip-versioning.txt for details
> +
> +- interrupts: Must contain 3 entries for FU540 (DirError, DataError, and
> +  DataFail signals) or 4 entries for other chips (DirError, DirFail, DataError,
> +  and DataFail signals)

3 or 4, but you only have 1 chip compatible defined?

> +
> +- interrupt-parent: Must be core interrupt controller

This is implied and could be in a parent node.

> +
> +- reg: Physical base address and size of L2 cache controller registers map
> +  A second range can indicate L2 Loosely Integrated Memory
> +
> +- reg-names: Names for the cells of reg, must contain "control" and "sideband"
> +
> +Example:
> +
> +cache-controller@2010000 {
> +	compatible = "sifive,fu540-c000-ccache", "sifive,ccache0";
> +	interrupt-parent = <&plic>;
> +	interrupts = <1 2 3>;
> +	reg = <0x0 0x2010000 0x0 0x1000 0x0 0x8000000 0x0 0x2000000>;
> +	reg-names = "control", "sideband";
> +};
> -- 
> 1.9.1
> 
