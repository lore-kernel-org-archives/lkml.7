Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1DDC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D64C218EA
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014471;
	bh=Koqqnz53dz+5g9HvlLNg5i2qjPky4tBcM4ZuU5l8S2s=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=gx6RjetOhc9rdMW5zFS8VqpSMOK0srUdQalAKOP1+UZ8BV85XLiWpK+mFiZ2Tfs9P
	 90o0wfb08bcc7FFIGsHXRUfuExYD0jsdb4YNRJO2U2m1dwPCPfMelN6ACRgbI6auIZ
	 NK9D2DuWjL9F9qSY3uvBoBvQHHepg/Mk/a9Ih1GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbfCaGlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfCaGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3so3143954pgk.12;
        Sat, 30 Mar 2019 23:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=ZpgGUCqxuQpGk62dSSiHph6XjK8orHXc7xsRUZLJqe0=;
        b=mss7/BOwsJxLk1XtALUI6F4LRKbWxBRCICOs1ZD9Nhijcqyx9epQ1IilDsrH4ALMso
         LYitSiMgn7T2RCoHtDXpm1wuYCnekiAQkKwziMKp779YKQdOwbp1qVWD/Q43iT6uePsh
         Mfnf42qtHJ8AYS/crdRXgeZlt3L/MoDkGo9GKDocjuhOW6zRggKuV+gPuTwcq3e4+gXf
         Iq5hsP/jy7E1dxZb6g/4cLOnUbpE3PJi5CNEMQYEEDqAy2BZ99DNtAgWQnmIVAUMOkWd
         q9M7WSYlRWt/qQ5NK4+FQ5MVioMrnzXxuxrBDRSZkwcyWmRCVV2UX/R3b3dfGubGCFWT
         PGYQ==
X-Gm-Message-State: APjAAAUuIeOVgF9kzbvb8QyEiJjOvVup019Gsm2S5oADS0eOWTojVUQC
        Ag1MwQC3zejRdDHe5qPlKw==
X-Google-Smtp-Source: APXvYqx4ec9vIlEG1P5IUKGvPeDJPyE1Qu/jLVu/rNLVCtlqDBLGihx9cHUceIT5YrzIi+XzGD720g==
X-Received: by 2002:a63:84c7:: with SMTP id k190mr54559022pgd.255.1554014467266;
        Sat, 30 Mar 2019 23:41:07 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id 20sm8982861pfn.131.2019.03.30.23.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:06 -0700 (PDT)
Message-ID: <5ca06102.1c69fb81.44711.7b74@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:04 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: g12a-aoclk: expose CLKID_AO_CTS_OSCIN
References: <20190321092010.14382-1-narmstrong@baylibre.com>
In-Reply-To: <20190321092010.14382-1-narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 10:20:10 +0100, Neil Armstrong wrote:
> When submitted v2 of the G12A AO-CLK IDs, the CLKID_AO_CTS_OSCIN was moved
> to the internal non-exported bindings, but this clock is necessary for
> the second AO-CEC-B module since it embeds the 32768Hz dual-divider
> clock generator unlike the AO-CEC-A module.
> 
> Export it back to the public bindings.
> 
> Fixes: be3d960b0aeb ("dt-bindings: clk: add G12A AO Clock and Reset Bindings")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/g12a-aoclk.h          | 1 -
>  include/dt-bindings/clock/g12a-aoclkc.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

