Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E93214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555582574;
	bh=a3gnFwh2bISMYF607FH38ZkvhUAcS6uPcz4gPrqxTJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A1G1RAyLkahcaxXChheVVc/hDkNMxWaM/dnhoEufmhRzmgCoeYVKjV45ubMFDINrO
	 f9Oe40NhH5dv3fcygD3fGMyiiLahojYy4SMSyJYeL04Wwqd4W7eapO5k/RYrVdH/sy
	 DYNzCE/O6XrYyel9s0CutsngtHNL7mCvFbk6qd58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbfDRKQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:16:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55190 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a3gnFwh2bISMYF607FH38ZkvhUAcS6uPcz4gPrqxTJM=; b=HoowKFV9bgsKs9WefFJPbZwYf
        lzJKaaDK/Xr7EKwCYwwo7824c8LYknmFboVI3Znx4J1eDxeBzDebGGpHNnllvoYFICnLbPqW66WNT
        s2Q3IDmtvo9JKoY//f6ajz9nS7sK4RAN37uCIQAnso0hYZcdtcpXOW5xZebQcTSO/UjCI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH45Q-0001SH-5X; Thu, 18 Apr 2019 10:16:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id EB72C1126DA9; Thu, 18 Apr 2019 11:16:06 +0100 (BST)
Date:   Thu, 18 Apr 2019 11:16:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH V2 3/3] regulator: slg51000: add slg51000 regulator driver
Message-ID: <20190418101606.GC6702@sirena.org.uk>
References: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
 <2e7559c6ad3fdc3c3b99690ebd7dbb4e35c0d184.1555567784.git.eric.jeong.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <2e7559c6ad3fdc3c3b99690ebd7dbb4e35c0d184.1555567784.git.eric.jeong.opensource@diasemi.com>
X-Cookie: A watched clock never boils.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 03:09:44PM +0900, Eric Jeong wrote:

> I updated regulator_ops structure to use use the helper function=20
> which is regulator_is_enabled_regmap() instead reading status bits
> for is_enabled() operation.

> v2: use regulator helper function for is_enabled()

There's also the get_status() operation which you should be able to
implement using the status bits you were reading before - that lets
the framework know if the regualtor is actually working which can help
with error handling so it's good to do.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4TmYACgkQJNaLcl1U
h9ANEwf/WWzURfos+VWeKjS1bNQaogms1MLqzXWk5S8SHI1/ND+lrwudCVJ4UXJ0
kXg3qPfxyALM2k/7Ex2W1QaZ4WKoN/YbnEQPle9Ag79YTapMM74OMGt75O+hgbK7
+jnsN+QwGYKfW1yUIKlH85OXbVpzvVjeJe83/QIR1hcEG5G0zMEeIRk0zTMILrGq
DqwYKI/Y9eC85JYiEGTnR3ItFKE4ToWz0MOqqaaiGVUZqUGpYQDTHWdVkQXAdtLA
amgNQaw+6NQ1JszQP86G145i9hez0O1tCE5d04yDYWEpP8/nh15ZoOLrmSW7rDG8
ra0PO4F1Gciublx/QZGqV9R+bVLBQQ==
=ZrKl
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
