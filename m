Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F35B21841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014492;
	bh=P7rjMHyHlPwbvTbBBn2fhd+DbJuJ/kpbufGLdxPvjKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uau9lkfWzbg5kFZxuS8Wun3RtGknU5k6H4gGtpbQzJFyaNMIFXVCCC1KwHlPJHH6s
	 ulm3R/evBN0K6EkzYmEZI3t0eWDpvMvKecx5gXjpL5+zjOKByZMTpjUKkIhaVoRbxh
	 77eX8X9KFfa2nMGl9/FBNFud/WpCDBzywuFBYdNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfCaGlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37055 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfCaGl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so2986604pfr.4;
        Sat, 30 Mar 2019 23:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c85HpS10ISxSK8yWSCeGY9XrNSVk7P/VB+8tyjiP2zc=;
        b=XLcGolYJPn48YrsgLhkhwrko1/w2iLh/LRnzGviLcBcqAaluIUUpCq/8taLAYdoRfB
         9wzKAisMTlSugeTnSubD0nkUg8Sh0Z3vAU3yBG1kijGRR92VuYZkoQ23qRVmM7It1v2V
         UqM7FTzO43VJSaOzj94JUdQ/O507ZRPIcaO2GX055COUdQu3nMvBol1jce0K8DnwyTta
         UxsFFhc330M0Xn/pQ7wtPeaDHU3wVQt2kvzXhWKepXDoJ1xcBpW9bRSsb3M1MzhzODwU
         Bd2i6OWB/zP2BaorF12kpHlApCxS22966YtWl6WznF3zQFBLRuLDJBN5TjWQeZ2mLk7Y
         pvgQ==
X-Gm-Message-State: APjAAAUwfDCU1svrvjaqXA5aCykCEr0LZEGKmNK8cacOt0zoD7LA4pgS
        bL5QztGzNpTewYFjViY0LA==
X-Google-Smtp-Source: APXvYqws/hOawpr66DDI8ZW/uAgEYgtPiprG3ri7DMZ86Pvn/DWj+0llaRqH6SuxDsFVWQqpnRQ4sg==
X-Received: by 2002:a63:f541:: with SMTP id e1mr54047867pgk.388.1554014488428;
        Sat, 30 Mar 2019 23:41:28 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id p3sm14469640pfp.136.2019.03.30.23.41.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:27 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:41:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARCH: Use the correct style for SPDX License Identifier
Message-ID: <20190331010549.GA17669@bogus>
References: <20190323132808.GA10547@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323132808.GA10547@nishad>
X-Mutt-References: <20190323132808.GA10547@nishad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 06:58:14PM +0530, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in the Hardware Architecture subsystem.
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46
> and making some manual changes.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h     | 2 +-
>  arch/arm64/include/asm/pointer_auth.h             | 2 +-
>  arch/arm64/include/asm/sdei.h                     | 2 +-
>  arch/arm64/include/asm/vmap_stack.h               | 2 +-
>  arch/nds32/include/asm/assembler.h                | 2 +-

No reason to put all arches in one patch. Please split by arch for 
maintainers to take.

Rob

