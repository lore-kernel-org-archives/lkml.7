Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E30C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0B276D3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559577892;
	bh=LNZAm9MbMd2wOXj54gpP2dOl8w/OYBkIpTy62sDjvZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MsoIk9ysLw2RBxyCbXgUfZeXYyRPWV9PGqDGxQZT/P+hhRjfbF6AYg0YiOAkyWeOh
	 ErZykNVd5kMzgVYVcRyxZ3s5SFTF/GO4CyKAAUzGeY4gQ7Nh1/Uz/YzIGD1FEjI69y
	 RSNwE4rfvrvsK6tWQhnzkKqaMp1UOozjlUcHocgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfFCQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:04:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfFCQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tT2HG5okus4hJgw9QU/wQuZR9JExuOgwKWTHzjjeb6Q=; b=J4mtivVhS7rU2EPLDMM6R1/8a
        ccMN3kqzO8V9BipYt5fp8welsJK+EQ1IOGFBjDz4MNvAmLfkA39O8KGhlpS0fQfPMqPGqnbJrxIe4
        JuiYB4F3CMIN/+RXJHRmygMX7zwU1llaEK+T6bR3JBmd2GqKrOZ3foIR8OtFCgZp/NW8s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXpS3-0002JB-Li; Mon, 03 Jun 2019 16:04:47 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 1A5F7440046; Mon,  3 Jun 2019 17:04:47 +0100 (BST)
Date:   Mon, 3 Jun 2019 17:04:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [RFC PATCH 42/57] drivers: regulator: Use
 class_find_device_by_of_node helper
Message-ID: <20190603160447.GD27065@sirena.org.uk>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-43-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <1559577023-558-43-git-send-email-suzuki.poulose@arm.com>
X-Cookie: Been Transferred Lately?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 04:50:08PM +0100, Suzuki K Poulose wrote:
> Use the generic helper to find a device matching the of_node.

Acked-by: Mark Brown <broonie@kernel.org>

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1RR4ACgkQJNaLcl1U
h9C2EAf2PYD6xY/y9LaBYAMD+T6pdYzojkeSfG6q30AB2n0CLvFwE0Ojd6jD6COa
FwnOP2yA2c3XtKn8EUzl0Lb+CYTXrCrS0IeWn8BCt90gyF9SelS+jP3bOSe4SujY
rnrGxSAGhzgx93fullPmpaBFV66/ik+a4yHSy7EvBYFYxmymduWb7NgEB0S35x6i
XsBjIQkTYOUbS6b7kYxxugxfB5Xtk9XKO6sZh5angdUIs8njz9PgTsxKUlg1vYM9
3iyzaDhCaj64PgDIhUzbz7PZgllIlqAJORLN4evuCH9dCNrRRmA+ypDCHLu9Y7tx
QAYV0VemvK5THyjk31UM9tjj0avC
=jMfv
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
