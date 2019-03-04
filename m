Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E8020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 09:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="X5x+M1yx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCDJlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:41:01 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:38554 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfCDJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 04:41:01 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id A364525BE43;
        Mon,  4 Mar 2019 20:40:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1551692455; bh=TdGoX41akHOpCM9eMpDPEDl0eg/oyg57a+AgVWGGb0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5x+M1yxVQiWjzmOE1cFD/vsE1/mM6RupH2RqtPg/P/n8pjRNlsIJeeif4w/T/nkH
         vKc79Dh9KtMm9XQHHWlxA+YrkDBInGg6bjKhHHvwPYSjtXu7KRcgB+sDt2mQXls9Jl
         DA2PuNQBRPfA8iqk9DtDLaU1nX02Hl3WfBDfY5A8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id D6BBD94030D; Mon,  4 Mar 2019 10:40:52 +0100 (CET)
Date:   Mon, 4 Mar 2019 10:40:52 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Message-ID: <20190304094052.huutusp3erakcfea@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190215075226.413d55dc@jawa>
 <c2eb829b-96a7-20cb-913f-ce4214f2156c@suse.de>
 <TYXPR01MB1775ECF6D79FCA2C0040DA06C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYXPR01MB1775ECF6D79FCA2C0040DA06C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:03:06PM +0000, Fabrizio Castro wrote:
> Thank you Andreas.
> 
> > From: Andreas Färber <afaerber@suse.de>
> > Sent: 15 February 2019 09:10
> > Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
> > 
> > Hi Lukasz and Fabrizio,
> > 
> > Am 15.02.19 um 07:52 schrieb Lukasz Majewski:
> > > The best approach is to run:
> > >
> > > git format patch -1 <your patch sha>
> > >
> > > And then
> > >
> > > scripts/get_maintainer.pl 0001-xxxxxxx
> > >
> > > You shall see the the list of people to send the patch.
> > 
> > No, that does not answer his question. And please don't top-post.
> > 
> > >> Who is the best person for taking this patch?
> > 
> > The answer is: whomever is taking dt-bindings patches in the following
> > 10 patches that make use of this prefix, once you have a Reviewed-by
> > from Rob. So, most likely the Renesas kernel maintainer(s), i.e. Simon,
> > which differs from get_maintainers.pl of vendor-prefixes.txt.
> 
> Simon, do you think you can take this patch?

Sure, I have queued it up for v5.2.

> 
> Thanks,
> Fab
> 
> > 
> > Regards,
> > Andreas
> > 
> > >>> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >>> Sent: 16 January 2019 18:38
> > >>> Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon
> > >>> Linux.
> > >>>
> > >>> From: Biju Das <biju.das@bp.renesas.com>
> > >>>
> > >>> Add Silicon Linux to the list of devicetree vendor prefixes.
> > >>>
> > >>> Website: http://www.si-linux.co.jp
> > >>>
> > >>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > >>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >>> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > >>>  1 file changed, 1 insertion(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > >>> b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > >>> 4b1a2a8..02a7037 100644 ---
> > >>> a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > >>> b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -344,6
> > >>> +344,7 @@ sgxSGX Sensortech sharpSharp Corporation
> > >>>  shimafujiShimafuji Electric, Inc.
> > >>>  si-enSi-En Technology Ltd.
> > >>> +si-linuxSilicon Linux Corporation
> > >>>  sifiveSiFive, Inc.
> > >>>  sigmaSigma Designs, Inc.
> > >>>  siiSeiko Instruments, Inc.
> > >>> --
> > >>> 2.7.4
> > >>
> > >>
> > >>
> > >> Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael
> > >> Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf,
> > >> Arcadiastrasse 10, 40472 Duesseldorf,
> > >> Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708
> > >> USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE
> > >> reg. no.: DE 14978647
> > >
> > >
> > >
> > >
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > --
> > >
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> > > Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de
> > >
> > 
> > 
> > --
> > SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> > GF: Felix Imendörffer, Jane Smithard, Graham Norton
> > HRB 21284 (AG Nürnberg)
> 
