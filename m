Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F5BC4CECB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69E2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568287925;
	bh=hax8S8P5CnNLhHFnRUK2Qi7PYJyXGpWmegiJgrXYQGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yAg8n4fi0hXL3jeW52hhy1Lf0gzjH0CAJ5DL56XHikZJu6rXSeALSdwoe1R5RWkEw
	 xXXTK9Qkq+U+qs+KtRURC56eZxTBmLJXZP00CLtVK+5g2hIiW0q4pW/omYEsxVHX/N
	 XrH1uYkBEQFjn1a53oHj97qu6xRS+SJY+jTEUCys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfILLcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:32:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34776 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILLcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hax8S8P5CnNLhHFnRUK2Qi7PYJyXGpWmegiJgrXYQGs=; b=n318wRq5Qe2aiE5vsduwGZsa4
        UZAQm1NPZ4eUcCeAj/yqddmGocdXajU+gStAS7FRRKbLNV0MJJ8qlvK7omIFhWrE7vwzU8lIzg8sT
        WTUYHK3H+QHn6gn0T/mmzwKND9dsMu9UlhwWrRYSBHcLXL7PViurmqQpNO48uvp7a3id8=;
Received: from 195-23-252-136.net.novis.pt ([195.23.252.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i8NKR-0006cF-1e; Thu, 12 Sep 2019 11:31:59 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6250CD0046D; Thu, 12 Sep 2019 12:31:58 +0100 (BST)
Date:   Thu, 12 Sep 2019 12:31:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panfrost: Use generic code for devfreq
Message-ID: <20190912113158.GM2036@sirena.org.uk>
References: <20190912112804.10104-1-steven.price@arm.com>
 <20190912112804.10104-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9YpAf2t6OxtMGzg"
Content-Disposition: inline
In-Reply-To: <20190912112804.10104-2-steven.price@arm.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9YpAf2t6OxtMGzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2019 at 12:28:03PM +0100, Steven Price wrote:
> Use dev_pm_opp_set_rate() instead of open coding the devfreq
> integration, simplifying the code.

Reviewed-by: Mark Brown <broonie@kernel.org>

--M9YpAf2t6OxtMGzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl16LK0ACgkQJNaLcl1U
h9C7GAf/UGcKiroXHB6Xwu6c+wguKxFe/pZn9YGxbP3rwdlfRXtcfdis0NRxZadm
z/iFjpjb38DFwwZfPycG27ebaREs5TQGA5adin1rHrgCLmgxj7PIWXSMOA+cLWiB
wy9Wx8wwQRPU39FCLnY2iLMnCSedJONOXSjTVzt7D8goCt99je2N97D0wxmw46lc
nW31A/3bHJbxEfWOe2YT0UFj/HSvdkR8Mu7dFwdWUHDHFrfuxMsukFmBCvh/BW12
M1+C8KF7nnvVZjYbwgGbsPaiwP+MyEeH6v8TEUOJ8ThGKr3zf2kKFp57gWMVwt+p
kRiXFavXN51n+vAwTZ6XoiBk2RdDoA==
=LFv8
-----END PGP SIGNATURE-----

--M9YpAf2t6OxtMGzg--
