Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD29C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C421021920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568816258;
	bh=XlMjo+rJMmL2INhELdyisylIWWJuH9qmRMqjUBhMrPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y1ax0CrTV+fR04BmAMUdOZR48rP5Y7Ub7ZOpJEQ2MQMykBLENaxqqpZwl9fkwKQjs
	 5nb5c4d1CctjS5rDEjrNaKSBh9SBxxcOwvVqLPzaO3EoBpQXeiSyvUlxB37nVKIJiA
	 5RgMgzJmBHffkHIQkOgfauLEY2lTA6uHUZMd7i0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfIRORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfIRORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:17:37 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48A7218AF;
        Wed, 18 Sep 2019 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568816257;
        bh=XlMjo+rJMmL2INhELdyisylIWWJuH9qmRMqjUBhMrPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCU4sOePodZ0NZRXVMNEveX/tym8IABAHl9TG6H3SeCs3z6Ppyi6VenSOym+Cfzv/
         3ND6vGPBodkNZ3H9Hg5nUSBl97swamBntj6Lwn2frijgY9Qnkfoi5WyjGHQxpgutMR
         VgymzYgeFrgM7zIt6dH/U6bBqd5Btwkwb3V7T2Mc=
Date:   Wed, 18 Sep 2019 16:17:34 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     megous@megous.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190918141734.kerdbbaynwutrxf6@gilmour>
References: <20190914220337.646719-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdt6atu5ilzdls4s"
Content-Disposition: inline
In-Reply-To: <20190914220337.646719-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cdt6atu5ilzdls4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Sep 15, 2019 at 12:03:37AM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> There are various issues that this re-work of sun8i_[uv]i_layer_enable
> function fixes:
>
> - Make sure that we re-initialize zpos on reset
> - Minimize register updates by doing them only when state changes
> - Fix issue where DE pipe might get disabled even if it is no longer
>   used by the layer that's currently calling sun8i_ui_layer_enable
> - .atomic_disable callback is not really needed because .atomic_update
>   can do the disable too, so drop the duplicate code
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

It looks like these fixes should be in separate patches. Is there any
reason it's not the case?

Maxime

--cdt6atu5ilzdls4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYI8fgAKCRDj7w1vZxhR
xb0xAP0UxpXjzIgS09xk7fwpffpkj2Q3Yv0Qg6MWjDlQTkd50gEAy9kA6SNT4uzq
55chDp6x+7ABhqgw1Undj9ZVA3OQbQA=
=Op1q
-----END PGP SIGNATURE-----

--cdt6atu5ilzdls4s--
