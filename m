Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D381021726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561571550;
	bh=S4bu6cwTK6G6hRMIv9GnhZMiK0UIi3WZJaspSurZK8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qga7muybtbjq23RmhBhsyrJN0LADctH4yhH+jf/rqCFyUzmt6w0VR1+oLYlkkbgWO
	 f4PsFhKPEdMTebtrn5yN8iOH9bG4my4GCsaL5QJqpomVz5oc7kb+WTISU20Cu0eLqu
	 rsVBvKDXNc7za9u7+T2y/ywVoMRbcCDqe17dstHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfFZRw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZRw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:52:29 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAB8208E3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561571548;
        bh=S4bu6cwTK6G6hRMIv9GnhZMiK0UIi3WZJaspSurZK8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iTGLj9aHRqtXaoP5kL+6QCzw5thEdaa1+j11XVbxBG4Xkir9g9ETqPKwLPjOnFrtb
         dPSzi7QPpH3sx0BlkgIrs0kdLYCzA9MHJSn3bbfpR1/yrVvWvuPjkt1W2a/6P4cA5q
         4NerJND/1KUOAE4bg7+g2SrLx6VU0Q1YF/aUlksU=
Received: by mail-qk1-f172.google.com with SMTP id a27so2419386qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 10:52:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXjE/ja0EnJ7LL7NYU8sb+eMYo1h2FuUrfMtHIZOC6GOeWPfAFi
        X7AUzIYepbjWljYleHeiunmWqigZQX4HhVoM8A==
X-Google-Smtp-Source: APXvYqzYhMv6rHrklns2vFmg1wcR2zD/R9gJFkeBnxKK/fLi2eSyCZ0bHo4Q8sz4Of0SuTqILRJ4kcOafVCphnT/TOk=
X-Received: by 2002:ae9:ebd1:: with SMTP id b200mr5212035qkg.152.1561571547170;
 Wed, 26 Jun 2019 10:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jun 2019 11:52:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com>
Message-ID: <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check' warnings
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:30 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> Rob pointed out that one of the examples in the RISC-V 'cpus' YAML schema
> results in warnings from 'make dt_binding_check'.  Fix these.
>
> While here, make the whitespace in the second example consistent with the
> first example.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 27f02ec4bb45..f97a4ecd7b91 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -152,17 +152,19 @@ examples:
>    - |
>      // Example 2: Spike ISA Simulator with 1 Hart
>      cpus {
> -            cpu@0 {
> -                    device_type = "cpu";
> -                    reg = <0>;
> -                    compatible = "riscv";
> -                    riscv,isa = "rv64imafdc";
> -                    mmu-type = "riscv,sv48";
> -                    interrupt-controller {
> -                            #interrupt-cells = <1>;
> -                            interrupt-controller;
> -                            compatible = "riscv,cpu-intc";
> -                    };
> -            };
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        cpu@0 {

This only works because you removed 'cpus' and therefore none of this
schema is applied.

> +                device_type = "cpu";
> +                reg = <0>;
> +                compatible = "riscv";

According to the schema, this is wrong. It should have 2 strings. Or
the schema needs to allow this case, but 'riscv' is too vague to be
very useful.

Also, I noticed that there's still a riscv/cpus.txt. That should be
removed and replaced with this file. Looks like the hart description
at least should be copied over (into top-level 'description').

> +                riscv,isa = "rv64imafdc";
> +                mmu-type = "riscv,sv48";
> +                interrupt-controller {
> +                        #interrupt-cells = <1>;
> +                        interrupt-controller;
> +                        compatible = "riscv,cpu-intc";
> +                };
> +        };
>      };
>  ...
> --
> 2.20.1
>
