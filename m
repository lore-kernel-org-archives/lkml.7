Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8107C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8D9218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530770;
	bh=Z3c50IVXRHPm/rq2ixXEld/V8zBo9KAOAgzHHHBLqdg=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=ApnNKrb0yHsEPVesGd6qMMY6Lh5UC5RlR2I6CuP7+R3hiv4aBse9gApIzlcmQ9ZUc
	 Mj8dMmZyOTkZSyAFwe8+xvUv5wXiUh3BVwqDQMzuq3OSm0xLiALqHGowxEGpPU/zx+
	 OnjJTkB6Ty+Sh9X3k+rbdqQBIOlHpIeXWTpG29ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDFGGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46316 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDFGGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so4179430pgv.13;
        Fri, 05 Apr 2019 23:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=9w7EQ59djVMT/yra/zVaafD2a787JfvjnjqhLIF7aV4=;
        b=WhStow4BtOvuE4Gt/n9+uWztmD7Ro1FQuCE7EICL/JBzdXBnqxSvN5onB/trlFpKlL
         ZTQ1+i46fAIY/QH/sbNwq53PlyNASEFlfb9npJ15Ekz+/bqZlNX3UAJmfAWYn2uIsUCJ
         kWNQvTLadlBSm/WsdKLjTwWeDvmP/9LWqGR8LBcraWp/SUvCPtnIsquCZC9u6OQRK30a
         ppr7qfAmUX/ZPw2w15j239MSLt6dHbh3mPnoNq8/t8B9OZp0KOsLvsCJJMbSm5Fr9NaD
         ZpeTxcYYBoh+qeaX9kIjSlNlWimXtBU56EkI1OGtfO2qKxUCTRqfmfd5Md+tyPe91y06
         m2aw==
X-Gm-Message-State: APjAAAXysXBvQEVky0y79P7Awp3Xn7ioksIi4b1hZ+I4SciF90y1foQe
        +jTclLSa2OeaKjRRh3a1ag==
X-Google-Smtp-Source: APXvYqx7bRQMsiuxKhAYYZopO8h/29m6921AqiMQE52ewGPkhRyb/xhTaS9itC1tktt9KbFu+PKsVQ==
X-Received: by 2002:a63:f956:: with SMTP id q22mr5235243pgk.210.1554530767243;
        Fri, 05 Apr 2019 23:06:07 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id f1sm29751400pgl.35.2019.04.05.23.06.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:06 -0700 (PDT)
Message-ID: <5ca841ce.1c69fb81.b2f88.e449@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:04 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] media: dt-bindings: media: meson-ao-cec: Add G12A  AO-CEC-B Compatible
References: <20190401081959.16474-1-narmstrong@baylibre.com> <20190401081959.16474-2-narmstrong@baylibre.com>
In-Reply-To: <20190401081959.16474-2-narmstrong@baylibre.com>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 10:19:57 +0200, Neil Armstrong wrote:
> The Amlogic G12A embeds a second CEC controller named AO-CEC-B, and
> the other one is AO-CEC-A described by the current bindings.
> 
> The register interface is very close but the internal architecture
> is totally different.
> 
> The other difference is the clock source, the AO-CEC-B takes the
> "oscin", the Always-On Oscillator clock, as input and embeds a
> dual-divider clock divider to provide the precise 32768Hz base
> clock for CEC communication.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/media/meson-ao-cec.txt      | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

