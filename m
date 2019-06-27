Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40613C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAA7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561643747;
	bh=uTleRMj68PEOX/zILdcxvMLWtEkBME6iCbjoAjj0/A4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CkwfjrdNGZ9MTIZS3YrUfsoteosw2Kp3gQzSyPVTrz40zk6gjpOe9MIfsRElAZWuf
	 IeuvbXlVdpoF/5N3VVpMWbcmzKg/OseqinhCSC2o7TvH3KrEQy6BPFTEYRyVZAdJqG
	 KLhinJWhgg8IhEhzMamwKYH8UkqDfeOCheWxVe1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfF0Nzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfF0Nzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:55:45 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141392084B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561643744;
        bh=uTleRMj68PEOX/zILdcxvMLWtEkBME6iCbjoAjj0/A4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bjLy8WDBSIBfYyZJouoBgVhJ0Cvxmzp8uOzX7EvqlW3kVj0acTSyhygOjC5ee4JB9
         SNceJtvVlkD4toOgnfqp5PAcPvGb0VVwiGTl3iNkTFAbQ/e3wxublBDOaHlvwXAhaF
         OWg/hf80F+RNeEzirm8BCz83s/Pwigfj35gskhTM=
Received: by mail-qk1-f172.google.com with SMTP id t8so1782704qkt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:55:44 -0700 (PDT)
X-Gm-Message-State: APjAAAXZrvyLE/om36wTHyNv+xQXeqvlne+pNy3zIirqMHAwrRjWgMlv
        6j4WH1x6STPM9bpCkLgYi8yQtzyyuWpQWE0EdA==
X-Google-Smtp-Source: APXvYqzg/jW1jm7GQY+Oshi4v0GAZ7WBCwBkSVkglonUko2w4noTPXEInsOPXOw9boX8rZhQHsx41CzfpBf8MUBL+zM=
X-Received: by 2002:a37:69c5:: with SMTP id e188mr3261995qkc.119.1561643743354;
 Thu, 27 Jun 2019 06:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190627080959.4488-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190627080959.4488-1-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Jun 2019 07:55:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+er-MZY-Vuez3B48fb05AH9UzNZck=BK6xHutuXdfDTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+er-MZY-Vuez3B48fb05AH9UzNZck=BK6xHutuXdfDTQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: nvmem: Add YAML schemas for the generic
 NVMEM bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 2:10 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The nvmem providers and consumers have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>
> Hi Greg,
>
> Sorry for the delay in sending this patch, as this was a licence
> change It took bit more time than expected to get approval.

But you didn't update the license to (GPL-2.0 OR BSD-2-Clause). See below.

>
> Can you please consider this for 5.3 as we already had other patch
> in next which reference this yaml.

TBC, DT Schema checks are broken until this is applied.

> +++ b/Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0

> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0
