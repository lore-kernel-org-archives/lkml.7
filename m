Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129AC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF41020869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556319126;
	bh=RolBrucC1nqk3MBTk54fltGG4egmM7SVYqUp/DR9+qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C7gdibz50Gihc+cKMDsELnIxsrTGFDKUXHTaANGefCYYrGCrgfrlfY82euSq8GsJ9
	 E3ouZFbGSRSg4wDvRYGL8+T5ckLBcycVOzr+Pni5xS6x7KHAdNJzJtPwqeRgQAEmqr
	 BcYpqLX9bxtpODhr+3WxJX5GTWJ7E71pAbSr2qAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfDZWwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:52:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45582 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:52:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so3987769otk.12;
        Fri, 26 Apr 2019 15:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mtYtwFIbx8S3depflq3BptssYAP1IFscU7Wb7r0n4tk=;
        b=s6//5Eo8ztO3oHqdhUeOB/V9q3ZxOK+ds6GFVRhJ4Lk/QdcyS+UgQdMqbBXQ09mg3S
         qpbsQB9P6sAdZU01/9Iwok6+J3jD+oO00qTO3LGdDBwZliaLswiHeLlwn8IrG0mwO+KJ
         S5YxxBmQFZoJVQtzfqTg0s/lP7z2OWjJVqQE2BiF1TGAPgiceLki3S5nDEWWIlkfwAzS
         FOoKmkJoQU6dp3rFVA5ouborH9jyNj9IgGdv37mda0hrmpNMpPyXHyIT/v6+zqs/4OqM
         3yd13qRWk3Vk3+pbn3ZgarfnW4Gjl/2VbrB3x48c6IMdx5ZxG5FKg4FuZorfofsAANfM
         /6CA==
X-Gm-Message-State: APjAAAXn8Rd+g8QUjdj051m3fLRBzyhnWx12OdZ2q2D5wFpIpnCJ7ejn
        7ihfzDkr1ozR5g0aek1yJg==
X-Google-Smtp-Source: APXvYqxlU8W7bOcJUhv1rMYWYXbGCZnZJIdC5N5ocIAfY0pycnVzzdsv9Ds6gtmAx4J/iPDOsrnciw==
X-Received: by 2002:a9d:6014:: with SMTP id h20mr1605379otj.8.1556319123645;
        Fri, 26 Apr 2019 15:52:03 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h8sm10796866oti.64.2019.04.26.15.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:52:02 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:52:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v3 2/8] dt-bindings: gpu: mali-midgard: Add bus clock
 bindings
Message-ID: <20190426225202.GA12379@bogus>
References: <20190417173031.9920-1-peron.clem@gmail.com>
 <20190417173031.9920-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417173031.9920-3-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 07:30:25PM +0200, Clément Péron wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Some SoCs adds a bus clock gate to the Mali Midgard GPU.
> 
> Add the binding for the bus clock.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

The panfrost driver is merged now (to drm-misc) if you want to add 
support for the 2nd clock.

Reviewed-by: Rob Herring <robh@kernel.org>
