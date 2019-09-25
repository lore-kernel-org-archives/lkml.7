Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20264C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F4121D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfIYVYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:24:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39466 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfIYVYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:24:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so189356plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Bg76ABOLDvzkhoqAzUmInH7lsqAvMASqxxpTEuCtlfU=;
        b=WTwPVO6S4t2va3vTVCZXQG367+QFTu0AHA+S+xz1qDl4Gdfrhk37YRG0GNI8GxP/7y
         6hsxPIbNgILPT+0lStBktrn1cnRPCvFnBSvQ1kXkCyF0UPiUq92Y9VFb52OnqSBzZPXg
         SAMaj+g5Nbx/9L7I6vtbqbjy0v4JSZBKfOEOIzVD2BzbDTofJbmueeaN2Z0TS3Pf1s9A
         i4i5UOEelZNWkjpdvp1yUvAV3f+lg5VIPQSB5zW17ZQogQn2Qjc34Uptdj+MJCTKiIy3
         G1K5gTL7fMCavU/WZMyAMcjZWp9E0gj2RsAaoL9PZy7gNV/GLBBz8BBZzBEzoVCeWZnT
         hlOg==
X-Gm-Message-State: APjAAAWrcgNy56Tyg2DuWVtKf4rDhvHHuET0sX40ja/HL7WOEsCXQhEK
        TRjqhuNx87r9NTEX/zwDQT/14g==
X-Google-Smtp-Source: APXvYqzV3+50+lIHsJuDERolqp33oVDd9PnCnXIDA8KlRQf10bOdvBbQaagf0eDhLQIEFnn5zkKabw==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr133569plr.87.1569446658383;
        Wed, 25 Sep 2019 14:24:18 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q204sm5011083pfc.11.2019.09.25.14.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:24:17 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:24:17 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Sep 2019 14:24:16 PDT (-0700)
Subject:     Re: [PATCH v2] dt-bindings: riscv: Fix CPU schema errors
In-Reply-To: <20190925131252.19359-1-robh@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh@kernel.org
Message-ID: <mhng-c69fa4ff-9752-4ded-8a4f-ae86113bd9ae@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 06:12:52 PDT (-0700), robh@kernel.org wrote:
> Fix the errors in the RiscV CPU DT schema:
>
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@1: 'timebase-frequency' is a required property
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible:0: 'riscv' is not one of ['sifive,rocket0', 'sifive,e5', 'sifive,e51', 'sifive,u54-mc', 'sifive,u54', 'sifive,u5']
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: compatible: ['riscv'] is too short
> Documentation/devicetree/bindings/riscv/cpus.example.dt.yaml: cpu@0: 'timebase-frequency' is a required property
>
> Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-schema")
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Add timebase-frequency to simulator example.
>
>  .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index b261a3015f84..eb0ef19829b6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -24,15 +24,17 @@ description: |
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - sifive,rocket0
> -          - sifive,e5
> -          - sifive,e51
> -          - sifive,u54-mc
> -          - sifive,u54
> -          - sifive,u5
> -      - const: riscv
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sifive,rocket0
> +              - sifive,e5
> +              - sifive,e51
> +              - sifive,u54-mc
> +              - sifive,u54
> +              - sifive,u5
> +          - const: riscv
> +      - const: riscv    # Simulator only
>      description:
>        Identifies that the hart uses the RISC-V instruction set
>        and identifies the type of the hart.
> @@ -67,8 +69,6 @@ properties:
>        lowercase to simplify parsing.
>
>    timebase-frequency:
> -    type: integer
> -    minimum: 1
>      description:
>        Specifies the clock frequency of the system timer in Hz.
>        This value is common to all harts on a single system image.
> @@ -102,9 +102,9 @@ examples:
>      cpus {
>          #address-cells = <1>;
>          #size-cells = <0>;
> -        timebase-frequency = <1000000>;
>          cpu@0 {
>                  clock-frequency = <0>;
> +                timebase-frequency = <1000000>;
>                  compatible = "sifive,rocket0", "riscv";
>                  device_type = "cpu";
>                  i-cache-block-size = <64>;
> @@ -120,6 +120,7 @@ examples:
>          };
>          cpu@1 {
>                  clock-frequency = <0>;
> +                timebase-frequency = <1000000>;
>                  compatible = "sifive,rocket0", "riscv";
>                  d-cache-block-size = <64>;
>                  d-cache-sets = <64>;
> @@ -153,6 +154,7 @@ examples:
>                  device_type = "cpu";
>                  reg = <0>;
>                  compatible = "riscv";
> +                timebase-frequency = <1000000>;
>                  riscv,isa = "rv64imafdc";
>                  mmu-type = "riscv,sv48";
>                  interrupt-controller {

Looking at this spec

    https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf

section 3.7 says

    Properties that have identical values across cpu nodes may be placed in the 
    /cpus node instead. A client program must
    first examine a specific cpu node, but if an expected property is not found 
    then it should look at the parent /cpus node.
    This results in a less verbose representation of properties which are 
    identical across all CPUs.

I can never figure out if I'm looking at the right DT specifications so it's 
possible that is defunct, I just bring this up because we've got an outstanding 
bug in our port where we're not respecting what section 3.7 says and are only 
looking at /cpus/timebase-frequency instead of /cpus/cpu@*/timebase-frequency, 
and I'm wondering if the fix should allow for looking at 
/cpus/timebase-frequency or just not bother.
