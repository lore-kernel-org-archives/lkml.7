Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41075C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021F921873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014459;
	bh=voqaBLUr6Gk17WLIJ13GJwbFBO4GG65KYNmZKB24lcI=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=YkOiwsVoDVmaR5EFaJV8mibZxbihTMZdGBbsbYwnYVw+QK9OydqZfs6ldyK45qvhX
	 v33FbyqLvQwT8SeD8xjAMdDozlifn1ZtYB9RQ6Aq3zcKrnwTfMWjHyHf+yDppdMwU/
	 vwcTceQQDxAsx0G8helsEIL/E1rs8uTPZpwFDDIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCaGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35378 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfCaGk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id p19so2940852plo.2;
        Sat, 30 Mar 2019 23:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=vBTLbpvfSlT7Nmroa37jN1/4Oi+mQbMC6lQJ8c2JuW4=;
        b=UwUQtMadbMsBc1wPvi49PawNPxuF4hraTyy3uO7Hl7NMJxZn4zWf5IvMzYQmIUfk/Y
         GsKk0tD9tCMPjsQsSr7ExPz1wodd/9wcGumEseCXagK6Z/BJcD75j60enk6OxhmXKvt4
         2dlYWPSdoixiCXENkXz3TGPSMfRk9wAfZWft7BIiH0oLNVAM6JyWHIjdPX6fMuqzviNv
         /aahnd4kxrWUakx82aYdvgxyDpaIK4FfApfCBHlhHKUKjeeu6s0tMl8dG2dAJboVNEAd
         hIYL/mfHSXOmshmFjQ308nHuhLgDeyoqbDoI7wNdpKLGvU11xMDJDPkyqUVyFUH50cww
         Gozw==
X-Gm-Message-State: APjAAAUR5aA58sg2uwcxtbo95XbwHqLsm37tMWtg2Kgi3dZMKAPSMuUg
        5T4NJToqConTg66NQ3ljcA==
X-Google-Smtp-Source: APXvYqz/ksrDxoAGVpZ4k0r5UimSJQvp59wHRuIX1ZNbszg+bcQGyMeW54SAs+oqlJpDCMLJXwpmiw==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr34415487plb.71.1554014455367;
        Sat, 30 Mar 2019 23:40:55 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id p3sm13209052pfn.167.2019.03.30.23.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:54 -0700 (PDT)
Message-ID: <5ca060f6.1c69fb81.1c625.e55e@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:52 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: jz4725b-cgu: Add UDC PHY clock
References: <20190319140536.27945-1-paul@crapouillou.net>
In-Reply-To: <20190319140536.27945-1-paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 15:05:35 +0100, Paul Cercueil wrote:
> Add macro for the UDC PHY clock of the JZ4725B.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/dt-bindings/clock/jz4725b-cgu.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

