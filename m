Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA226C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747EF20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553801769;
	bh=g/re4nQdiqnPdqGi9Kz+VIeTcUI2H/zAcvXUVzCHGZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PqpT6rLvzOoqltyjCyg0jHb54mHz40GSlRDI925B1j1IfVcOPQ1FxP6hgs0hm7rds
	 DOUm8ZwYjdSgjbOOKFwguTuQWLWHy4clVBO7boCOAUaQwxbuqMcs+kQsohDqW/n7lR
	 X4D3jrpMEQeYco2wEuUao+JCPMGeIAIKioXXGtdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfC1TgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1TgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:36:07 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 986C220685;
        Thu, 28 Mar 2019 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553801766;
        bh=g/re4nQdiqnPdqGi9Kz+VIeTcUI2H/zAcvXUVzCHGZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1Tx7/3l/HHWPWKM8KUD1hQNLWIsdyVU5ZBF/wXJ/U98ZOu1jIEIRwYeqiG+/ArHOU
         blN44x6a/gzbeYVx51StZTB0NmNV1Ob5c16oaxJc/YK+fs+7raJrHsfsoVzWzuvulb
         c96x+Otfjn7C8u15dU8v7fdMNGM/c246qLRKAS/0=
Received: by mail-qk1-f182.google.com with SMTP id a71so6633019qkg.2;
        Thu, 28 Mar 2019 12:36:06 -0700 (PDT)
X-Gm-Message-State: APjAAAXeEyuv13OVa0COa2EqnlPiu+LUIKMwKJAm1u5a+dcYfy7t1r/9
        4LyDOYFqEAAbOo7jaiU0pyLAVn1MsZV4fZ3t5Q==
X-Google-Smtp-Source: APXvYqzDn8U5DDp91/QoVnCUmayh8pm+t77ZW6TTLvwRIGL2mRsb51Uvcc3AzEwIp3Yvpjl7LAGOhtkqZI2yB4CP6kw=
X-Received: by 2002:a37:9186:: with SMTP id t128mr7468783qkd.326.1553801765844;
 Thu, 28 Mar 2019 12:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100521.29109-1-maxime.ripard@bootlin.com>
In-Reply-To: <20190318100521.29109-1-maxime.ripard@bootlin.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:35:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
Message-ID: <CAL_JsqJ_LYycXazkdP2Q=e-jynKiX+z5En0bz0AWpDjsevwQTg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: cpu: Fix JSON schema
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        ARM-SoC Maintainers <arm@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+arm-soc

On Mon, Mar 18, 2019 at 5:05 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Commit fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for
> Milbeaut") added support for a new cpu enable-method, but did so using
> tabulations to ident. This is however invalid in the syntax, and resulted
> in a failure when trying to use that schemas for validation.
>
> Use spaces instead of tabs to indent to fix this.
>
> Fixes: fd73403a4862 ("dt-bindings: arm: Add SMP enable-method for Milbeaut")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>

This should be applied to arm-soc tree having the commit.

Rob
