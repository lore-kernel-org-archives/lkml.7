Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C142166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865692;
	bh=SeTXnt4Kq0pwZ9i9q/N8y5cFP/35h05XfSXXT4hChF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T2VewQnbgKgkjzJO1vdCiX3/QXSfB6ulFTDdJPzUkgIpy6hluXLbsZinq/7QKu0k6
	 iYyPASxqrN0kZShr6XHRSIjwj1qxvzzI5oW7iJ4Mp7K/cQXceJzXPCrA0udDybIsL5
	 OuZIW1YucXfTMT8hZki7+qzgqthPrWrcNMtyQwYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfENU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:28:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41398 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfENU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:28:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id y10so112752oia.8;
        Tue, 14 May 2019 13:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/xEQhRe1Pra6YVRpwyMFKIovwszsqjuMIre3+73jdVw=;
        b=BhnStekwb2faaqXnH0+BBovID7o3dRItCLSLGL1xZ8DAUxsUgXW3rWpQZpFHJ++5QJ
         dBGBuJYQeBHLGCMb4hG9IUkL3RgC2jH1aonakoyOD81fcnd4AuzpmzTHP113vauKHCAa
         Ln/PhXJ3rXFETIRyt6g4bz9FANFV4sWqympX+X/vc9cRUoRXAfEwZ4QvWx8CHPOw5NTi
         L7gvQm2qmI2jqiGocO9vYeFBYryEtGGyANoT7BD2zAVIwnmBKiiTgTilU5dsf4iQsgFq
         TlVBYssz6P+ef+gB8mPh3Ie/uM0anVQSc0CC6OhRULLxdM6cGm0oC/bk0Jjbz8bi1JcU
         4rlg==
X-Gm-Message-State: APjAAAVSMTkIwhkL8HocbR2b6japRYuqykoo4yq5Q9HQ6atl+/V/U3f+
        Kiodqzi0ya980Kh9eVvrWg==
X-Google-Smtp-Source: APXvYqwH5J0KSSwtut0OTNe86vsNzvw9QHm7hI902PxNhh3qNuE4E8bI0xQtbTD5Y+FzANVluP7iug==
X-Received: by 2002:aca:aa8b:: with SMTP id t133mr4038437oie.101.1557865690412;
        Tue, 14 May 2019 13:28:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm6652578oif.25.2019.05.14.13.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:28:09 -0700 (PDT)
Date:   Tue, 14 May 2019 15:28:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20190514202808.GA21263@bogus>
References: <20190513161026.31308-1-fparent@baylibre.com>
 <20190513161026.31308-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513161026.31308-4-fparent@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 18:10:24 +0200, Fabien Parent wrote:
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> 
> V2:
> 	* New patch
> 
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
