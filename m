Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADAC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FC1206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782276;
	bh=UognCO9PhPJNz6xOFitRmIm5rhlH3RIdFpJ0UCckXsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m71purTgq2bJSDuUaMfPHKvY+41i1x7t1Vx6eJ+Zgtlb9+HX75cq7WeRNoo8j7DRe
	 tv7KCGi7jmcepsVmg5uuYDJ7ORK0x7hsLL17rdxiIaE2SyXXEFdNP9Hg9Me1Uz09y/
	 2WwlAXh3NpuyqcX8kAtbIQTl4nuJXbv3Zp6j6msc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfLSTEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:04:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45293 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfLSTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:04:32 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so8416380otp.12;
        Thu, 19 Dec 2019 11:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TwLMjIi0ztUcgqXnz6W6DiP3C/BFPmUt8EF/msCgyo=;
        b=MtQALT4d2mqzgjFYhGUlBfrkM3EXSaAHHdxBTaPWuq1Q8r9TkJi057D/flwWhqRQI5
         rL34sGT0RZ/7x95q4y4mX9aFuwG77bKLjSM5fJDx2Boapv5g3zPfsYVlDr1fGmEJdg17
         vLDmg/0EL0QhoiKcn491q3prUDgsnCrhzOrM4/SbYiBSWdCuSLMfLmj7tI2tv67o7Dik
         pb2iabObuA1UkfzOixDA96Ns4vaVD7aofN9Vm3SFKfBSPlDd+6z73hOj8gp6rCyCSu9Y
         TCMC7N9pMCsBV5BM/vlPrxpPmJ5vh/QfEEhwxWltu54X6Lf06vVT0G104cSyM0OqvltV
         KQOg==
X-Gm-Message-State: APjAAAWU/tHcuUveANex3orAPqbC5j3HfWyT9WTOoo/khh3gtB7W7XYb
        EuBq1DNPoVGFLVwqR0j+wSUks+frbg==
X-Google-Smtp-Source: APXvYqzXMS+BPPjyZuUTUxZ0kvBQRUp13g/7NP8niTT5xFM1Uguo50OG2xZFpz1MwnDNbqhaPlAKEA==
X-Received: by 2002:a05:6830:22e3:: with SMTP id t3mr9837378otc.193.1576782271973;
        Thu, 19 Dec 2019 11:04:31 -0800 (PST)
Received: from localhost ([2607:fb90:bdf:98e:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id n19sm2284468oig.57.2019.12.19.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:04:31 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:04:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jyri Sarha <jsarha@ti.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tomi.valkeinen@ti.com, praneeth@ti.com,
        yamonkar@cadence.com, sjakhade@cadence.com, rogerq@ti.com,
        jsarha@ti.com
Subject: Re: [PATCH 1/3] dt-bindings: phy: Add PHY_TYPE_DP definition
Message-ID: <20191219190428.GA16167@bogus>
References: <cover.1575906694.git.jsarha@ti.com>
 <89dfcd484bad19cb954ee4f74305d1aa172ea292.1575906694.git.jsarha@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dfcd484bad19cb954ee4f74305d1aa172ea292.1575906694.git.jsarha@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 18:21:09 +0200, Jyri Sarha wrote:
> Add definition for DisplayPort phy type.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Reviewed-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/dt-bindings/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
