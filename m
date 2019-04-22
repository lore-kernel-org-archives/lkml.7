Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C28C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E543214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BxdjLJJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfDVQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:31:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38414 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfDVQbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:31:42 -0400
Received: from zn.tnic (p200300EC2F07AE00B522724F4D48BE41.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:ae00:b522:724f:4d48:be41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D40131EC082D;
        Mon, 22 Apr 2019 18:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555950700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O3GmTeFoFX8ZhjWu4nf23J6ydyPMCGnv8yIHpMGj9I8=;
        b=BxdjLJJy6KG7oE302PQuhxnp5Ld5zYmb4cgPot0yw1BoVTHXPzkIQ3MKfe/WKoOQpj/Fax
        5iHKcmsDN5D1/3TpSuTaYI+xOm6UWNrXyvYQ4cPKGJrvFzL1dbeP5WId7pvNYr5o9bvet2
        qlFm7jGKhHGlkisbeTgMMlJ94R7iWes=
Date:   Mon, 22 Apr 2019 18:31:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Message-ID: <20190422163138.GF21457@zn.tnic>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
 <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
 <20190420184751.GE29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A49F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E90A49F@ORSMSX104.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 04:29:35PM +0000, Luck, Tony wrote:
> > Now, if you still want to know how many errors and where they happened
> > and when they happened and yadda yadda, you *disable* the CEC.
> 
> Rebooting isn't popular in many end user situations. Many CSP (cloud
> service providers) vehemently hate the idea of rebooting.

I meant disable in Kconfig - not build it in at all.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
