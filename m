Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED86C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50246208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560203104;
	bh=/OAK+wgX00BvEO/5xuEo21p7PZVrq3kJQYAtsMVK2cQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dBia82KeNjCLVR7OL17pllOUIjK8te/oxmXbuj6rxlGchFemESGm9+uuvXlutT/s+
	 W6muV027O95K+OLpiixz6FO9P6of+p+fd8sWlpUnRulJshxCMCX0zxyrFLoVj+K0TA
	 bwyzg00HHpKOVfyaz5at+4df67EPhe7M+LCjfdWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbfFJVpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfFJVpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:45:03 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B4720859;
        Mon, 10 Jun 2019 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560203103;
        bh=/OAK+wgX00BvEO/5xuEo21p7PZVrq3kJQYAtsMVK2cQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZBpwUbOWxSeH+0Pzbw2QR+lNr4UlyjDtx6P+G5vkqXUuy18EuVTVg05yDPIO/r+6
         aCvLC10NDC+PJ6etbhLlDCy/h9Ov8rPw4w7W+AqIovjG2CYRqdM3C7Ob7q1PwTeAcd
         eDRHLfo8wuQs4qMYHxAkLOt7oIeQap0GS6+DrsJM=
Received: by mail-qt1-f181.google.com with SMTP id a15so12139768qtn.7;
        Mon, 10 Jun 2019 14:45:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXHoPIR1lHdHaDe+5b7S9xB8GEE3sy/qrMrE+YIq1UzWlMSXPm1
        CS22NA6pa/kOb+Y/KErNUyjderDS4GCIMOAbzg==
X-Google-Smtp-Source: APXvYqzP/smCdJM2r7zYkv6EMMywIyWDi0CbUbkg3kvV0vqRtj3TIU4OoDXxhmFWVdQID4xTkY3MYji0R7fjfCZZFaI=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr60371707qtb.224.1560203102240;
 Mon, 10 Jun 2019 14:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190602080500.31700-1-paul.walmsley@sifive.com> <20190602080500.31700-3-paul.walmsley@sifive.com>
In-Reply-To: <20190602080500.31700-3-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 15:44:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Lx+SBZ7_+0tCYJs+oA2zR9c+q2XdmFbEtpWxoLXVibg@mail.gmail.com>
Message-ID: <CAL_Jsq+Lx+SBZ7_+0tCYJs+oA2zR9c+q2XdmFbEtpWxoLXVibg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: riscv: sifive: add YAML documentation
 for the SiFive FU540
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Paul Walmsley <paul@pwsan.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 2, 2019 at 2:05 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Add YAML DT binding documentation for the SiFive FU540 SoC.  This
> SoC is documented at:
>
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>
> Passes dt-doc-validate, as of yaml-bindings commit 4c79d42e9216.
>
> This second version incorporates review feedback from Rob Herring
> <robh@kernel.org>.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/riscv/sifive.yaml     | 25 +++++++++++++++++++
>  MAINTAINERS                                   |  9 +++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

>
> diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
> new file mode 100644
> index 000000000000..ce7ca191789e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: GPL-2.0

Note that the preference for new bindings (or old ones you have
ownership of) is to dual license GPL-2.0 and BSD-2-Clause.

Rob
