Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EBF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfC0WYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:24:42 -0400
Received: from sauhun.de ([88.99.104.3]:39500 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbfC0WYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:24:41 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 6BCD22E35A2;
        Wed, 27 Mar 2019 23:24:40 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:24:40 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
Message-ID: <20190327222439.GC15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-7-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Update iProc I2C binding document to add new compatible string
> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
> also added that allows configuration of the host view into the APE's
> address for "brcm,iproc-nic-i2c"

I don't know the platform, but wouldn't it be more DT-like to describe
the APE in DT and derive the mask from that information? Custom bindings
with values which are directly poked into a register usually raise my
eyebrow.


--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb+CcACgkQFA3kzBSg
Kbboag/9EHuslmj3cnJeJv0OKB36Bkf5I2w+Tm3yYxtWW8PxgAY2dXAYIbhacHUQ
Pv0Q71qIvLTOsSwGu+tnUPL8AaGSFY5V+sCCk/vgtrAnBz31rFo01TEoQOe07yTO
/Msb8NE7P6rEcL2V532nOlrVs69z/Ot5ww8VGC7RhsgzD/lOV2GDKySH0AfEDjV5
w3Ue9MeVLFABSYHoSvqE4OP5yjt1xCF15JamCQxDK8d39Kc9H8TzUiKeLDf+o6Cu
rk0hggQJmtHhwYi78GGHzrgScEDCgcfDJ/3b1FagE1/rodljipUVG7Te5AiISGz7
aFBnRkvNr2qyJvEuSjJ6yrUvqm5SX/Nt/Dn0qcbplN4GGCa2OSESIKBsjI9woa7q
anbZkvWZBr52fJwdEctDeAwLOgwvLadbMMjpXWWJ6FlZhOH5v3GiLFnRzgjxin+D
EVHAlHjT3nJgFX8jqcMFBfL2O2cljfkQIi7SNefzEA+ZxS6Vq1CsA49Jlo1PGDWz
BCKe9QpHGy0mdIO5GI//VaXFw2IJ/ZEfVb3m4Gx67qNhf5rulKpf5SP936hHPfkD
fVn48NldVdZHMGZwiqu/LJTuyBjxS1D81XLKbAtyXIGDc1nmRfeQg11ZBw8CNrEA
FiFKBssNNTNkgLC1Uww9nW9ZWKE+ak16LI2opgY1zfYOVyMk5yQ=
=0OSm
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
