Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392820882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014550;
	bh=pf4lCVsbAI2hot05Mg/HERBp3KpHWgx2LstAkktGGCg=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=g30yuP0GPTxKaqQypHH2Lvhr1NEl2q8/MAJKVaL99tDWYAevzE2bihTzYkB7uqHSG
	 CVP/Z7j8/UVnzkBlvVDoaQyOeMFe78HVCLiTp2EWUqHA+Cn4Xsdwsme+FFxn45igjy
	 59e+HjGkDUH6J5sekF0tTzdIOxe8TEeP7yE9ITZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfCaGm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37103 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbfCaGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so2987144pfr.4;
        Sat, 30 Mar 2019 23:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=QU541pyfRvcoiA6ZnYnuhfOmIAIAECvLFUcnFT05Vd0=;
        b=tBgX8EjA5xMp29fTRonDECIB3gjlIkz8stsqVBfWwKG06oP7Pj3TvLyW3g7JulnAwP
         rbFeBZ0tNj6jtz7rFqFLm8jNnqBZf/XJjoS6OlmpeUGu+SvNFg9zjh4AmM5239D7fQXS
         k8+VkMYpf9PNzSwsoPS103YtFXpak8wwQRCk70HcwvmML21Po/t+Tdv/c+xC6bC9QVxc
         q+cI+l89O4Od9/KbYmOYVV+jLa/NOebhRKRCfXj2/1O5SGHAPsOAHxI/47WSPMsykFax
         j6gMs++EYwrDiRlTxQ2yO3Z7tQ7vBwKYhRyuhaQroGMJVTvJxsMFtOiALJKuDvygR14m
         +dDQ==
X-Gm-Message-State: APjAAAUbBtJ5GkJtwnXmydy9BuZSQ7ZGyYGV/c+s1pW4okwhhI9kw3oL
        86zN7k/Uxl4B4N7ehNF2mg==
X-Google-Smtp-Source: APXvYqw75xoOAmvkaIpm/CZkgt7Ee6Chr2cARyGyw8/gQXdvaDGxENfsXxFE+csr9OOViaLCjriZjQ==
X-Received: by 2002:a63:b52:: with SMTP id a18mr55103576pgl.393.1554014547651;
        Sat, 30 Mar 2019 23:42:27 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id t190sm11714904pfb.33.2019.03.30.23.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:27 -0700 (PDT)
Message-ID: <5ca06153.1c69fb81.fbb4c.ca34@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:24 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 6/7] dt-bindings: gnss: Add u-blox,neo-6m compatible
References: <20190327001843.2420-1-megous@megous.com> <20190327001843.2420-7-megous@megous.com>
In-Reply-To: <20190327001843.2420-7-megous@megous.com>
Cc:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
To:     megous@megous.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 01:18:42 +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Add compatible for u-blox NEO-6M GPS module.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  Documentation/devicetree/bindings/gnss/u-blox.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

