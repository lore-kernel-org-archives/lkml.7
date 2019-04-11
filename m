Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863D6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554987346;
	bh=uu2M3x2oEdWyYW+DzsEwqWmw/nj922+HhTk/STNy3ZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AkexsiFShycgJFabViUA9RXaRnw37uVYF3yjtSshA3LCqvyH1umWPhxoSBuD3YNTC
	 OeEbS1J+ZgVoAAFYPFB305FMOtQEPJFc6dRx+IIn3cGmAcoGO6fWddx1Pf6iCncnGb
	 tSji06b8EUnnCyMLtMLrlkPsCteIwd9i/YeFY80A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKMzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKMzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:55:45 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C82E2184B;
        Thu, 11 Apr 2019 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554987343;
        bh=uu2M3x2oEdWyYW+DzsEwqWmw/nj922+HhTk/STNy3ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1Y7JHl64fuhR0kWW3Yxyz0FjoUHBuGxgoBnIC3bs7cv47QWgKKIa5seuOM2Lvqf2p
         SfFXR4b5xexdfz8ZP5l0j+F/+zM/YwgDUigDM5hxcCtObFAHF36kTQ0MuBcxyxPHJG
         EqxLLz2YXfcGDO33c54fWYxdIqW5pe1Yrz66Y9OQ=
Received: by mail-qt1-f172.google.com with SMTP id w30so6860861qta.8;
        Thu, 11 Apr 2019 05:55:43 -0700 (PDT)
X-Gm-Message-State: APjAAAVi1UJsFFxtEuzqrTqoBqy5uDIS6DERkwQOcLXSYIZ2czaFaZ3w
        o9g8uu+Xj7bkucPAXrdZE2bTgW7EQ0cQATaamQ==
X-Google-Smtp-Source: APXvYqyhRLeAqMgbaOjzJSv2ar77gOAF0jDx/RCQ6kpX8/sKQ8jFXeR2fuL56NurlGIp9zk2rQ9fJAyW5pDv0rHBPTk=
X-Received: by 2002:a0c:c950:: with SMTP id v16mr41199222qvj.204.1554987342189;
 Thu, 11 Apr 2019 05:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411084304.5072-4-paul.walmsley@sifive.com>
