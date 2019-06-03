Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D0AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D23266F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559590798;
	bh=+2fzO7sDWIIo7kPESLm/foluyRja6yzj0sInlJHHkrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7RgAM0SYUyfO1Gg82/U5EKypTkECe1wkoWZiiTfQOEK3I9bO0rs3XLYarEeTD3YQ
	 I+GOjVt3MFjpNnflAcrc7SzJf61ot7S1sT62QVtfNMSxx5vi4NYwzL2dTWbZL64Mr8
	 DfiDYNBZGLnVwhE6jgqLpUPsZUMOxNJPApLTua4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFCTj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:39:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFCTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VWDF/wo4nmqBx8MpCkyt+Tdq3nZlay3xTvmbElXHcrM=; b=arUHyqsuWR8lhBwBTa1ojeE6j
        skRqS+y7OWCsVREkCmbky6jj1MB/p+D/J2QTwFMT3HSOzjJe3JvM6bWHIrJ+kpbZJVxTo2mgfkGPU
        ab/SVpZF7Srovvo+Gy0wpjdsal402VraMZjWUgYkM1yEqbZmyoAma0RzUFZyn/PNmHC+g=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXso7-0003pN-KP; Mon, 03 Jun 2019 19:39:47 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A80BF440046; Mon,  3 Jun 2019 20:39:46 +0100 (BST)
Date:   Mon, 3 Jun 2019 20:39:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 0/6] mailbox: arm_mhu: add support to use in doorbell mode
Message-ID: <20190603193946.GC2456@sirena.org.uk>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
 <CABb+yY1u5zdocgV=HhQcHWQa_R7ArtFqndU5_T=NsPHJ=jwseA@mail.gmail.com>
 <20190531165326.GA18115@e107155-lin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azskX66S5GHWoEK7"
Content-Disposition: inline
In-Reply-To: <20190531165326.GA18115@e107155-lin>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azskX66S5GHWoEK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2019 at 05:53:26PM +0100, Sudeep Holla wrote:
> On Fri, May 31, 2019 at 11:21:08AM -0500, Jassi Brar wrote:
> > On Fri, May 31, 2019 at 9:33 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> > > This is my another attempt to extend mailbox framework to support
> > > doorbell mode mailbox hardware. It also adds doorbell support to ARM
> > > MHU driver.

> > Nothing has really changed since the last time we discussed many months ago.
> > MHU remains same, and so are my points.

> Yes, I understand your concern.

> But as mentioned in the cover letter I did try the suggestions and have
> detailed reasoning why that's still an issue. In short I ended up
> re-inventing mailbox framework with all the queuing and similar APIs
> for this. Worse, we can't even add an extra node for that in DT to
> describe that. It can't be simple shim as we need to allow multiple
> users to access one physical channel at a time. We have use case
> where we can this for CPU DVFS fast switching in scheduler context.

Forgive me if I'm missing something here (this is partly based on
conversations from months ago so I may be misremembering things) but is
the issue here specifically the doorbell mode or is it the need to have
partly software defined mailboxes implemented using this hardware?  My
understanding is that the hardware is more a component that's intended
to allow potentially multiple more complex mailboxes to be tied to a
single hardware block than a complete mailbox in and of itself.  It
feels like the issues with sharing access to the hardware and with the
API for talking to doorbell hardware are getting tied together and
confusing things.  But like I say I might be missing something here.

--azskX66S5GHWoEK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1d4EACgkQJNaLcl1U
h9DPCAf+JRiDUd1tJfCcPY+46Wimb3qwUoLm6PBxRtYDQ/MfUIDCdZqdlpdKdzep
91J7xUxiJOrKptekK211kp4CPPg9bH4feA0SSrCv5MPIt9miVaaFkM2POLhBqlPz
YHdsY96fpNWiJnDIh9vbRkcWP13HAjbMfuiXDTO/VOBsPzm5Dv+zOZ7K015cgcko
pxasNY1+ewxpQoahe7JAOtXv3pV4JG1TBe/ZxtH2ONxGKhgFphVEsTRqm0bwOJMi
c360aWgOB7laJEbFoGu+gfxXt0J3QzlRPFDVQfwphuzYPWJ78FaVYS0k46VN83rH
XWWjScjVo5dNpkb9dyUaDOXG4YVyBQ==
=L6Hk
-----END PGP SIGNATURE-----

--azskX66S5GHWoEK7--
