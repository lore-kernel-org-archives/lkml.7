Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B923C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283B42064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562766800;
	bh=0ch6eKZRxHr4vh9HcKuVUbktjztyZxsY+iKS/rc1aMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=egL/6p+oEdqFrnyXEBK5IuFlL3a26fxFVwCoLLhVhHl12KLsQlPsqD2EgnALZT6Y/
	 qsktftPvk83eeEr6zM+hEJboofCTLOwUiwlO0byBuMxGNfxZ7aEXXIpvWWiGHolHiE
	 pbZuog36dT16gE3TNDvqHhJcaHl3ak4AkNrKx6mY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfGJNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:53:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39230 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGJNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:53:18 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so4861903ioh.6;
        Wed, 10 Jul 2019 06:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJFaTrOR0uVU6CXAPbL0od+sFegWooZqjYvBbrJeUlo=;
        b=uFlLGdvJ8xOKNblm7PHytWslGKTVaMbBdjIcSt6HSVZDSDs0gHJ64LNCr1tT5xrqEw
         tpIeTyekxFzN9JxlYAktlWQGL0VK+DV/dAm7aFRut1uTAUYoyHbJ00PF/y4CFNFHOJV5
         VdWYy/yumMaH1DymxmunMhH1gRAmxgYmCFd/fWe49voPpe4RSDqfdlf5pBgGuLrFCgC3
         zFtwXTey173ib28RIc0nQKVnFTvtDZP5lgSZhQlRc62qw2K1eRLiWRttx6+1QfbOoKDL
         hwZ677zNNuNcVIynYKBD599Pk4XU1EgLNMZirYyXjewyW3Jle32CzHloyiMNTbpWUOD2
         ts5A==
X-Gm-Message-State: APjAAAU6u3HYycf0jdw+3vvxQ274pEN4pRNTSLX+i1mhKXmOCz36+Xvi
        AXHx3aOaH0vKheZ+up10Xo14guzyeg==
X-Google-Smtp-Source: APXvYqx2AF/0nei3cbfT7dFpG38kefGJKPj1T+ID4FehnxB+WWV5WCu3kFHfvnW+OlydcDvd+NXfDQ==
X-Received: by 2002:a5d:9f07:: with SMTP id q7mr12661134iot.21.1562766797210;
        Wed, 10 Jul 2019 06:53:17 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y20sm1655419ion.77.2019.07.10.06.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 06:53:16 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:53:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 2/4] dt-bindings: iio/adc: Add AUX2 channel idx for
 JZ4770 SoC ADC
Message-ID: <20190710135315.GA31393@bogus>
References: <20190623184732.5492-1-contact@artur-rojek.eu>
 <20190623184732.5492-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623184732.5492-2-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 20:47:30 +0200, Artur Rojek wrote:
> Introduce support for AUX2 channel found in ADC hardware present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
