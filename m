Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C3C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1695C2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565363524;
	bh=SDiIIHKH0mX658u0Bi3gbyG4ZfmHZmMJYPG0jCzNrec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+d6Zdb79+YSx+m/WBLyfsBCGbeXO5xZ1EdSnJIbwNxJuaIMT8cprnYoZqABmaOND
	 QzjQp0G+9o4+9+M0c3ki9QBNwzvRIWtrO+UjUbDxae5XxRDZWYkst8eaGnVGVJQ35m
	 weE6bTzDwebztkA9IQA6XEks2HqXq6oV2R+4HnPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407316AbfHIPMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:12:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46048 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfHIPMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDiIIHKH0mX658u0Bi3gbyG4ZfmHZmMJYPG0jCzNrec=; b=BgXLagGsCCDO+CndeZCSapQIy
        4vE6jKaJzLxlw/TpDuBdqGGwL6/81JMKa+G0qlH66Rp+HamYHe/CFCvic9oDLKFosM6bt3iiZkYuY
        QuYP8cPyoEPoEh9C8nMfO1gl5MlR/ABhlIKmJHO+czmQesczdjLGdAewTGEzrO3qDWp4c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw6YT-0006Kp-MY; Fri, 09 Aug 2019 15:11:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3C6DE274303D; Fri,  9 Aug 2019 16:11:45 +0100 (BST)
Date:   Fri, 9 Aug 2019 16:11:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SOF: Intel: Add missing include file hdac_hda.h
Message-ID: <20190809151145.GE3963@sirena.co.uk>
References: <20190809095550.71040-1-yuehaibing@huawei.com>
 <20190809110100.71236-1-yuehaibing@huawei.com>
 <s5ha7cih53w.wl-tiwai@suse.de>
 <s5h7e7mh50z.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <s5h7e7mh50z.wl-tiwai@suse.de>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 02:55:40PM +0200, Takashi Iwai wrote:
> Takashi Iwai wrote:

> > Reviewed-by: Takashi Iwai <tiwai@suse.de>

> Actually I'm going to take this again on top of
> topic/hda-bus-ops-cleanup branch of my tree, so Mark, feel free to
> pull onto yours again.

I think I already applied it locally.

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NjTAACgkQJNaLcl1U
h9DRgQf/banNE1r4/WH27CPDpaxiqMQAQ8YwOySnqsMBgHlOnsO/s4SrwaIkKh+N
x6LbKhkkpRjDAsZ8ILqu4//DkrksxmWFs/j+XRHbPsbVsBTNReoshGfUQOrpjToN
qIEiYP2IOOO6UVozNlDWNarf2SOBTKKskNi6c2RmZBGJ8mvr58DYtezmtX13vVa/
MO4Zh2cEba+IV1d9RkNn5rARlLrAGt63o7/NsN+7GN4Bm3rUVy5KhBWdijO4KGlY
FgVFmbsw1e4bYyqwcLBrVb+I3D9KYLzKXo6tr8q1lYix+LurW0aBMGyn06UjLQ05
Gwg+/E7FTiFQo9cozC7H2xnQI5uB1Q==
=rnwt
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
