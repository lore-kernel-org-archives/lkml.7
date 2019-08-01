Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B920B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564674653;
	bh=mo2HdMSRCqt3TFJkQl9d7X3tKGeVpM+cbgnJbsSOiBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QJ/SsUokyh+liYJzV0oce5rT9BG42VRzuIFyz06ERre0A1Q6h1q6Td3EIPt9vjBsH
	 NaqFd/tQypttpujWfJ1FFqaqgnSebpCH+1KDAXtNFRrDUZoz2IZVTUz6TS0ElRFmsi
	 gAOKoSLnCebSHrEtF+6Qq4iO/QO3C+svyAKjpdz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfHAPuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731079AbfHAPuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:50:52 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285B821773;
        Thu,  1 Aug 2019 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564674651;
        bh=mo2HdMSRCqt3TFJkQl9d7X3tKGeVpM+cbgnJbsSOiBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NXLsozSYOIx9rgmDZGvJH1orQh3Sih5ok+LDLGRki2c9GNYyHcBujEiSfTrb4L0hE
         Kq/zLCt7vLGKd95Jmjf+KBCOpxM7BmwGOZi5zcqTEOBKLZXpvIR9vZWaZOFuOFOAp4
         nKbypj4GdUDLiW2dD2yPDj6ZdsQV8WJLxPGE3UsA=
Received: by mail-qt1-f175.google.com with SMTP id k10so1562479qtq.1;
        Thu, 01 Aug 2019 08:50:51 -0700 (PDT)
X-Gm-Message-State: APjAAAVyg7KFyXzeE7nAjgxIEhUb9rc3CuK/OEHuRDwbUAb+hdJkQbBi
        GnMoegWd4iqSHVypdqjAKtBfSAoiPNd8TCTr7A==
X-Google-Smtp-Source: APXvYqzqIDIJzp/P5UH50rteyQO1siPBt2WuomDxMcjKRkIu8XCHmururywkdwwVKhn5raiJ1jaTSLRgDcGehkVoih0=
X-Received: by 2002:a0c:acef:: with SMTP id n44mr94852273qvc.39.1564674650265;
 Thu, 01 Aug 2019 08:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190801005843.10343-1-atish.patra@wdc.com> <20190801005843.10343-6-atish.patra@wdc.com>
In-Reply-To: <20190801005843.10343-6-atish.patra@wdc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 09:50:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLqxN1+fvrdD24Ho6s7gB+pGy-0sZaL-jJqkYZ2yC4JEA@mail.gmail.com>
Message-ID: <CAL_JsqLqxN1+fvrdD24Ho6s7gB+pGy-0sZaL-jJqkYZ2yC4JEA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dt-bindings: Update the riscv,isa string description
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 6:58 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Since the RISC-V specification states that ISA description strings are
> case-insensitive, there's no functional difference between mixed-case,
> upper-case, and lower-case ISA strings. Thus, to simplify parsing,
> specify that the letters present in "riscv,isa" must be all lowercase.
>
> Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index c899111aa5e3..4f0acb00185a 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -46,10 +46,12 @@ properties:
>            - rv64imafdc
>      description:
>        Identifies the specific RISC-V instruction set architecture
> -      supported by the hart.  These are documented in the RISC-V
> +      supported by the hart. These are documented in the RISC-V
>        User-Level ISA document, available from
>        https://riscv.org/specifications/
>
> +      Letters in the riscv,isa string must be all lowercase.
> +

The schemas are case sensitive this looks pretty pointless without the
context of the commit msg. Can you prefix with 'While the
specification is case insensitive, "

For some background, FDT generally always has been case sensitive too
(dtc won't merge/override nodes/properties with differing case). It's
really only some older true OF systems that were case insensitive. The
kernel had a mixture of case sensitive and insensitive comparisons
somewhat depending on the arch and whether of_prop_cmp/of_node_cmp or
str*cmp functions were used. There's been a lot of clean-up and now
most comparisons are case sensitive with only Sparc having some
deviation.

Rob
