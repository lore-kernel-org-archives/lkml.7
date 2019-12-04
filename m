Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16DC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D69206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575486063;
	bh=eU1k5f7V8J8S9HTgAkmD0YJDV5rlPKCA6Ru4znN2V08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wr2+/OhB054wwFnzooueTQMslM1Ni70+liWkm15BYdNBnt5w+AVmXegAtWPwml9UO
	 Br+WFBVoKZTucIFBxE1pEmmfFPL5qUzeGJILE0RCOJ2Cn5uCIXfLkvO5crZQVDcTiB
	 S8zILsV3xQYLPbVszx2xQ8RxUUZGa6dXhzias41E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfLDTBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:01:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35514 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:01:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id o9so257022ote.2;
        Wed, 04 Dec 2019 11:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwBhK4ah0i/Ig7V+1zYwmmj4biw+P5iHg9PENmdCa7c=;
        b=DcAyBtZdgmq35p36freH/E5pUv5ar2Ra9IFEPmx0ujEQiw7ko4rnUouv+CruKWqVDT
         rL+XsrCAz/wCSP56crjtxv0EwIqAwL/m4dslGPk4OUbNRRk16bIUbdIEh/E6sUt17Eo5
         QNKDse9sDd2sARZSiVunHc4em7z92amzp9uTblwFkLHjD3caodY9Ia807pnqmGXnvacO
         TqX/cDALCl0OF7/BWR9MZeNXjh3chOYD0C2xXJXjMVlPdSwec/vRBfNRGbXndFkKJQAY
         WXfaKAcvbln+0WTmiWvQGH/hTZkvch4LDPl9/Il7/bVMnnj08cda+kZLEnN5RX6HR/GX
         hqfA==
X-Gm-Message-State: APjAAAX1eLDzkuvZ6Q9+NrOBYUzk4tO6+f8Y7xejpBf6IoPygpX97dOC
        kgqcoZ1fAy107/xU5Lldrw==
X-Google-Smtp-Source: APXvYqykaXzIiV7E1St6j6MMG1XrHs3Z1lg6Qp5Z5odvxnUvdStDByxIHHh+z9HCbxikKEPYNojVGw==
X-Received: by 2002:a05:6830:1e75:: with SMTP id m21mr3582520otr.36.1575486061635;
        Wed, 04 Dec 2019 11:01:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r124sm2656329oie.9.2019.12.04.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:01:01 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:01:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 2/4] dt-bindings: vendor-prefixes: Deprecate "ste" and
 "st-ericsson"
Message-ID: <20191204190100.GA28640@bogus>
References: <20191120181857.97174-1-stephan@gerhold.net>
 <20191120181857.97174-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120181857.97174-2-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 19:18:55 +0100, Stephan Gerhold wrote:
> Until now, device tree bindings for ST-Ericsson have been added
> inconsistently with one of 3 possible vendor prefixes.
> 
> "stericsson" is the most commonly used vendor prefix,
> so deprecate "ste" and "st-ericsson".
> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> Changes in v2: new patch
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
