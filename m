Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C464C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3064D205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576279755;
	bh=5KgkfeZCWcrtZ21D9zEIk3rri0eVfx4QCWFR4HOokpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l0/SjgWZbZ3f1Z9uY6z5z76si7Cfr6zO0OJ+K4UEx6k9qLpmi1yy2hHAhZAhLayZa
	 mZtd/Alqb/V50RUegaq+pkWhsLswf0QMVpcl9dz2F9EaDxxDmNU3ZInzI1ag2dWC2Q
	 rczZVE1yp1nqne+DoZAHa3k49UZzrHKOs7BT/JuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLMX3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:29:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46018 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfLMX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:29:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so2051949oiv.12;
        Fri, 13 Dec 2019 15:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DXJwQPhSwM1+cucOFg3CYds/NSYGmXNcRDzsn2xt8Tc=;
        b=jsWU+R1PoyL1BUmFVst+oZIC7hIqC+zi9Ng3Dgu6dIG1xX1xE/HFnwj4HsU3xmJbD1
         NllDrWvpdKvvm75aCcFKPw9/0oq2YX7JGbTgVSTUKucz7fldd+4zF09bTeXta3WZBtIc
         nQAhjrr2Sz69Jg3ufpTQlgEcOYMUd0XE5PM90Elk7mud7fppvYeuVIf4d4oWzPX9TK1A
         xGSMUQMiYwYp3MfJDRrpbKCeqjocQha4+eONt3EtE1+EOcE3ojbuWYXqYiOXsXjzGwEY
         axfoB0XRWRh4rC/BRfUZhnC+bIJYn3EDtaxr8igvIeJ3FRbGXV2cqExA+rj/urdveEf+
         nWiA==
X-Gm-Message-State: APjAAAU97JdTGQFEmwIE9AyNBYtvs7feYY9t3wvctsdq1wQzA7rak6/k
        Cn4HG6LSQWKdybg5KTncVg==
X-Google-Smtp-Source: APXvYqyFi7kee8lkyjSw4gkTsHA5YEMwIJOCDy42tK/sBpC3CtzjbDjua0Z+vcUr1fu145eAoBD+/A==
X-Received: by 2002:aca:5ad4:: with SMTP id o203mr8130704oib.73.1576279753143;
        Fri, 13 Dec 2019 15:29:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y139sm3906864oie.18.2019.12.13.15.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:29:12 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:29:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: panel: Document Frida FRD350H54004
 LCD panel
Message-ID: <20191213232911.GA24142@bogus>
References: <20191202154123.64139-1-paul@crapouillou.net>
 <20191202154123.64139-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202154123.64139-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 04:41:22PM +0100, Paul Cercueil wrote:
> Add bindings documentation for the Frida 3.5" (320x240 pixels) 24-bit
> TFT LCD panel.
> 
> v2: Switch documentation from plain text to YAML
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../display/panel/frida,frd350h54004.yaml     | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml
> new file mode 100644
> index 000000000000..a29c3daf0c78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/frida,frd350h54004.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/frida,frd350h54004.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Frida 3.5" (320x240 pixels) 24-bit TFT LCD panel
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: frida,frd350h54004
> +
> +  power-supply: true
> +  backlight: true
> +  enable-gpios: true
> +  port: true
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - power-supply
> +
> +...
> -- 
> 2.24.0
> 