In-Reply-To: <20190411084304.5072-4-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Apr 2019 07:55:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJhmrQmP00GwAty1KQZxdoSVSShGfjdkBmNgB0x3ev8KA@mail.gmail.com>
Message-ID: <CAL_JsqJhmrQmP00GwAty1KQZxdoSVSShGfjdkBmNgB0x3ev8KA@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: riscv: convert cpu binding to json-schema
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 3:43 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> At Rob's request, we're starting to migrate our DT binding
> documentation to json-schema YAML format.  Start by converting our cpu
> binding documentation.  While doing so, document more properties and
> nodes.  This includes adding binding documentation support for the E51
> and U54 CPU cores ("harts") that are present on this SoC.  These cores
> are described in:
>
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>
> This cpus.yaml file is intended to be a starting point and to
> evolve over time.  It passes dt-doc-validate as of the yaml-bindings
> commit 4c79d42e9216.
>
> This patch was originally based on the ARM json-schema binding
> documentation as added by commit 672951cbd1b7 ("dt-bindings: arm: Convert
> cpu binding to json-schema").
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       | 274 ++++++++++++++++++
>  1 file changed, 274 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/cpus.yaml
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> new file mode 100644
> index 000000000000..11ade807fd49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -0,0 +1,274 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V bindings for 'cpus' DT nodes
> +
> +maintainers:
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +description: |+
> +  In SoC device tree data files, the layout of CPUs is described in
> +  the "cpus" node.   This node in turn contains a number of subnodes
> +  representing CPUs, which define properties for every cpu.
> +
> +  Bindings for CPU nodes follow the Devicetree Specification, available from:
> +
> +  https://www.devicetree.org/specifications/
> +
> +  with updates for RISC-V cores provided in this document.
> +
> +  ================================
> +  Convention used in this document
> +  ================================
> +
> +  This document follows the conventions described in the Devicetree
> +  Specification, with the addition:
> +
> +  - square brackets define bitfields, e.g. reg[7:0] represents the
> +    value of the bitfield in the reg property contained in bits 7 down
> +    to 0
> +
> +  =====================================
> +  cpus and cpu node bindings definition
> +  =====================================
> +
> +  If a Devicetree file is used to provide hardware data to the kernel,
> +  the RISC-V architecture requires the cpus and cpu nodes to be
> +  present and contain the properties described below.
> +
> +properties:
> +  $nodename:
> +    const: cpus
> +    description: Container of cpu nodes
> +
> +  '#address-cells':
> +    const: 1
> +    description: |
> +      A single unsigned 32-bit integer uniquely identifies
> +      each RISC-V hart in a system.  (See the "reg" node under
> +      the "cpu" node, below).
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^cpu@[0-9a-f]+$':
> +    properties:
> +      device_type:
> +        const: cpu
> +
> +      reg:
> +        maxItems: 1
> +        description: |
> +          Set the "reg" property to the hart ID of this CPU node.
> +          Each value in this property must be unique in the scope
> +          of the Devicetree file that contains it.
> +
> +      compatible:
> +        items:
> +          - const: riscv

Wrong order here. This should be last.

> +          - enum:
> +              - sifive,rocket0
> +              - sifive,e5
> +              - sifive,e51
> +              - sifive,u54-mc
> +              - sifive,u54
> +              - sifive,u5
> +        description: |
> +          Identifies that the hart uses the RISC-V instruction set
> +          and identifies the type of the hart.
> +
> +      mmu-type:
> +        items:
> +          - enum:

If a single value, then you can drop 'items'.

> +              - riscv,sv32
> +              - riscv,sv39
> +              - riscv,sv48
> +        description: |
> +          Identifies the MMU address translation mode used on this
> +          hart.  These values originate from the RISC-V Privileged
> +          Specification document, available from
> +          https://riscv.org/specifications/
> +
> +      riscv,isa:

This needs to have a $ref to a type schema. (Under an 'allOf' list
with this enum)

> +        items:
> +          - enum:

Also don't need items here if a single value.

> +              - rv64imac
> +              - rv64imafdc
> +        description: |
> +          Identifies the specific RISC-V instruction set architecture
> +          supported by the hart.  These are documented in the RISC-V
> +          User-Level ISA document, available from
> +          https://riscv.org/specifications/
> +
> +          The RISC-V Linux port only will execute on a subset of these

What Linux does isn't relevant to the binding.

> +          values.  However, other hart cores may be present in the
> +          Devicetree hardware description file that do not run Linux.
> +
> +      timebase-frequency:
> +        maxItems: 1

Not an array.

> +        description: |
> +          Specifies the clock frequency of the system timer in Hz.
> +          This value is common to all harts in this Linux system image.
> +
> +      i-cache-block-size:
> +        maxItems: 1

Not an array. Surely you can define either the set of possible values
or min/max values. Same comment on the rest of the cache props.

Are the cache attributes really not discoverable?

> +        description: |
> +          Specifies the size, in bytes, of an instruction cache line.
> +
> +      i-cache-sets:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of sets in the hart's instruction cache.
> +
> +      i-cache-size:
> +        maxItems: 1
> +        description: |
> +          Specifies the size, in bytes, of the hart's instruction cache.
> +
> +      i-tlb-sets:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of sets in the hart's instruction TLB.
> +          If present, the "tlb-split" property must be set.

'dependencies' can express this for you. We do need a core schema for
all these to define the type and maybe dependencies can be there.

> +
> +      i-tlb-size:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of entries in the hart's instruction TLB.
> +          If present, the "tlb-split" property must be set.
> +
> +      d-cache-block-size:
> +        maxItems: 1
> +        description: |
> +          Specifies the size, in bytes, of a data cache line.
> +
> +      d-cache-sets:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of sets in the hart's data cache.
> +
> +      d-cache-size:
> +        maxItems: 1
> +        description: |
> +          Specifies the size, in bytes, of the hart's data cache.
> +
> +      d-tlb-sets:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of sets in the hart's data TLB.
> +          If present, the "tlb-split" property must be set.
> +
> +      d-tlb-size:
> +        maxItems: 1
> +        description: |
> +          Specifies the number of entries in the hart's data TLB.
> +          If present, the "tlb-split" property must be set.
> +
> +      tlb-split: true
> +
> +    patternProperties:
> +      '^interrupt-controller@[0-9a-f]+$':

No 'reg', so should not have a unit-address.

> +        properties:
> +          $nodename:

You don't need this as we just defined it above.

> +            const: interrupt-controller
> +            description: Describes the CPU's local interrupt controller
> +
> +          '#interrupt-cells':
> +            const: 1
> +
> +          compatible:
> +            const: riscv,cpu-intc
> +
> +          interrupt-controller: true
> +
> +        required:
> +          - '#interrupt-cells'
> +          - compatible
> +          - interrupt-controller
> +
> +    required:
> +      - device_type
> +      - reg
> +      - compatible
> +      - riscv,isa
> +      - timebase-frequency
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +examples:
> +  - |
> +    // Example 1: SiFive Freedom U540G Development Kit
> +    cpus {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        timebase-frequency = <1000000>;
> +        cpu@0 {
> +                clock-frequency = <0>;
> +                compatible = "sifive,rocket0", "riscv";
> +                device_type = "cpu";
> +                i-cache-block-size = <64>;
> +                i-cache-sets = <128>;
> +                i-cache-size = <16384>;
> +                reg = <0>;
> +                riscv,isa = "rv64imac";

> +                sifive,dtim = <&L8>;
> +                sifive,itim = <&L7>;

Not documented.

> +                status = "okay";

Don't show status in examples.

> +                L10: interrupt-controller {
> +                        #interrupt-cells = <1>;
> +                        compatible = "riscv,cpu-intc";
> +                        interrupt-controller;
> +                };
> +        };
> +        cpu@1 {
> +                clock-frequency = <0>;
> +                compatible = "sifive,rocket0", "riscv";
> +                d-cache-block-size = <64>;
> +                d-cache-sets = <64>;
> +                d-cache-size = <32768>;
> +                d-tlb-sets = <1>;
> +                d-tlb-size = <32>;
> +                device_type = "cpu";
> +                i-cache-block-size = <64>;
> +                i-cache-sets = <64>;
> +                i-cache-size = <32768>;
> +                i-tlb-sets = <1>;
> +                i-tlb-size = <32>;
> +                mmu-type = "riscv,sv39";
> +                reg = <1>;
> +                riscv,isa = "rv64imafdc";
> +                status = "okay";
> +                tlb-split;
> +                L13: interrupt-controller {
> +                        #interrupt-cells = <1>;
> +                        compatible = "riscv,cpu-intc";
> +                        interrupt-controller;
> +                };
> +        };
> +    };
> +
> +  - |
> +    // Example 2: Spike ISA Simulator with 1 Hart
> +    cpus {
> +            cpu@0 {
> +                    device_type = "cpu";
> +                    reg = <0>;
> +                    status = "okay";
> +                    compatible = "riscv";
> +                    riscv,isa = "rv64imafdc";
> +                    mmu-type = "riscv,sv48";
> +                    interrupt-controller {
> +                            #interrupt-cells = <1>;
> +                            interrupt-controller;
> +                            compatible = "riscv,cpu-intc";
> +                    };
> +            };
> +    };
> +...
> --
> 2.20.1
>
