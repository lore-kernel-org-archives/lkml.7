Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6649C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCF8216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431603;
	bh=fiEf9iCZ+747cl2A/HLx3twvYbbL+7ZgYPkEnTENdnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MAOsMyFJCPrCdRn3I3/I+6FmjsN3ha0SJ6mEVTx5//w0inj3Sv2J5NXCphrYtD49X
	 +iQ2s2H7KAOBGrRnW3+dBuPDlV0Qfpa3RNzILiHxYdqRid3lACjvhMvphWzRw+oAhd
	 t1AWsQ7TnV/1bYTgKFSIKoODuynpELU8aTurseOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfIBNkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:40:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbfIBNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:39:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id z11so14074107wrt.4;
        Mon, 02 Sep 2019 06:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBQpIu3MdBocfsCIpsC7P4kQtQ0Hw6gvnA2LTGg/2kU=;
        b=CCJzxaUudzJApR61yPGMzLJoaSc63NrJS11965Ku5UH++ioU+Hf8lYuD19O3R4nwJG
         E7Ir8EfQ2PaBK4BwztF4ABVuCnYYQ2W67Eynt7js76RPaGTpMRz0IM2BR05pmvoBMbO1
         hxELmNrDkzE+7JgXObNPA8+6goEguSDm6qXky/wnhqz8l8iR7Z5s1/lq0vp48Hq72+f4
         oFAxqXcFsyl983HD0m1IMrIa5t/xn8EhsdKVvOtcicBD/+6x6ucyK17vAP7K+/Uz4GXm
         /CtZZb+PaQzmtZs1xFEvEQwdlfBip8lPdOmEEESkz3ogp1Oroqj3cJsnwX2ZrgJp89AZ
         wSzQ==
X-Gm-Message-State: APjAAAXuxrJEgJhRyXyWu3XW2A3Wsyb+DrNCb/o2b59XrsHeujAOor8Y
        5M9afgXp6htd+boekb+cVA==
X-Google-Smtp-Source: APXvYqzOziB9/p/RDzdTTKOOixVjwb77HfOfwBFq9dyMoMu58TjL2GIUyGjDZQr1/ar804Geq48eSw==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr22209063wrv.12.1567431540224;
        Mon, 02 Sep 2019 06:39:00 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id s15sm7545425wmh.12.2019.09.02.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:59 -0700 (PDT)
Date:   Mon, 02 Sep 2019 14:38:59 +0100
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.co,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 06/18] dt-bindings: interrupt-controller: Add
 Loongson-3 IOINTC
Message-ID: <20190902041114.GA27186@bogus>
References: <20190830043232.20191-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830043232.20191-1-jiaxun.yang@flygoat.com>
X-Mutt-References: <20190830043232.20191-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 12:32:20PM +0800, Jiaxun Yang wrote:
> Document Loongson-3 I/O Interrupt controller.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../loongson,ls3-iointc.yaml                  | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-iointc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-iointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-iointc.yaml
> new file mode 100644
> index 000000000000..9aee10abd5cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls3-iointc.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,ls3-iointc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Loongson-3 I/O Interrupt Controller
> +
> +maintainers:
> +  - Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +description: |
> +  This interrupt controller is found in the Loongson-3 family of chips as the primary
> +  package interrupt source which can route interrupt to interrupt line of cores.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls3-iointc
> +
> +  reg:
> +    maxItems: 1
> +
> +

Extra blank line.

> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    description: |
> +      Specifies the number of cells needed to encode an interrupt source.
> +      Must be 2 or 4.
> +      If the system requires describing interrupt line & core mapping, than
> +      it must be 4.
> +
> +      The 1st cell is the hardware interrupt number.
> +
> +      The 2nd cell is the flags, encoded as follows:
> +        bits[3:0] trigger type and level flags.
> +          1 = low-to-high edge triggered
> +          2 = high-to-low edge triggered
> +          4 = active high level-sensitive
> +          8 = active low level-sensitive.
> +
> +      The 3rd is the parent interrupt line that interrupt would map to.
> +      As the CPU preserved 4 interrupt lines for I/O, in theory any of the iointc
> +      interrupt can be chained to any interrupt lines on a core. But currently
> +      we can only map all the interrupt to a single parent, so this cell must be
> +      set uniformly for all the child interrupts corresponding to the parent
> +      interrupt.
> +
> +      The 4th is the parent core that interrupt would map to. The interrupt
> +      contoller can map any of the interrupt to the specified core on a package.
> +      This cell determined the core. It must be the bootcore.
> +
> +      If the 3rd, 4th cell is not set, it will default to the 0# interrupt line
> +      and bootcore.
> +
> +    enum: [ 2, 4 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

Missing from the property list and needs to define how many.

> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +
> +examples:
> +  - |
> +    iointc: interrupt-controller@3ff01400 {
> +        compatible = "loongson,ls3-io-intc";
> +        reg = <0x3ff01400 0x60>;
> +        interrupts = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <4>;
> +    };
> +...
> -- 
> 2.22.0
> 

