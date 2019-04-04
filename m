Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451DE20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554364296;
	bh=H05f1Z5LsoZNx375DxJQSq2d7uvBQKpJoHdLd8HeYJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w90a65Wk65I/yb2600Imb3knHj7+PYNepHfuxZFg++5J0WdQEI434fIMIsEfDDrt6
	 zld4DXT9yqYHnElk8WbFlkuIAAvQmyt75YvCZDEFWOr0xKL5n79AN2E/+oz1PMZGvX
	 hcye6raoF4pnVlWbfwkcXOkfv9PS9u3ikYrzlVdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDDHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:51:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36194 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H05f1Z5LsoZNx375DxJQSq2d7uvBQKpJoHdLd8HeYJo=; b=CF9o1n+kCB86Kx7tY2PBlyHGo
        EbXx5IXyojpopHxCTauZ0HwwHRa+E0bO/pEHG8vWGL20RyeQCI80tggh68FooLmPkDte7FgEcVcs8
        rg3qm48ly7sc1g2J9qkEVipsI0PoqCu3N1OlQuKtRmEZZv0rUZgmIOgRtlxbm8RrPr0oE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBx9c-0004mL-KW; Thu, 04 Apr 2019 07:51:20 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BC2EB441D3C; Thu,  4 Apr 2019 14:51:17 +0700 (+07)
Date:   Thu, 4 Apr 2019 14:51:17 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/12] ASoC: rockchip: pdm: using left justified store
 mode
Message-ID: <20190404075117.GP5748@sirena.org.uk>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
 <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
Content-Disposition: inline
In-Reply-To: <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 09:40:46PM +0800, Sugar Zhang wrote:
> This patch set left justified store mode default.

The changelog should really explain why you're doing this.

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylt3QACgkQJNaLcl1U
h9BM/wf/RDkvVsQZ3WG2fWsFHy3bW6rpEvIQA/G/4sQqjHPgLKxzvxkLkblE7uo7
s/3H5SR3CiWNPaOkpli7sFpirI+PxwlgtrnlJQrf2/ayJybXYA0xtFirscA5tR9a
Samz9fs5UWF00szRHtw6TXsBAGIB2OiQi1Y6CqaB+LbzuXvkeLdPEAk2atJUmA5Z
W3lbpUcJ6b54lhLsPdr+gUOOL9GTYSYbyY7fFM8DZ3KGvTszZm10qX3RVkuOwbYi
DddxyWQI83tfR1cKIX+eQ3IeEPwfOv73tnvKYSL66ls0ge5UTkf1tzPjAgwDoiHf
ZMa97NGXs1Qm2KFWnnwCTmiW77qV/w==
=369W
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--
