Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21015C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC838205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251217;
	bh=LL2tMt/QTU1FF7eFmIMMBMercDbce+P0lky9LobqcEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VQ6Q00hlCdd5LEMe5uueiXesMEzI3SF+0S5wAsQqFqvLlBn8rUNmWK8XFj4rLwaRu
	 gFABCaXvB5iMX6gK60pNmEHt/C0aF9g8JAFrX64ngDFVFwuC2H3JQiIQGGJeTv7chi
	 /1YMH4LB81Ib2UbUwAN3dq7QHltLK+oYX2u/nKms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEGRqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:46:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45073 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfEGRqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:46:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id a10so15758189otl.12;
        Tue, 07 May 2019 10:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Myxb66Yp3sMZ2TLPq+YdrLIlu6RwJJHWmwtQM41epjc=;
        b=Q5Tfah82uw1HyEgQqGAKFUpssCpgwtjGGRAPB5z1pIOCNkZbMPilKXVWQux2nrDQL3
         /4cWh0MWLzH1S5lDbzaT3aO8as1FlHFsVKame6RxocqsBB9vQ0j0ndb/gS1YlEYGPq9n
         DmKOCfP4LPQKjM8F3Vxbf8B9sqx+FxMX7n5ANQz6gFa0NFlS3e3S7gb+QsmpJ/yrxyLp
         r96+9Az+JWVhALwfhOaWwXloEppqj35HAPF1yNkC6QEnGtdg7ctgMuW/4yCC6CVCkDG8
         jTXDrhjApfKEESPRmmKvoYhESQujHD9arlRc3BacZ6haA2MYLFHcbVnoxnUHcX5hKzTy
         cMPQ==
X-Gm-Message-State: APjAAAVYyy5MGgCIO0Wu6yLV0UCF+KJH4fYE6SmjyqL9qoWlXXjBz9B4
        llUemONCkVoGvNUxa4Qj0w==
X-Google-Smtp-Source: APXvYqwTS640dwn1RKAsvuxiayzfx4BP45TkywltPuJ/aOR7tM/OmZRe2iIgZbXXQu0UzK/wsbcymA==
X-Received: by 2002:a9d:6a97:: with SMTP id l23mr4141510otq.253.1557251214210;
        Tue, 07 May 2019 10:46:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j22sm4120382oib.39.2019.05.07.10.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:46:53 -0700 (PDT)
Date:   Tue, 7 May 2019 12:46:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] dt-bindings: mfd: max77620: Add
 system-power-controller property
Message-ID: <20190507174652.GA28411@bogus>
References: <20190505154325.30026-1-digetx@gmail.com>
 <20190505154325.30026-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505154325.30026-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 May 2019 18:43:21 +0300, Dmitry Osipenko wrote:
> Document new generic property that designates the PMIC as the system's
> power controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77620.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
