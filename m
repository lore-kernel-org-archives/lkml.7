Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB52173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565304999;
	bh=1kgfg2u0VvSSAyVnDXUX0dXjWHTqsPHMjNRngfqfQUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sySdrnEaoUL3QnoL9AvIzymHiYAQCMO2aas50QweUeC7bR2E9iY+6HuO7QzkK6oHg
	 2k+I2GsPb2HsTvGwUsSSz2/TIZvG549R/sS+B77UESRYdK1GMO9hyEuWzkInobNcZx
	 pi4Bj3QYN1jH8eLNYNjZwYsFXXBg1UEr63FymCzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404183AbfHHW4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390022AbfHHW4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:56:37 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D458217F4;
        Thu,  8 Aug 2019 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304997;
        bh=1kgfg2u0VvSSAyVnDXUX0dXjWHTqsPHMjNRngfqfQUE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2tE2GpPB+BXu1EQhYHhOzd7Oa1T+eF4En1xo6N5XdddI0vuIDhoaro1Pf7S1ZKBr7
         H03wDRobZTaSwytpEXymUOtsl6dmW9yyttdis0OZwThij26sBLCSnn99F7AjczHPPS
         /O5LUCjyysvXArLpo7a/9XlCHdk4H7kPL1YKqHTI=
Received: by mail-qk1-f170.google.com with SMTP id u190so6591790qkh.5;
        Thu, 08 Aug 2019 15:56:37 -0700 (PDT)
X-Gm-Message-State: APjAAAXuh2Yk5nypXTIXfoQY3/YpvTzMFWFTbb4iUH3Guzyth+6oIH9o
        qTpeLytFK4xCL+SFdAAdGOqN049JQWW8mt17fA==
X-Google-Smtp-Source: APXvYqyj2kUWAWCGeBwzaRUWZX1PPK9z+mXWtT1nM3BJRodHPwfRd4dExJVae9unAVJvhED59NF02Tnbg9U9rGFDZow=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr16025678qke.223.1565304996424;
 Thu, 08 Aug 2019 15:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908081520100.6414@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908081520100.6414@viisi.sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Aug 2019 16:56:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+db+_u47yutb+H7dcMqP27PF9jjwinsB2qgi609t9zWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+db+_u47yutb+H7dcMqP27PF9jjwinsB2qgi609t9zWQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: remove obsolete cpus.txt
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:22 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> Remove the now-obsolete riscv/cpus.txt DT binding document, since we
> are using YAML binding documentation instead.
>
> While doing so, transfer the explanatory text about 'harts' (with some
> edits) into the YAML file, at Rob's request.
>
> Link: https://lore.kernel.org/linux-riscv/CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com/
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/riscv/cpus.txt        | 162 ------------------
>  .../devicetree/bindings/riscv/cpus.yaml       |  12 ++
>  2 files changed, 12 insertions(+), 162 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/riscv/cpus.txt

Reviewed-by: Rob Herring <robh@kernel.org>
