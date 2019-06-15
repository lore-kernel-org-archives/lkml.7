Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30E0C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF572183F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfFOOr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 10:47:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42899 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 10:47:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so8179024edq.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 07:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=TzjhHeA4UQZAFu3IO7OhtCMGptw4ykhDZuWZdORubpw=;
        b=FF3WfvpC3CuurKmiNy2M84Ia+5UHImiyMIV8/0HThgihF/yPxg+AHtNCGeehuQCzr2
         CxyxhisyhOPEc+IIFVi0PVkHx3IXvxOw65bfwdNyVHf1ZJz87h7zCiYEhN9PYDospJd5
         ljGcW3sjFnp3DDGA7UZL+3czJJiEtlpSyRH1hj+qgp8cvc/jstI6ezBjB7jf55NVPmf+
         mO41gyN5+INJvuY7huPIzDA0xdzOdnnETnCi2PEFxIaSO9I5EXdP3mrfWmYSz5c5pDq4
         R8/4gJ5MrsUkEQwP/z9pheiqur39+PEMYCVRsi59Ypc5nQZChsF4YzCbWZxOt/qedAk2
         7Uaw==
X-Gm-Message-State: APjAAAXhuEjnya0crMZKiYBVgsfPdJZHTu4lVs+eZLuMOHasC1aooJzh
        E1HAdefFQQDg2otmyRozFsN5CcfFZM2ntQ==
X-Google-Smtp-Source: APXvYqy91/uHnpOWdd31f07Z9HeokOran4BkkGdjbTNQeozVDRtV2oQSIbSteFcoyG7olovnY5fbcA==
X-Received: by 2002:a17:906:b2cd:: with SMTP id cf13mr39744134ejb.197.1560610043968;
        Sat, 15 Jun 2019 07:47:23 -0700 (PDT)
Received: from localhost (134.217.90.212.static.wline.lns.sme.cust.swisscom.ch. [212.90.217.134])
        by smtp.gmail.com with ESMTPSA id p37sm1928509edc.14.2019.06.15.07.47.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 07:47:23 -0700 (PDT)
Date:   Sat, 15 Jun 2019 07:47:23 -0700 (PDT)
X-Google-Original-Date: Sat, 15 Jun 2019 07:11:37 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: don't automatically patches involving SiFive to the linux-riscv list
In-Reply-To: <20190613070225.7209-1-paul.walmsley@sifive.com>
CC:     linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-244456e0-3eb4-445b-963b-213b1d3b6293@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 00:02:25 PDT (-0700), Paul Walmsley wrote:
> The current K: entry in the "SIFIVE DRIVERS" section causes
> scripts/get_maintainer.pl to recommend that all patches that originate
> from, or are sent or copied to, anyone with a @sifive.com E-mail
> address to be copied to the linux-riscv@lists.infradead.org mailing
> list:
>
> https://lore.kernel.org/linux-riscv/CABEDWGxKCqCq2HBU8u1-=QgmMCdb69oXxN5rz65nxNODxdCAnw@mail.gmail.com/
>
> This is undesirable, since not all of these patches may be relevant to
> the linux-riscv@ mailing list.  Fix by excluding K: matches that look
> like a sifive.com E-mail address.
>
> Based on the following patch from Palmer Dabbelt <palmer@sifive.com>:
>
> https://lore.kernel.org/linux-riscv/mhng-2a897a66-1f3d-4878-ba47-1ae36b555540@palmer-si-x1e/
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..66d23856781d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14332,7 +14332,7 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
>  L:	linux-riscv@lists.infradead.org
>  T:	git git://github.com/sifive/riscv-linux.git
>  S:	Supported
> -K:	sifive
> +K:	[^@]sifive
>  N:	sifive
>
>  SILEAD TOUCHSCREEN DRIVER

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
