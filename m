Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE8ECA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AC0217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572709369;
	bh=3CS3IEv2L4GzxRj2P0NzvngghoWYJ5gWWZyNPhTAZm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLscPJSHruwQccB3bDTuYxW3XvW67+ftbsgcsCXqRl1HRlQT050MOKw0QjRdMPgdq
	 DXs7YPzRL+x2757zNnnvpjMbFF3BpUofM8ixbhyeC/g+Y8JdtEuCDNpKqOJWZm/oea
	 zIXQgW61Empva4jiLdElAGUSKco72Xo2hfmu785A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKBPms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKBPms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:42:48 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7841D20663;
        Sat,  2 Nov 2019 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572709368;
        bh=3CS3IEv2L4GzxRj2P0NzvngghoWYJ5gWWZyNPhTAZm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfUd+NpkgCxrrKGOneVVfBmLi729LIeU+bctxhXLUX3sZWWsCAInrYL5DC+xjO4QL
         u+Rbqyxvodb9Qy1Ix+SmhyxBUmZlPK5+0uRD13pH+R5KEpKrfOsFyn7YvReYD9VPqE
         96S5cZVNZ4L8IK0W4ZUSBA7LWCSQE2D0LqeeTk4w=
Date:   Sat, 2 Nov 2019 16:42:45 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: arm: sunxi: add FriendlyARM NanoPi Duo2
Message-ID: <20191102154245.gxvji3w2wnh5qzu7@gilmour>
References: <20191101205535.7896-1-karlp@tweak.net.au>
 <20191101205535.7896-2-karlp@tweak.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ue74xj2vtktduj63"
Content-Disposition: inline
In-Reply-To: <20191101205535.7896-2-karlp@tweak.net.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue74xj2vtktduj63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 08:55:36PM +0000, Karl Palsson wrote:
> Adds bindings for the newly added NanoPi Duo2 board.
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>

Applied both, thanks
Maxime

--ue74xj2vtktduj63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXb2j9QAKCRDj7w1vZxhR
xaEzAP9KupnRjVKEivn/6aaHPJmtBXWewZ2OjKgUnRv4XQPMNgEA4F3idPR7gHO8
akyBGuXuWaXihn4ifxn14x3N+joakQ8=
=3764
-----END PGP SIGNATURE-----

--ue74xj2vtktduj63--
