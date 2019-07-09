Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7447C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D5F217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562637144;
	bh=xMnqEIC8brZu5gZZFbj/ysEfSWLv5w57WDhGQDSuYbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uN9u5KZeRnG2fjb5jwKHQIpF3yCl2TSjFT/n7RoRImFCJNkFHdgX8La+eTg23SQ/U
	 lLUAcVUeV10qe3C6JRGSoZ2r1TC5Z+H7pvOlledM7BF0PMCXCWtyrogoEEpbJZFslw
	 wme8MGcFO+218HMkyC5K+6yJ4PeSahZlNd7XSgq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfGIBwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:52:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35473 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfGIBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:52:23 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so30247323ioo.2;
        Mon, 08 Jul 2019 18:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/tzcZLlDxbC1twwv0AFnIwTd9l+z877k7LvqZNpQY/c=;
        b=kMwyIDadQowI9Se3474fkdqIU67ubqm8PaDM2K1pPoKp+c4wFFz5JaQXsxMGfdF0mL
         xbZFQj8bqgy/EF+i0XH94/dJe56NO8EibhLTDlrpNU+2saVGeRj2TNugjbrFwsW6Nx11
         vr/L+UzPQPW+w2devIJ+7Th1yQagCpdHH86X67oPfcpcv99bf/JB5j8Eie+ZnlxXpeQq
         YmVPOLm4Q/bUwi059pXwZUtI3xedcPnkhe2alJI71JaxtgmBm5zWwtX/T9wMBfvXz1fy
         8H6TEnq7JkMpQ+J0UpYOluZcASqaQ08ShXorknPJGzo+caNwES0FKdDl08xqsXUC+J3D
         0bNA==
X-Gm-Message-State: APjAAAUuRUkKPMlawxakxcP3yPT1myk3vHBBDZPUK6/NjcOVIBIxG2Wj
        ynLelUNQoEYmpd5OEpUcLQ==
X-Google-Smtp-Source: APXvYqyuoLXWQjUHBrmOlsWqa0z0KTgxi+6bb9MZ0KVWo5iYoxRliYViJNxGihIE2TjIS3iii9ESlQ==
X-Received: by 2002:a02:6d24:: with SMTP id m36mr25055180jac.87.1562637142441;
        Mon, 08 Jul 2019 18:52:22 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e188sm16873548ioa.3.2019.07.08.18.52.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:52:21 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:52:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     p.zabel@pengutronix.de, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Joao.Pinto@synopsys.com,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: Re: [PATCH V2 2/2] dt-bindings: Document the DesignWare IP reset
 bindings
Message-ID: <20190709015220.GA18239@bogus>
References: <1559835388-2578-1-git-send-email-luis.oliveira@synopsys.com>
 <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559835388-2578-3-git-send-email-luis.oliveira@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:36:28PM +0200, Luis Oliveira wrote:
> This adds documentation of device tree bindings for the
> DesignWare IP reset controller.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> ---
> Changelog
> - Add active low configuration example
> - Fix compatible string in the active high example
> 
>  .../devicetree/bindings/reset/snps,dw-reset.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/snps,dw-reset.txt b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> new file mode 100644
> index 0000000..85f3301
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/snps,dw-reset.txt
> @@ -0,0 +1,30 @@
> +Synopsys DesignWare Reset controller
> +=======================================
> +
> +Please also refer to reset.txt in this directory for common reset
> +controller binding usage.
> +
> +Required properties:
> +
> +- compatible: should be one of the following.
> +	"snps,dw-high-reset" - for active high configuration
> +	"snps,dw-low-reset" - for active low configuration

This is really a standalone block?

Are there versions of IP?

> +
> +- reg: physical base address of the controller and length of memory mapped
> +	region.
> +
> +- #reset-cells: must be 1.
> +
> +example:
> +
> +	dw_rst_1: reset-controller@0000 {
> +		  compatible = "snps,dw-high-reset";
> +	 	  reg = <0x0000 0x4>;
> +		  #reset-cells = <1>;
> +	};
> +
> +	dw_rst_2: reset-controller@1000 {i
> +		  compatible = "snps,dw-low-reset";
> +		  reg = <0x1000 0x8>;
> +		  #reset-cells = <1>;
> +	};
> -- 
> 2.7.4
> 
