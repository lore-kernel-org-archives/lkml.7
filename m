Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2D120840
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839713;
	bh=+cmvwqlluwUNhZ8KrARX+f8OqWFXAllKctK4BpDHpQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KAW548gNDGCUz1Xz6NAaJQzY0oTNmUSTZ/IPLjaWzBnMRwEGIkNP57udlJzbODJSQ
	 2eMi2APNOjS6/afVd7Ii0Hty3ZCU3MInpVzjEd63gmntmdtuTWR+uaWhPkdcTlcUv/
	 bfnt8QXkWSxhia8Yj3bE8x6fJ2M4FIvkExly+0vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfGVXzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:55:12 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42405 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbfGVXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:55:12 -0400
Received: by mail-io1-f51.google.com with SMTP id e20so47565223iob.9;
        Mon, 22 Jul 2019 16:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHBF57axMXQUEa4SHufMtNzfbrwQaVINbpKbsLl44HA=;
        b=Zo2kzCr2PLecdYeW1QAn4OWbBBWCuprioGXzLZXg3LQULM+LcnWAcjrBo38LK+xqw3
         4rUAL86GG/9SULIVBGLyR0QHV9pYMKyW24LL/neT5BYNogQdeD0sHTmcGT3jbZn3dbDv
         d1+U2vsith19Tw6XpsWo1KMkhkoZxl+GO00X1qu4VGQl32sd1Hwu0uzxolrsUTU+PhiZ
         f6Rvbn3DjWtgiJHITL3sBdxXOz/ZwAM7ZsdTZLttlVNIrwwJ7NyF5nknDbd2DAGH+e2F
         c0RlX4AXOEOqQ9vk+u2+2w5IemftFJuBHgZ6ctULi/JwSEyJdWrRAjKMM/LeqlZckc19
         0n9A==
X-Gm-Message-State: APjAAAVMGbnvPTu9ogVpjryETRWKJjUmrClzel99dwUWmBcyF0DlKPLb
        AF0d+RKzuFJAMdCzZlahGw==
X-Google-Smtp-Source: APXvYqwuLLMIzUHQhT0Ztg4cPxiQhIaJPv4puG6SSu2cVv7POWyU8W3h/O93S9qQuP2ylMDkzQu/aw==
X-Received: by 2002:a5d:8049:: with SMTP id b9mr69933934ior.199.1563839711167;
        Mon, 22 Jul 2019 16:55:11 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id p3sm35496757iog.70.2019.07.22.16.55.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:55:10 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:55:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     fugang.duan@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        daniel.baluta@gmail.com, fugang.duan@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND 1/1] dt-bindings: serial: lpuart: add the clock
 requirement for imx8qxp
Message-ID: <20190722235509.GA1256@bogus>
References: <20190704134355.2402-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704134355.2402-1-fugang.duan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jul 2019 21:43:55 +0800, fugang.duan@nxp.com wrote:
> From: Fugang Duan <fugang.duan@nxp.com>
> 
> Add the baud clock requirement for imx8qxp.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
