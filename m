Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBCFC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C8B20659
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570664345;
	bh=W3G4KTSSpqmZrxhiG0pOYSBaylzR8WekLZ1rgdVr1LQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ttPqoo5ffL0dHw1HKYjpqKywkQROK3uCqz7/WnqOivqjGGhsX7A/kOSGMSylQBP9Z
	 MYrGFo2uPv649OUyzlCuefVor6NdXGRDk3n/MYYetUdmbEVLfOuo1qv1zx6YwxWj/6
	 L+vDGDakhOcO9XA8enVJFSb/EKmSu6aU+0dZeqyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfJIXjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:39:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39090 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbfJIXjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:39:03 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so3264356otr.6;
        Wed, 09 Oct 2019 16:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfaJ6Ijz25Td45/swhL0HWSOcUtcHLc6emBFBS8WyOw=;
        b=OEY6TANIdUuhE+RSC6Pbsxp3LQyjYHeMha53H6E33t5DbUx7+wFgwi3COa7rK7J5lq
         I5UIVXy1HuNywPM3YFBTLJ2FfGEHlyXex3ac2Vs5bVS4/aXaBN9My6mdQSRogcOPJIIV
         vohOSnGmS/xnoAb/aFp8WmzPKjAMSGy0QXMnkOP9KkWd8EPM0nbZoQsb2ck/Q59aQRIm
         ch2uUBAUd3Zrq5lfWvXH4KEOy/cwwlErzi4AsJsWf96BPoF4O/aBZm1q05ahHlQsQWon
         dFpIrOwDGb7kqVk1Y+Hm0/GwfiobtgJsco3tj8ICNG2pLEcHBVusq2YTgSFNXSdpZbjd
         2pHQ==
X-Gm-Message-State: APjAAAU0TX5zJY4YM8OS6uQlS50oz8BU8IMSqP0k2blqw1mMmNDFDSja
        t5waIJ7RvcMMuGoPoy/KhapJ6mQ=
X-Google-Smtp-Source: APXvYqzIQcdECP7sHtBSpJHI+jFCabS62ZfygcOXBQjYhZ9NsnTSnmOMd1i74eKBtoiTh3FE9+h9lA==
X-Received: by 2002:a9d:620a:: with SMTP id g10mr5343743otj.318.1570664341395;
        Wed, 09 Oct 2019 16:39:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b5sm1149915oia.20.2019.10.09.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:39:00 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:39:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20191009233900.GA9109@bogus>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009024343.30218-4-jckuo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
> Extend the bindings to cover the set of features found in Tegra194.
> Note that, technically, there are four more supplies connected to the
> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
> , but the power sequencing requirements of Tegra194 require these to be
> under the control of the PMIC.
> 
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
> possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. To deal with
> this, a new device node property "nvidia,disable-gen2" was added to
> Tegra194 that be used to specifically disable Gen 2 speed for a
> particular USB 3.0 port so that the port can be limited to Gen 1 speed
> and avoid the instability.

I suspect this may be a common issue and we should have a common 
property. Typically, this kind of property is in the controller though 
and supports multiple speed limits. See PCI bindings for inspiration.

Rob
