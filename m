Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61824C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3307621907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568808492;
	bh=io5r9Ksy4K18+QAOFeKorNG/e6Tl5MhtFX2ESMaUcjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W9a1BSGWwngVbwEXMpp4zHkL+Ft2NMeK3QNePL4eWUr6R8rwnuyErfzdrHwMvxAWI
	 lYOl4z4fVVQnD3lakf+wIQTB7HTbeS/PaD02R9lnaazWvrDW5wPcPVZsk+wpeFX7Lf
	 ELpBwUJIatF/dHc96bBwega59wTIUTzEmyJUB5Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfIRMIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfIRMIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:08:11 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429AA21920;
        Wed, 18 Sep 2019 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568808490;
        bh=io5r9Ksy4K18+QAOFeKorNG/e6Tl5MhtFX2ESMaUcjI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xPx/RbJqde40pOyMsrLbq5/GLCZc/SpYT/SH8y3u3TcJyeEUm+STj8btF4iOQNhYQ
         S8rnw+ccnylINWtj3wmDIqFtRiO14odBzb+3tHV8R+3+kIqWHpkJj1dARN+Mskgn9y
         LjCcJzhxD020htqTz9zkNciu0XtmTUnnztLX3xSA=
Received: by mail-qk1-f169.google.com with SMTP id u184so7748314qkd.4;
        Wed, 18 Sep 2019 05:08:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXnuRHGYvUzuvRSOlaF1Nl+IWIsBa8aMqcMuV8ugr+akUPm2OO1
        UwoEr9VIkRHRDi1nyuH5SY0Hgy8yx7kK2nzbyw==
X-Google-Smtp-Source: APXvYqzJEOXiGujx2Z3QRuY4qEmct5ht+GAeA7lZFd+lkleCoNwVE0JJzqxtmmkacsTEeyPnububE9E+QPAvvvX5zk4=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr707446qkl.152.1568808489461;
 Wed, 18 Sep 2019 05:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190918111447.3084-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190918111447.3084-1-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 07:07:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFUnafJkuc1XDMKd-j2SPR2=SpcDXbEOC7tW=hT9pxjA@mail.gmail.com>
Message-ID: <CAL_JsqLFUnafJkuc1XDMKd-j2SPR2=SpcDXbEOC7tW=hT9pxjA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: remove un-implemented property
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 3:15 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The `adi,disable-energy-detect` property was implemented in an initial
> version of the `adin` driver series, but after a review it was discarded in
> favor of implementing the ETHTOOL_PHY_EDPD phy-tunable option.
>
> With the ETHTOOL_PHY_EDPD control, it's possible to disable/enable
> Energy-Detect-Power-Down for the `adin` PHY, so this device-tree is not
> needed.
>
> Fixes: 767078132ff9 ("dt-bindings: net: add bindings for ADIN PHY driver")
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
