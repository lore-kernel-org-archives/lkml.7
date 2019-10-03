Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353B6C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1282C20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570127763;
	bh=8xZ6YXfyq2hnNuMAqNcsK16gYTOtcLHh464CJAwxiiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RzJa/vTRSLVOFq5/ItRAAKS52FQfR2bZFs7sQfFtNu8bfEmOe85EMwbDjQ6HqxNun
	 TZlDilWvrdo5f1GC7Pd1zIngx1RVAmX4d6cMIkpouUC70c9CRY6wyAJCPmjskA9tY7
	 pqrZrHvRxtS3n0pApfEgJtiZ/VAqnBXCkNy3YDsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfJCSgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:36:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbfJCSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8xZ6YXfyq2hnNuMAqNcsK16gYTOtcLHh464CJAwxiiA=; b=hoipmdP7ShfKwIU+CCwtxbVn0
        L3MZJGBv7TEP7q7v2d3Ug9EJwUbiLnTOSIK5tKOV/S+tskCzNfaZwBMzMG/xCoL4aB8ux8Tf2X241
        DBdLnfxkUS2Cpk03iXbc9IZ5aK9lCsZTkl02iy2dTEWgsO81RHRcOJdU5KJV5pmPaUkgQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iG5xC-0006D4-Pe; Thu, 03 Oct 2019 18:35:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 49A972740210; Thu,  3 Oct 2019 19:35:54 +0100 (BST)
Date:   Thu, 3 Oct 2019 19:35:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tomi.valkeinen@ti.com, dmurphy@ti.com, linux-leds@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v8 2/5] leds: Add of_led_get() and led_put()
Message-ID: <20191003183554.GA37096@sirena.co.uk>
References: <20191003082812.28491-1-jjhiblot@ti.com>
 <20191003082812.28491-3-jjhiblot@ti.com>
 <20191003104228.c5nho6eimwzqwxpt@earth.universe>
 <acd11fe1-1d51-eda5-f807-c16319514c3a@ti.com>
 <62591735-9082-1fd7-d791-07929ddaa223@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <62591735-9082-1fd7-d791-07929ddaa223@gmail.com>
X-Cookie: $3,000,000.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 03, 2019 at 07:43:17PM +0200, Jacek Anaszewski wrote:
> On 10/3/19 2:47 PM, Jean-Jacques Hiblot wrote:
> > On 03/10/2019 12:42, Sebastian Reichel wrote:
> >> On Thu, Oct 03, 2019 at 10:28:09AM +0200, Jean-Jacques Hiblot wrote:

This mail has nothing relevant in the subject line and pages of quotes
before the question for me, it's kind of lucky I noticed it....

> I wonder if it wouldn't make sense to add support for fwnode
> parsing to regulator core. Or maybe it is either somehow supported
> or not supported on purpose?

Anything attempting to use the regulator DT bindings in ACPI has very
serious problems, ACPI has its own power model which isn't compatible
with that used in DT.

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2WP4kACgkQJNaLcl1U
h9AgAQf/eheTMwAWaxe5ccDKZD9hVWX05p22QRpydZ2d8Yz9U/uFwu9tph6P4tRd
ffNJl+01Sn6rytSQyx+k3jaRZ75L/yfX5AXag+4JE1/6zk94LOtt/of4OnrmXDxW
b0FHmWlI5wuQS/QWYCU3TPbQ5Rp5/INXfQc/XcCOTJT4nYeqLFmcGe0xv31dIFso
k7BogASJB2+cjFyEMTh1xfsqGNAPYhQfFxNSX5tBUqhvt4fpfhwhCvmNQAAvmWaJ
/VLI8g0JTa3T2uroJJKBPXgw8bm3One9Q0aNtcQDF8TgmI7w+73gx42iu28A0PyP
bookZAb4iUFLMpD/FIoDy75uPMPjTg==
=pjam
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
