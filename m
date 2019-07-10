Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909BC74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AD020838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562766779;
	bh=zrEXgU06V3HSBHWapw594JuvhYnamH5a5R6f/0YmUgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iJoKbYOEqHGzrsMpcevw/Ygb4yDyOYHFe6b9q5M4d+nEA7BFnaOiApx7bpcv4m4ZP
	 A05R2phrPZszo22L8fi/UbWKdJ33v5E173K8HrmyRgmkjdyOTsgs9i/L+jjuVrR6vZ
	 fA8CegFxMZPi4T5HMZInMUsv4IKflmR35Mpul+yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfGJNw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:52:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43701 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGJNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:52:57 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so4804151ios.10;
        Wed, 10 Jul 2019 06:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sQ8qUL2tXP29Ld9BiqDZ7FWck10MSCLGC0VK5gjO5o=;
        b=OGRJ729e3uwGg1HUiBT0+dGy96bM36n5pRuYYxH2yhJeV7TSCicNx3+8DRgcbVu+4L
         abUTYZu0/A1pxy+s9Osp1TCV68vvCizol+Z4R9kSyljxGPbwPgxKr2xhfqb5WwICRkVy
         1/sDMD0Ho72o+RuzYbYk2QiJgw7vhvt5XshoB4laA1mTC6e7gTuHwJMxP7LtCjStdAPK
         ehjkWsvsdQC9eh0xtBUR60YGi/9T63enysEU2Gvqha2FT2FC9kbPG72dgXcbjc5GBraT
         We59+VZA1CKb8Nh1acbbcaex1KKhMOXDpMapuqlLWur5MJuzZjeW4BWO5aNS03YsQjuK
         aJag==
X-Gm-Message-State: APjAAAUY8KhEykvweGT5NJLhaB6NH9BCce2mV/VfOmIWeZ8k3CWaqLvf
        5MYb//TZyK3j3BZn1BfUCg==
X-Google-Smtp-Source: APXvYqzRTXXDXm5+lNWb2TKj4hTvtu33GlKZXAbnlGua/pqd3BhOV1uRDSTpKXcaYpwC4fb6DQDIjw==
X-Received: by 2002:a5e:d611:: with SMTP id w17mr12659726iom.63.1562766776311;
        Wed, 10 Jul 2019 06:52:56 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c17sm1663390ioo.82.2019.07.10.06.52.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 06:52:55 -0700 (PDT)
Date:   Wed, 10 Jul 2019 07:52:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 1/4] dt-bindings: iio/adc: Add a compatible string for
 JZ4770 SoC ADC
Message-ID: <20190710135254.GA30741@bogus>
References: <20190623184732.5492-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623184732.5492-1-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 20:47:29 +0200, Artur Rojek wrote:
> Add a compatible string for the ADC controller present on
> Ingenic JZ4770 SoC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
