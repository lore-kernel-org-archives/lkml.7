Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796CC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7062146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="QV/2Pmhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfC0LQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:16:08 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55421 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfC0LQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:16:08 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6363425B7CA;
        Wed, 27 Mar 2019 22:16:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553685365; bh=YEf9iuhsd9FhVN4Y71nWMlElZGV2CziDAyr5R7q705U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QV/2Pmhv7Xajt/n7P88mBaZ9lx1Dv5eIRPG7rr67wn+ArC07JB6PfV0CgKWbeLIMl
         aMtCpUksUWc0DjIfRyvVuiQcmMmSwKl4/c/WoUlEH0drh4+xkf62Af4s3dkCOiZ0tH
         brY9frr92X4BMb7a43XNrl2ctr5MwcnLWgRNPAKc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 91146940376; Wed, 27 Mar 2019 12:16:03 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:16:03 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] arm64: dts: renesas: use extended audio dmac
 register
Message-ID: <20190327111558.yw2wld4oivcw5x7a@verge.net.au>
References: <20190326095826.4987-1-jiada_wang@mentor.com>
 <20190326095826.4987-2-jiada_wang@mentor.com>
 <CAMuHMdUOcPhy5D-RagprwZkqOOgNt+4bGfSLQzydydHBOt76kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOcPhy5D-RagprwZkqOOgNt+4bGfSLQzydydHBOt76kQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:09:45AM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 26, 2019 at 10:59 AM Jiada Wang <jiada_wang@mentor.com> wrote:
> > Basic audio dmac register only supports busif from 0 to 3,
> > in order to use busif4 ~ busif7, extended audio dmac register
> > need to be used.
> >
> > This patch updates H3 (= r8a7795), M3-W (= r8a7796) and
> > M3-N (=r8a77965) to use extended audio dmac register set.
> >
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Jiada,

applied for v5.2 with Morimoto-san's Ack from v3.
