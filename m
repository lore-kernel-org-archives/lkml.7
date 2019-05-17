Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68048C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8DF204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558060287;
	bh=2+A5A1BXytEqa5zIBoSTMI9tuxv/jN00Tdx46eTZmoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xTgfhmhjXOo+pQMLIYtL706lA1eO/aCFRdOArtoM76C4tnfLPHBhPrxFFMpGeZVGu
	 /UO/hcRIRotzm0A14hjtfehRDi/8p1Io2SYrn7SdpKgW//dqZnjMXGJ9WCKvwCsT2f
	 DRPYycN+gbv8G9GqCqO/pGToMhzsZajbaREfS7OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfEQCb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfEQCb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:31:26 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383AD2087B;
        Fri, 17 May 2019 02:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558060285;
        bh=2+A5A1BXytEqa5zIBoSTMI9tuxv/jN00Tdx46eTZmoQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yotMRwZ4W+solrrj1jYJMw6aVU6pgmrP+hLdtSkoG2pvNu1ymuBA8jw/nH6faKu7W
         lRFoyTnwZIwhW2JC8aqjOfiZOwLY1z+0uMpcUxYb+N/8ZFTAiOB1gGlyk7qN6KrgYk
         aRqW/7B7ygh/P8TE3AWOe2aUlC33OuSyq6eB/Rig=
Received: by mail-qt1-f181.google.com with SMTP id y42so6398086qtk.6;
        Thu, 16 May 2019 19:31:25 -0700 (PDT)
X-Gm-Message-State: APjAAAWSVb2shi1MBBiuYtQhGWGKWq9vST9z1ojk/PwZXMYQ1nkq6Pbr
        Yy4aiUyYktaKk2EBpeZDXgw1FBDLVB0egsWKUA==
X-Google-Smtp-Source: APXvYqx/rQhhXbs3Zm1ZaazZt73ewsKquxIsvA5TGLe4WlO6glcLO4+7Y8HWssTf0uDrB5YLL8uyMOMq6PTvVt3CsaI=
X-Received: by 2002:aed:3f5b:: with SMTP id q27mr44580598qtf.143.1558060284526;
 Thu, 16 May 2019 19:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190514132822.27023-1-angus@akkea.ca> <20190514132822.27023-4-angus@akkea.ca>
In-Reply-To: <20190514132822.27023-4-angus@akkea.ca>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 21:31:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+p_Hu5hY3XGx168iq8jo+-rD1qu8tbGfQdBXASi7H+mg@mail.gmail.com>
Message-ID: <CAL_Jsq+p_Hu5hY3XGx168iq8jo+-rD1qu8tbGfQdBXASi7H+mg@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] dt-bindings: Add an entry for Purism SPC
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 8:28 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add an entry for Purism, SPC
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

I've converted this file to json-schema as of v5.2-rc1. See commit
8122de54602e. Sorry, but you will have to rework this patch.


Rob
