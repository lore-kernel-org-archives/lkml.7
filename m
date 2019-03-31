Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E723FC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65BA21874
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014502;
	bh=5+pbrPl2M6YmIP3amrliIJOTt6HdYqhQ4KKRtSlTvWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dP9scxRxvsZb6W3K+z+yAStfaJhy0rbSPK0+zKAjZMmrC9XfL4W1V+Q1L08qFenqB
	 GvcyhU4ArvqGSCmWiY17i2fYBSptATPehHYLcAbwVYnywEZBkmV5XnN2xcOW88f8J1
	 eHA4Wp5XlYA2aFKyqET0LZVZaVMwaXU3KbN/1l9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfCaGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41722 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbfCaGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so2981184pfd.8;
        Sat, 30 Mar 2019 23:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=dN6jornbGP4wNZ9WHQNjirl7vb53eCYIGpQZYJZAn2A=;
        b=W9i2bf3a0LoWQ+BUPs4NSf7GrSCpEPd/E+IGxgWA5dzomSavXktHrF8ZJEoubSRAEi
         n0Uo+S1Z3lVKgC3tnXkGin7TekA2JTIY3rzpyn3AMvY9kwDXwsGtNhIVgBzpL6b3YpbX
         ttByFtgbzPL8oAGo+dqRXw8gwFyYdbOm6e19B5d/Ur7++OQg45tmC3SqNG4j5wF9InV5
         qX6VPc53gzdsKnSMzi2k03Uymb3M3oQABJdiCGYubIK/e4/xywzxGjVQBVfzJQ4odLMG
         5cQel3xl5ESqPrPZtaovVSvfuTrBn8ZbQcl+NrxpXrRzR1adrKUxGCsbiu+d9ikX9MG2
         j68Q==
X-Gm-Message-State: APjAAAXIXKUnVaXggrGHCth+tbIek27blOefXC675EaA/Nto7wqtPFhn
        bsJv0ajf/7TVusQwCskYxFW0pbwdxA==
X-Google-Smtp-Source: APXvYqzT6QeYHaalyJm/DVT0ZxoBzAggoqP2L5wUVzPUJv0oExdYjgpmv7DcMnkMWYcfJzgQJvYb2g==
X-Received: by 2002:a63:36ce:: with SMTP id d197mr5145626pga.180.1554014499432;
        Sat, 30 Mar 2019 23:41:39 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id t3sm7957799pgv.39.2019.03.30.23.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:38 -0700 (PDT)
Message-ID: <5ca06122.1c69fb81.1f767.5d1d@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: serial: add ASR8751C serial bindings
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-5-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-5-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-5-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:25PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add binding documentation for ASR8751C serial device.
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  .../devicetree/bindings/serial/asr-serial.txt      | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/asr-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/asr-serial.txt b/Documentation/devicetree/bindings/serial/asr-serial.txt
> new file mode 100644
> index 0000000..9e0e191
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/asr-serial.txt
> @@ -0,0 +1,23 @@
> +* UART Controller of ASR8751C SoCs
> +
> +Required properties:
> +- compatible : should be "asr,uart"

Needs an SoC specific compatible.

> +- reg: iomem address and length of uart registers
> +- interrupts : Should be the interrupt number
> +- clocks: clock required by uart
> +- clock-frequency: frequency of clock source
> +- dmas: dma channel used by uart tx or rx
> +- dma-names: dma name of uart tx or rx
> +
> +Example:
> +
> +	uart0: uart@d4017000 {
> +		compatible = "asr,uart";
> +		reg = <0xd4017000 0x1000>;
> +		interrupts = <0 32 0x4>;
> +		clock-frequency = <13000000>;
> +		dmas = <&pdma0 AP_UART0_RX 1
> +			&pdma0 AP_UART0_TX 1>;
> +		dma-names = "rx", "tx";
> +		clocks = <&soc_clocks ASR_CLK_UART0>;
> +	};
> -- 
> 2.7.4
> 

