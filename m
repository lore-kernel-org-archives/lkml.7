Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58833C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3112C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfCRDFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:05:14 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:43485 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfCRDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:05:14 -0400
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by mgwkm03.jp.fujitsu.com with smtp
         id 7aff_2ae6_0457e3c2_6e84_414c_9436_52e0c1940dbe;
        Mon, 18 Mar 2019 12:05:11 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
        by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 147D6AC00AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:05:11 +0900 (JST)
Received: from G01JPEXCHKW16.g01.fujitsu.local (G01JPEXCHKW16.g01.fujitsu.local [10.0.194.55])
        by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id EB4866923F5;
        Mon, 18 Mar 2019 12:05:09 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw16 ([10.0.194.55]) with mapi id 14.03.0439.000; Mon, 18 Mar 2019
 12:05:09 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>
CC:     'Catalin Marinas' <catalin.marinas@arm.com>,
        'Will Deacon' <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'James Morse' <james.morse@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be applied
 on A64FX v1r0
Thread-Topic: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be
 applied on A64FX v1r0
Thread-Index: AdTbJFde57o7xnMQR9OpSdZTOYeW4///o4KA//uP4VA=
Date:   Mon, 18 Mar 2019 03:05:09 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A35627D@G01JPEXMBKW03>
References: <5FA513F682BE7F4EAAB8EE035D5B08E44E9363CC@G01JPEXMBKW02>
 <20190315151241.GC48314@lakrids.cambridge.arm.com>
In-Reply-To: <20190315151241.GC48314@lakrids.cambridge.arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Mark Rutland
> Sent: Saturday, March 16, 2019 12:13 AM
> To: Okamoto, Takayuki/岡本 高幸 <tokamoto@jp.fujitsu.com>
> Cc: 'Catalin Marinas' <catalin.marinas@arm.com>; 'Will Deacon'
> <will.deacon@arm.com>; 'linux-kernel@vger.kernel.org'
> <linux-kernel@vger.kernel.org>; Zhang, Lei/張 雷 <zhang.lei@jp.fujitsu.com>;
> 'James Morse' <james.morse@arm.com>; hange-folder>?
> <toggle-mailboxes@lakrids.cambridge.arm.com>;
> 'linux-arm-kernel@lists.infradead.org' <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [RESEND PATCH] Make Fujitsu Erratum 010001 patch can be
> applied on A64FX v1r0
> 
> On Fri, Mar 15, 2019 at 12:22:36PM +0000, Okamoto, Takayuki wrote:
> > I resend the patch due to whitespace munging.
> >
> > > -----Original Message-----
> > > From: James Morse <james.morse@arm.com>
> > > Sent: Wednesday, February 27, 2019 3:44 AM
> > > To: james.morse@arm.com; linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org; Catalin Marinas
> > > <catalin.marinas@arm.com>; Mark Rutland <mark.rutland@arm.com>; Will
> > > Deacon <will.deacon@arm.com>; Zhang, Lei <zhang.lei@jp.fujitsu.com>
> > > Subject: [PATCH v5] arm64: Add workaround for Fujitsu A64FX erratum
> > > 010001
> > >
> > > +/* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and
> > > +v1r0) */ #define MIDR_FUJITSU_ERRATUM_010001
> > > 	MIDR_FUJITSU_A64FX
> > > +#define MIDR_FUJITSU_ERRATUM_010001_MASK
> > > 	(~MIDR_VARIANT(1))
> >
> > This workaround for the erratum should be applied for both A64FX v1r0
> > and v0r0, however, the patch v5 is only enabled on A64FX
> > v0r0(MIDR.Variant == 0 && MIDR.Revision == 0).
> > This issue is caused by the macro MIDR_FUJITSU_ERRATUM_010001_MASK.
> >
> > I have tested on both A64FX v1r0 and v0r0. This new patch will effect
> > only for A64FX.
> >
> > --
> > Changed to be applied for not only A64FX v0r0 but also v1r0.
> >
> > Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
> > ---
> >  arch/arm64/include/asm/cputype.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/cputype.h
> > b/arch/arm64/include/asm/cputype.h
> > index 2afb133..1fb47b5 100644
> > --- a/arch/arm64/include/asm/cputype.h
> > +++ b/arch/arm64/include/asm/cputype.h
> > @@ -129,7 +129,7 @@
> >
> >  /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
> >  #define MIDR_FUJITSU_ERRATUM_010001
> 	MIDR_FUJITSU_A64FX
> > -#define MIDR_FUJITSU_ERRATUM_010001_MASK
> 	(~MIDR_VARIANT(1))
> 
> The bug is is that MIDR_VARIANT() is meant to extract the variant from a full
> MIDR value, not generate an in-place field value.
> 
> > +#define MIDR_FUJITSU_ERRATUM_010001_MASK	(~(0x1 <<
> MIDR_VARIANT_SHIFT))
> 
> I beleive this can be:
> 
> #define MIDR_FUJITSU_ERRATUM_010001_MASK	(~MIDR_VAR_REV(1,
> 0))

Thanks for your comments.
I also have considered to use MIDR_CPU_VAR_REV macro,
but the implication of (~MIDR_CPU_VAR_REV(1, 0)) is "NOT v1r0".
I think it may cause confusion, so I choose the
simple way (~(0x1 << MIDR_VARIANT_SHIFT)).

> But otherwise this looks fine to me.

Will this patch be merged to v5.1?

Thanks,
Zhang Lei


