Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E0CC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448F72133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558617409;
	bh=mXLc0Pq75zm3ejNcPLS6bjMJjJ1c1cz2ZzOn9qMPJRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LIpAo2nUEbIWWIkm3sNLxKPpwLZWu5PmD76wtjTjA1BypciDGhISYFx3Fzy2N8L0N
	 vHvERu7sgVCjvfom74rmUaTHBF7nrsJ7RTnUCm+VYeKbrbP1GV0lJjrVia0AR7OcYV
	 zU3ml2WYh6qyaYffn/AqDMidBYxWYbgz6ues/klc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfEWNQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:16:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47288 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mXLc0Pq75zm3ejNcPLS6bjMJjJ1c1cz2ZzOn9qMPJRM=; b=jwZNKcvSZsGKxhjtZO0m04i13
        XHNJ71dJgEsdHqeCt7pSl9qYAomLC+UAdP8UucBjF6RsoIbyIjyWgVDzcmrb+JpzA4x6teRFAIp9u
        2+Ov/Onsmki/kayOWNyssvBea+F3ss8BsnPxIf1frR5nME1kFKktbqy2XZLj5dNsVEvAg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTnaM-0000B5-0H; Thu, 23 May 2019 13:16:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 602F61126D24; Thu, 23 May 2019 14:16:41 +0100 (BST)
Date:   Thu, 23 May 2019 14:16:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, vinod.koul@linaro.org,
        niklas.cassel@linaro.org, khasim.mohammed@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: regulator: qcom: add PMS405 SPMI regulator
Message-ID: <20190523131641.GD17245@sirena.org.uk>
References: <a3c281d5-d30e-294f-71ab-957decde2ba0@linaro.org>
 <20190502023316.GS14916@sirena.org.uk>
 <dd15d784-f2a1-78c6-3543-69bbcc1143c4@linaro.org>
 <20190503062626.GE14916@sirena.org.uk>
 <229823c4-f5d4-4821-ded1-cc046dd0bd20@linaro.org>
 <20190506043809.GL14916@sirena.org.uk>
 <a89763cb-5d50-0927-7912-6ccf38ae1d66@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <a89763cb-5d50-0927-7912-6ccf38ae1d66@linaro.org>
X-Cookie: I brake for chezlogs!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 23, 2019 at 10:35:46AM +0200, Jorge Ramirez wrote:

> Would you accept if I wrote a separate driver specific to pms405 or do
> you want me to integrate in qcom-spmi_regulator.c?

> I am asking because none of the ops will use the common functions (I
> wont be reusing much code from this qcom-spmi_regulator.c file)

I don't really mind, if there's nothing really shared then making it a
separate driver is probably best but it's not a strong opinion either
way.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzmnTgACgkQJNaLcl1U
h9CDcAf8DL+MyQPT/4yQxHXXQBs5IDMiS1xz5/mDyBccppntbLrOEa47PK9HkXBd
1OOgkPuGEIYd74ad4Oue+CWFYQJhofrt4PSHoq0qfciBgho8cgZGRKI5twUI5P68
lQP7WMcri9askjAXIzykFfbdNoSQVoCsWi2mONsSDJXQqZg5C8VAdH1wpJjBe27Z
we9oiZ+JQi0NvANUAHq3IqEHk3q9EP2p1IpvMzLRJHIv96kmHD8IJXoF5eZC2Hs1
QRv7RA+EgX1/mT2JhVE+FaFvDbb4Ur4oLU2u/387E5ImIQ+ltcADQq2KUbsbl4LN
sJRpd1qX9AEPMdyAnm2K18I0slbCRg==
=5f7d
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
