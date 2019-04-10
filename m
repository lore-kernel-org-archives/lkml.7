Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F7F20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554896622;
	bh=YljnnGXjWdOAccMOUJq4AnuHSmHn6csOpXmxpGl8p6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yBmtFWf4ZxKtZSAlJIXr6bs0I7Pw/J9O5iEaSNQSTs987A/+FyZZ89VGqWKgSKCjB
	 yWd47Vba3KAhHEbDTIkWuMVFKKzuaXZNub+PZ1aDj0TfXcqfJ8Z89EbR5caG0EjMgR
	 XAMN47KOpJ3Gr4DHWUugTP2JkEzhd8nKUeuxU4Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfDJLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:43:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbfDJLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SntIsH+w7p+mNCiyrspdAtG2gh9RiEpPh/ZY9F4c1Jw=; b=T0p2+y7sCpSYYPoAbYeZry2EK
        ygU3rUCyUs4PqB2ToVucOOMTqv3nZMHgcbWMATG+YeEjW0k8UB3D0chZmYkt51eD8Ya2tFuio90DK
        ocUOG7PLPwXLFMk/t4IWJYr8jej6p3Okgr69jWkPzSudGAhIgBDejDEIYGHv+9qBgIVz4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEBd2-0008G7-SG; Wed, 10 Apr 2019 11:42:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 46C991128ED3; Wed, 10 Apr 2019 12:42:56 +0100 (BST)
Date:   Wed, 10 Apr 2019 12:42:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: cs43130: fix a NULL pointer dereference
Message-ID: <20190410114256.GN6106@sirena.org.uk>
References: <20190315035120.25913-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Content-Disposition: inline
In-Reply-To: <20190315035120.25913-1-kjlu@umn.edu>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2019 at 10:51:20PM -0500, Kangjie Lu wrote:
> In case create_singlethread_workqueue fails, the fix returns
> -ENOMEM to avoid potential NULL pointer dereference.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt1r8ACgkQJNaLcl1U
h9CeYQf/aYGE0HNsqPGPQ626dW6VPCc+lT4dA/WjxpXpnG2IV9DWJOPw5UC8fdzP
AlsOdyaxtt7oJkDqAl+mLfkfE9/dniCEmIqGJgfxTN7p0ztIxW1tYuFNwtb+0ULv
QyQMA9b43cFGiMjunrgW8pEir9wiANgDm6fCl0ezP56R//V91I9EFOXKHEBrOo/z
Jr8CmKv/Y8u7i1dJbdzXQAS07oqGhiUKePUmv5Pns8LcogNa0GrK/ztYFokU41gr
oywnMium81E5XmVf5ug4cE/Y4f1aGXQJZpdDTXw71jnlTVSwE9MU8vubsaKReNbT
1MpGpkmLJtIQz8AE3pHwtivrOqypJQ==
=8xzx
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
