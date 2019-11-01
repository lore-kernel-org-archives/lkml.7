Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BCCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404221734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572601653;
	bh=CY/hMjHfyMMX+U7BKi2bH3TFPPXU/+N6UkBkX9i+Ewo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wfAgtb8LrBBWIJyxp0ttZD0FLpLmlxDfS/lmThxVrXaSC+aAJ3WfoiHdAIC6eqD4f
	 /55yibmREOunPJo/FnBtmRkhRdwHYPYcmrCbf/vGB3V0YUHetw1N/EwBA90WploUsI
	 173i71Trg2CxqvxaGBHGRRAFJwliy7y6gCUuLW5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfKAJrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfKAJrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:47:31 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B93F20862;
        Fri,  1 Nov 2019 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572601651;
        bh=CY/hMjHfyMMX+U7BKi2bH3TFPPXU/+N6UkBkX9i+Ewo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7FtnlFSbXmfDYtmTaGXcBHmbU02YgBn2F7tB35KASJT29vyBtOADArIDO5z72SWe
         9a2sFMYbs7XcdTRJk8mda2qMXP+3yIy0zDpuMKwbEMO7sw2ztTaAm3nxAU4xR/vyrR
         1krMgQdGgzp0Hos06JZzNzU5F3VGrpGyBf5zuMNk=
Date:   Fri, 1 Nov 2019 10:10:50 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
Message-ID: <20191101091050.iw3n4qiqyueoymif@hendrix>
References: <20191031231216.30903-2-karlp@tweak.net.au>
 <20191031231216.30903-3-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hyk2mpjmgefias6x"
Content-Disposition: inline
In-Reply-To: <20191031231216.30903-3-karlp@tweak.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hyk2mpjmgefias6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 11:12:16PM +0000, Karl Palsson wrote:
> The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
> 10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
> quad band 2G GSM module, a SIM800C.
>
> Full documentation and schematics available from vendor:
> http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>

It seems like it's something that can be connected / disconnected at
will?

If so, then it should be an overlay, not a full blown DTS.

Maxime

--hyk2mpjmgefias6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbv2mgAKCRDj7w1vZxhR
xTIaAP4pb+9RwvqXKqIc2E6Dpb3WFADpapl+AWFeMQpFWV27RgEAzsIeguDEm+wg
FPaKYna7zMELFqKZbFp9C2uGOBo5hwk=
=ia8F
-----END PGP SIGNATURE-----

--hyk2mpjmgefias6x--
