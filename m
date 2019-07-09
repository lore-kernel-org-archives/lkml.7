Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19912C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01702166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636242;
	bh=lYAvUOH4fn0Wz3P4DZPECvd1iXxRWhNoVyuyKs71p38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=njFKqxIWqe67P800t89AWoZY3cSdoc5Cfae2+VP7CNJbpQPBRXn+ahIZrmkirw66d
	 0bj7ZEEKA9JtPd0ceyUKBa4MYruc8zs5N8oEEJ2CDEGf7s8fcF+hGY60tMTA9AsGhi
	 uBl4UPs0as8WjFoxoU1yfh/Bg7IvC77vXc5GQ3PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGIBhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:37:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43072 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:37:20 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so39609923ios.10;
        Mon, 08 Jul 2019 18:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaPsRNpH7tGuW4jgrRhCMvtpmTscMl8GmgnpqNUqYao=;
        b=nrsFNuYg4IL0PGnk5q86TvHf8OmqnkNSxr7QJeKoSLlTYjiDyl7OtNSoueZp+9XSPC
         JWKll7cYglZB+yky3ftSCdpG9guS2bctA6PJWDddFT67b39h+JeZU4KCWeJ2yifhllw8
         MjrcGM+Cw4iGVXhavK6YX6yxnILWkFNIdlLB3pfimtagh8r2vb5QN03Pf6cpAG7/16OE
         uAvFMq2Ips84Y1ss7U2lTzPNKuVpplzWGezBbK+k7hU5uE8J4q6vaxUh8FP+OvxRzwfm
         yUr7aD4keALEkEC34vv1e/mjwx450mftFJAKSiqiuUAmArm/fU4xSLYdPCb5aXuScoxw
         weWw==
X-Gm-Message-State: APjAAAUgXsV31bNv070S+0VG568zVCsWNByLhICdkV+KQcGTaP5oPsGY
        F/iZWE4KPefu1nSAolnkxg==
X-Google-Smtp-Source: APXvYqzNHGNztU1FaqC2TGRNivEiq4uHjQkybCvtKOnC9NCpuzOJCA45bg9ivndp+fnSpf1E1n7baA==
X-Received: by 2002:a5e:990a:: with SMTP id t10mr15188215ioj.182.1562636239429;
        Mon, 08 Jul 2019 18:37:19 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s4sm19002185iop.25.2019.07.08.18.37.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 18:37:18 -0700 (PDT)
Date:   Mon, 8 Jul 2019 19:37:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     yongqiang.niu@mediatek.com
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3, 02/27] dt-bindings: mediatek: add ovl_2l description
 for mt8183 display
Message-ID: <20190709013717.GA26173@bogus>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
 <1559734986-7379-3-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559734986-7379-3-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 07:42:41PM +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 70770fe..2418c56 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -28,6 +28,7 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
>  	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
> +	"mediatek,<chip>-disp-ovl-2l"           - overlay (2 layers, blending, csc)

Does a single chip have a mixture of this block doing 2 and 4 layers? If 
not, the <chip> part implies 2 vs. 4 layers.

Rob
