Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F376C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBB724652
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575569864;
	bh=PlAEFLN1jqtWKok/Lf9q+3BJb/5YRASigf4LDeh8jpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eowl0Zzju+C8X8i1zsNxoTHZjDL4hIKbPOOIOyNdWJPq6AE/cc0DpHj5Gd7wHkz6z
	 ilivO9dlvHpdABQRoP2Jpw2o63eX5KjBel5bP66An8jwND31T1NvtmTanzOnyrpzaj
	 ZpfjC4Ge7lZ/nZtuyMgpP0NPc3FSulZZndmjMO8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfLESRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:17:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40528 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 13:17:43 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so3436346oto.7;
        Thu, 05 Dec 2019 10:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u4uQDLDAwENfhHeQirg6G+6BYDGXlzNgApNiZIr6QmU=;
        b=qLZ3J5q4ieJHnb79TSj71oYbPUnAweFrGJlAMbWfisX1mPptZmvH06bHs74MW1/nkz
         VOQyW5R4s3pkQSRiDfSULTD1OZWjpt+WYEz6lpaQ3DdEoRByXLvqOpC4TmGSJm7/XbRL
         4A6YiadbG4Cbl9AFyM7nPi28ADYIK9eyTozqel+H6o52C3jYP0EQOlweOmDvIghABOEz
         q+69Xrz9XuqNrzv2B95YKeqmLqEEXJOxAtfuFDq0Co+Qa3vJgzR7XrB0Vr9jX8uPWdSc
         BlRe95387JNQHBWyJI/QWQcvi/6CodIharplC6xtk32yYaWyhEVIkfKSCO8qWLXztAGk
         IYyw==
X-Gm-Message-State: APjAAAVCU/dh8O6s36zvlj7nnWbpbk425TCNxGCXuRcKHtbKyOyHcI5/
        Wor1z09o/OParh1jKj2wHA==
X-Google-Smtp-Source: APXvYqzkq/aJ6tEAXfhu7WCsvfepMGPsY9OOYaC1oKI4g/ywEvKPqxK7dmYkmu+3yLNEvQB6kcw3YQ==
X-Received: by 2002:a9d:66ca:: with SMTP id t10mr7618291otm.352.1575569861752;
        Thu, 05 Dec 2019 10:17:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p189sm3817243oih.54.2019.12.05.10.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 10:17:41 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:17:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add dt bindings for flex noc
 Performance Monitor
Message-ID: <20191205181740.GA26684@bogus>
References: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 04:25:50PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add dt bindings for flexnoc Performance Monitor.
> The flexnoc counters for read and write response and requests are
> supported.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> changes from RFC:
> moved to schema / yaml
> 
>  .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> new file mode 100644
> index 0000000..bd0f345
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause

() around the licenses.

Are you good with GPL v10? Make it 'GPL-2.0-only' instead.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/xlnx-flexnoc-pm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx flexnoc Performance Monitor device tree bindings
> +
> +maintainers:
> +  - Arnd Bergmann <arnd@arndb.de>
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This should be someone familar with this h/w (you).

> +
> +properties:
> +  compatible:
> +    # Versal SoC based boards
> +    items:
> +      - enum:
> +          - xlnx,flexnoc-pm-2.7
> +
> +  reg:
> +    items:
> +      - description: funnel registers
> +      - description: baselpd registers
> +      - description: basefpd registers
> +
> +  reg-names:
> +    # The core schema enforces this is a string array
> +    items:
> +      - const: funnel
> +      - const: baselpd
> +      - const: basefpd
> +
> +required:
> +  - compatible
> +  - reg

No point having 'reg-names' if not required.


Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    performance-monitor@f0920000 {
> +        compatible = "xlnx,flexnoc-pm-2.7";
> +        reg-names = "funnel", "baselpd", "basefpd";
> +        reg = <0x0 0xf0920000 0x0 0x1000>,
> +              <0x0 0xf0980000 0x0 0x9000>,
> +              <0x0 0xf0b80000 0x0 0x9000>;
> +    };
> -- 
> 2.1.1
> 
