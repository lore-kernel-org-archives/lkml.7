Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD843C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0052173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565304790;
	bh=UDl7FH9qccKh/jy2kxm+7vEFoGqeFPVijVmq33g23+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yvQCegNF8WzMlPBV1/+Hc80yfrDM5p+6Z+Q7mtZIoD/13SBK0HOkjcAw4v6SXKeP4
	 279QxVJHjmjUkGggjLxdiD+h8+kj0Q8BTF/pqAy8UJw4voQWWGzcyiUs0YDsqLtJHl
	 WJuoI/Jxj0MKL8if4BxJ0p7PAUr6j74RXln/syrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403970AbfHHWxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbfHHWxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:53:09 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F37762173E;
        Thu,  8 Aug 2019 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565304788;
        bh=UDl7FH9qccKh/jy2kxm+7vEFoGqeFPVijVmq33g23+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bi/78M6qbFJlefcTvFTsTLezgq2DnCTUQYOR6vyIORZBWg4CQ0BCw3oe4UdF3d/ow
         SomPXm6HdaGZwrFV01uftjCqpntfXpu5VmE+ISAGGudtXv163rgX/lAbZ+Ckwlb1B8
         scfMvmr3VG9osL7Xd195FCJF1Bu6jLcLX+xBWUjY=
Received: by mail-qk1-f174.google.com with SMTP id d79so70163807qke.11;
        Thu, 08 Aug 2019 15:53:07 -0700 (PDT)
X-Gm-Message-State: APjAAAXty+jrSwkPmnmpkpNYnZAOv3lso4ljnuJPaYuxHvLaq56oRzCa
        7OmUQ+gWx6wmHPgLN/+2ShDnvjJy0FSrSS3mrQ==
X-Google-Smtp-Source: APXvYqyU/kTW6gdeVEMYafTbUnx/nIzUaj84Avqg8qc37wlRfsJNN1u8HEG+RqvAQ2Z+Dk87rGVIawEEewvI80/Z1T8=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr8830673qkn.254.1565304787197;
 Thu, 08 Aug 2019 15:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908081545190.15649@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908081545190.15649@viisi.sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Aug 2019 16:52:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5ms_65sux=Xi=beyu-vD9Qh-ziTpvpLz-qrtwOaLoEw@mail.gmail.com>
Message-ID: <CAL_JsqK5ms_65sux=Xi=beyu-vD9Qh-ziTpvpLz-qrtwOaLoEw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: fix the schema compatible string for
 the HiFive Unleashed board
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 4:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> The YAML binding document for SiFive boards has an incorrect
> compatible string for the HiFive Unleashed board.  Change it to match
> the name of the board on the SiFive web site:
>
>    https://www.sifive.com/boards/hifive-unleashed
>
> which also matches the contents of the board DT data file:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts#n13
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  Documentation/devicetree/bindings/riscv/sifive.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
