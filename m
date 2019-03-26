Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88594C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BC320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553606185;
	bh=f4iC9AYetyzo4ElRcYp6THHyROMqvXDG8WtQPms+v1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=edIwPDS8Bb3b0NIoiYluYmOM7iYO7DuawIff6UrKOWX+lx5UoHpkiz8/esRStfZUo
	 Dyc3E5Bcu+hK6k6NX0+MZErHjSyqqaUK+uMXLlSIUT9Bb/I1GD4Zaj1wSdk6JsVfXj
	 X1AWDGzQSt/7w5dQus1C8QjV6aCpKM10qJTZ8yt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfCZNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:16:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCZNQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=izMpZ7KYl4bltr6IP2NWJHvHILP+bKUw94ek5PTlNTw=; b=HBlNXm1gwkbWMlt3U1XWWtSzg
        5Pw0o26xsIh8awSVkVOQonfw03Mx0TOYIv0gkNgYTSvX+XIXz4BZ4SryDDmaC7lgdNiRBKnke0zGY
        DnCCP8nZJP8zXeDUHzKcVAPXICLrfLXzcXHXdkc+Fq8p7QDuKnOSLyWJwH+VLfnlhHRAA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8lvj-0007NI-CJ; Tue, 26 Mar 2019 13:15:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7D1A51121B57; Tue, 26 Mar 2019 13:15:50 +0000 (GMT)
Date:   Tue, 26 Mar 2019 13:15:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190326131550.GB10898@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20190326133349.3d9427dc@canb.auug.org.au>
X-Cookie: Gibble, Gobble, we ACCEPT YOU ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 01:33:49PM +1100, Stephen Rothwell wrote:

> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:

> sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_prepare':
> include/linux/kernel.h:979:32: error: dereferencing pointer to incomplete type 'struct clk_hw'
>   BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) && \
>                                 ^~~~~~

Hrm, seems PowerPC is still not using the common clock API - is there
any plan for that?  There are some ASoC PowerPC uses so it's going to be
a bit of an issue as we expand our use of the clock API.

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyaJgUACgkQJNaLcl1U
h9CSoQf/XgWnshsX6T2bvGmi4+BRNZFJNeDtSwBpcEyteoYOTlJ2JINTuJnvn+UO
k7fG5WW2OUdNw/SiObjhfWFeqgc6d8W4fo8JUZqL1D8KQuFVtP/adA/SWqmrnCtD
UCI0NJ1EVVl+6yxUsi3FV5GtxuPTF70Wqicl4HZyicjLKAhxkzNzELnmwAf5RXPM
H6VtqYN527rbSjq/v5wLPgx9U/sWFjTusTy2EoG67BeU81h7NfkCNxr2tATwwvEQ
xxdOHCQCFiSegC1oq+SUsSdg0EFdzLVzFFRE2YGTpGQDdYUj//rwAS+WIzDiQh/4
JShDt+DMON0Lxd0SVgOtKbLfeL5wDQ==
=/5jB
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
