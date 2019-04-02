Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A75C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735092064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554181635;
	bh=hPAq+5DNjlodosv+jOFGBbMdflPUblj3K+f6YzfowNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tHIbjCxdG04/w293FGLLSTlLtRVV1rTS1i8nVXy/aej/c8DmLyjfQ5XgbIEktgdd3
	 iAPCDqD7PEoY+8iO/9mMiA5+pOuG8mZpQwo19LBWVFVC5HLGz63+N6qjhKOKRwSwpY
	 IGejb7WMQPj/89rK+3NxdaoD750a3/2S5bb5lvxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfDBFHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:07:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36250 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBFHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jXYiFDGhPe+ygwXNP4lI3VsgweZrul+Xw/1CmuZGXhY=; b=HX9HCAIghgJqPz9DAOhUuLy8q
        jfNKNDcBS08kj9kvEQdf1HYIOf8atZXJRjWPgHuTTlcih8krTnJTTV2RQLAuBNyhYyXTrHZOWaGci
        dDVyM5+Cd2gfnt+lilydQjGuwketwCR1m95+YhMa6r8Gpl0eZrjS7PAxHMB75ZH8JF168=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBdA-0005oZ-Ic; Tue, 02 Apr 2019 05:06:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 5768B440082; Tue,  2 Apr 2019 06:06:37 +0100 (BST)
Date:   Tue, 2 Apr 2019 12:06:37 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Message-ID: <20190402050637.GW2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WjpOG6URjntW8FAF"
Content-Disposition: inline
In-Reply-To: <20190401205519.34023-2-fletcherw@chromium.org>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WjpOG6URjntW8FAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 02:55:19PM -0600, Fletcher Woodruff wrote:
> The rt5677 driver is using the wrong property names to read from ACPI.
> Update the property names to match those from _DSD, so that the correct
> GPIO pin numbers are read and that plug-detection works.

> With this patch, plugging and unplugging the headphone jack switches
> between headphones and speakers automatically.

What makes you say that these properties are wrong?  Are you sure that
this isn't just some other systems using different ACPI properties given
the poor standardization for ACPI?  Your new ones look like they're DT
properties pulled into ACPI while the existing ones look more idiomatic
for ACPI.  It'd be fine to add your new DT style properties but this
might break existing systems.

--WjpOG6URjntW8FAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi7dwACgkQJNaLcl1U
h9CbkQf/WC82vZ3PuZsyK74xvMhdBVp6PxhIpzNuTmt+ht69FlN/+2xENh/moPyL
v1kwMLY6DhnTURZTyYahB7MEC2uoeI07UigvX7q/JNCf/idJjPVB0LmO1oqXtw54
R6muFakxkBTz3eryzP73WUtlQzvL2vp4TrEjkC3S6uZtw4U1+NVWQf4lUoM6zQoV
VDqE5CAp/SqXvI0Gusbs6RvQ96U5mbm4aMP7s9Ci4OEpkgkyjUyt3Bhz+ht2Uk3K
hEtDx5MUWBMvmzN9/elsmNokV8eARhrmZhAT9590WT2DXj2eqarILImsZ4INCa+q
iVWQJB7qfBgF9rEhsZ2dFKcVhPxmwQ==
=wY0t
-----END PGP SIGNATURE-----

--WjpOG6URjntW8FAF--
