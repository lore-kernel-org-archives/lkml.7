Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2734C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64B72089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405109AbfFKKAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:00:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfFKKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:00:52 -0400
Received: from 5HSWXM1 ([87.191.24.82]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M3mHT-1hZoET2Vdb-000vOE; Tue, 11
 Jun 2019 12:00:35 +0200
Date:   Tue, 11 Jun 2019 12:00:25 +0200 (CEST)
From:   Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
cc:     Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: dma: Add missing IS_ERR test
In-Reply-To: <b731167e-6285-4fe0-e280-b2626b8efe44@cogentembedded.com>
Message-ID: <alpine.LNX.2.21.99.1906111147340.3086@5HSWXM1>
References: <20190607115404.4557-1-embedded24@evers-fischer.de> <b731167e-6285-4fe0-e280-b2626b8efe44@cogentembedded.com>
User-Agent: Alpine 2.21.99 (LNX 239 2017-12-04)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SMRQfsP6ySGCjrUzxZeapgWewqu01yhxyR4JPwhyR9idNKE5J9g
 gJsAq56PtLA/sIPERp+6BeYhC+Zg9XAoK+TDim3gMybBh1wWYgC3VUwYZWHGU2MWfVDOzv+
 YWPY0dfo/TBl1ZBcvYVljABd8F3KqiBVwoypvMCqrnd6T00z5BWa741RzF1nilGPwY6t6lf
 XDXPKeu5uUeX2UGixuS1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNkZ+nYQJnM=:p3IBEqWC64tzRIcKnLqJBm
 ulUHtj7Ag1DlBH6MOgVd6RF7YNC2LQaejC7T16mzDHqH1ZqpYoDrcdsYLZUwJltSCQtXEvtql
 kVsHYtHFmg+NfnvnRvBFXOHYWKCGxd77cuf7QQ1maCQ3Yywu2M6JTKqJvUR4KXY9T6an9ySxD
 Ehoj6x0wtzvQAXyGx2HAfBy9koKMHCAwbM0F0sCczEBxm0isIeryfDIqLugT+qJjiRAoh8sy8
 cb99w8EMMuhz1bkzuSLrdSQElrtG1M8zVGRO6MGTdXTRH41OkRy+FOe2qVaKkIHWDXV2OTGqR
 jNpN2z1xTD5R0sF2mMvDoKDAru+adYc41oyGGnp0/WvDWOcphabcsNuJlXJAs+HTlcVxjpQje
 V5RAz4H4NcTDMh9jl0HNBWGc3HS5yCfdIxgWjS2xCwa4KcZ/Cef1OeBxUDvfSzeNYaJ4Z9Po3
 sSEriUC+vONGViLSdU+LhZa62tVtfgKXwdhZIMKsVacITU4EcSW25YMPWnl9SxHV+1sRG1ffY
 VbA7S3LN1ocwu2Vy6g38fy5NtTl1/9JBSFY8TzhbEsF/jzZWg+xlXVxh035VGNz1fOTQfO/Zm
 VS3NV35KbNOF81r/CsurSlF35NnCdoeXNJVrj2gNZMyOgheZgaLCI1hmFJ4XTr7lZXIbKfgQP
 3wjGVMYREMDGIoBEG+A1Q2REJltlM5AKtjRLiC6jBSr5P0lYCRH9bdr6KdSfBjoZ2M5mNfGig
 Fe4SrtLXcEnM/9TVO+Jn2o5afuoH+hl1m7fF8lgIwNShX2EJCbCMXGW/XXILHwLUeiL0mEj1v
 TqfA7u6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergei,

thanks for your feedback.

On Sat, 8 Jun 2019, Sergei Shtylyov wrote:

> Hello!
> 
> On 07.06.2019 14:54, Rolf Evers-Fischer wrote:
> 
> > get_dma_channel may return ERR_PTR, so a check is added.
> > 
> > Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> > ---
> >   arch/sh/drivers/dma/dma-api.c   | 20 +++++++++++++++++++-
> >   arch/sh/drivers/dma/dma-sysfs.c |  2 +-
> >   2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
> > index ab9170494dcc..5d6f1a46cc5e 100644
> > --- a/arch/sh/drivers/dma/dma-api.c
> > +++ b/arch/sh/drivers/dma/dma-api.c
> > @@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
> >   	struct dma_info *info = get_dma_info(chan);
> >   	struct dma_channel *channel = get_dma_channel(chan);
> >   -	if (info->ops->get_residue)
> > +	if (!IS_ERR(channel) && (info->ops->get_residue))
> 
>    Extra parens not needed here.
> 
> [...]

I agree with you. They should better be removed.

Kind regards,
 Rolf
