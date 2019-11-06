Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DDC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0032178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573057109;
	bh=fz+idqcv18pmIfwgsT5BGEuhP72lplSqQsRt41wSOiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Z3UPDzUk5Pf/cZONImh8t+JMv/HE+k8U8Tq/wd1wFJgTOTpIpSn3cl56Y1RM5+gZ
	 hChVtNM2eipYG311JozPunG0dC5GDRDZdT61YezritpVvN9TU7GA2IONtJ04lAe47z
	 V3u15Aco2uyx9Y4QTh8s+dgLPO7/xNIHl4MyTASQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfKFQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:18:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47376 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfKFQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fz+idqcv18pmIfwgsT5BGEuhP72lplSqQsRt41wSOiI=; b=ojXMQ6xamE0y7R3+prR1sZKNs
        QI6bzkwy3IL6swjWEEhzhPrz85txMWqHFpEwtI6v43KQYXGFciO28ZG/Hh4e2YvUdCBJnr5ks8Gh+
        latj2XPFHHV/RgNmruJUDQSY7HUrtzEPYAlq7EhdzNuqcCbxnhYXrgHoYTX/LKInEfOXg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iSO08-0001oO-LK; Wed, 06 Nov 2019 16:17:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2E19C2743035; Wed,  6 Nov 2019 16:17:44 +0000 (GMT)
Date:   Wed, 6 Nov 2019 16:17:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, djkurtz@google.com,
        Akshu.Agrawal@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v2 1/7] ASoC: amd: Create multiple I2S platform
 device endpoints
Message-ID: <20191106161744.GB11849@sirena.co.uk>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <1573137364-5592-2-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2019 at 08:05:58PM +0530, Ravulapati Vishnu vardhan rao wrote:

Something is still up with the clock configuration on your system, this
claims you're sending this tomorrow.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3C8icACgkQJNaLcl1U
h9AWAAf/c3futrq+tAcyQ5tc5iLHHRmfkzlISVSWO5JMxlRJlKhuaTSBGNRT8niC
Kdii0aRuPoeCzn3BklTilvCRdeuw/sjYp/5REaIRDCljVBI3gMp+hAtal99wnFnf
2bjvYqSZaHeOW7Gb26u1ETuI8NpQOxEHxQTNR2K5OyNwWwthMolB2uU1B4KldE3I
9sz1kOrj5GJwVMadWFOyQaaI0lczuzadpHBoHeZjpmivqX0MQ8Cb/KDgCpu7Jh7u
o+4twWNqdZCP0IWrrtdmJRmzSirXwBoK4QYm3nJBRY7J9yWOPbxkHVdPO6C0EKDd
nXe4/gIbzyux9sRR2So8u0wat1yQeA==
=skY3
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
