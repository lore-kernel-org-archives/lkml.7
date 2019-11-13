Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F2BC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E4222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573651134;
	bh=NWvC6eQawqOhrv/kJHol6lt9Z3/QEc1LG6PKR8Saf/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wR8WL97MLi5Pf5+x1iWU+6ONSdfU3RSxiNTv8egkuD129iGWCkvvmSyerEfWhbq4w
	 UzYuSLE6b4gby7FczrkPRMK9C+YG5RXX/X15s+QMqTW3NQ92vIFF14Lise2Nzece1O
	 d2YDDSTb1r+jIixMxWJSxGaNUQIUn5RPALVREiwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKMNSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:18:53 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34284 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKMNSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:18:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id 5so1575283otk.1;
        Wed, 13 Nov 2019 05:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iN9EGZK4z2w5uV+xkDZpBxWopf1qOwO6GVoy18ebbp8=;
        b=hIKjVukVnNkXYE/hQtiCvQ70zHCKLPFa7lZhDUMtS77+A3HduH17uTQ2+09KNpNm9l
         5l7oky7lWoVDEXpeM0G+ySMQrOPFGasvNHlIBad+ZL/LAvG5idKIbxxYl5fftV/MYL/r
         ovusW08tuUyibE3KBgFBN4uv0IXVg1AeFAq3kpgMGlycBnuIyWBCZrObvBV36haFny2t
         3EbGtY24g+y8M/a4nMlHeZPgdD4OJwEPgkyK9Y8h+QwNxLANodQS7rw59mxWbzKsAGc6
         6KM+N/sdUGsY6ZYqIsydwJQyWCryPWtpHIVf7DoYAvWmUVUpveYk3vvT95LF7qXiG+nH
         z60Q==
X-Gm-Message-State: APjAAAV6W9DLMhctBM0YJhOD1vfzPHccoNtk12kc6nRj1IybazQdfiHu
        NrXcJ3DOlcY06OwiPU6TGA==
X-Google-Smtp-Source: APXvYqxE88TW3ThguSexPGkEMwde+wXCffEukJv6uGqdZrN+yg93sqolfxEl/CarKtDibsP6dDdKcA==
X-Received: by 2002:a9d:6309:: with SMTP id q9mr2366833otk.255.1573651131777;
        Wed, 13 Nov 2019 05:18:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm696852otj.62.2019.11.13.05.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 05:18:51 -0800 (PST)
Date:   Wed, 13 Nov 2019 07:18:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] dt-bindings: arm: imx: Add the i.MX6SX-SDB Rev-A
 board
Message-ID: <20191113131850.GA11640@bogus>
References: <1573091764-20483-1-git-send-email-Anson.Huang@nxp.com>
 <1573091764-20483-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573091764-20483-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 09:56:04 +0800, Anson Huang wrote:
> Add board binding for i.MX6SX-SDB Rev-A board which is already
> supported.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
