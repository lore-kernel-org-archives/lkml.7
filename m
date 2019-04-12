Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44850C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132C120693
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555084360;
	bh=PrEYzva0qBO2/wZGTDzFAgUYn7v+WBL5x8rAHqM5aHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W6qBc1TThPWbXBYZY9aY/qn9+mXVzwjrRSaZVnXq6L6gtbvQYI4w1mP0bYtqjaXSh
	 dNxHHLzm9xPiYxfMH0YFe6OghupalJXXUfwQMq9MmUI2snS8Usw7pHpDs7Zu42HjF7
	 CTVikLtuggcNZ8IBfWWBcOZEdL6t2v8QdRCnTrpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfDLPwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726850AbfDLPwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:52:38 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1BA20693;
        Fri, 12 Apr 2019 15:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555084357;
        bh=PrEYzva0qBO2/wZGTDzFAgUYn7v+WBL5x8rAHqM5aHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uT7g0p4XWzmnz5AR4oQI+yN1j1IVWCSm1wT2GbFQBG7/jk4MuuFbHCq0Gut6JtxvM
         MwgOfVVYfFapaDWAOAwq3vTcaHf6VZw/LLCrYQioJxewBaWebEzXpxn/cGCHe5oEvd
         kjL0ogiS9DXk4jE9uiw9dfiuNmioVaLehNz6AkR8=
Date:   Fri, 12 Apr 2019 18:52:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/mlx5: check for error return in flow_rule
 rather than err
Message-ID: <20190412155234.GE3201@mtr-leonro.mtl.com>
References: <20190412104017.25507-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CqVFb5A8LpjztvkH"
Content-Disposition: inline
In-Reply-To: <20190412104017.25507-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CqVFb5A8LpjztvkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 11:40:17AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently when the call to create_flow_rule_vport_sq fails, the error
> check is being performed on err rather than on the return pointer
> flow_rule.  The return flow_rule maybe NULL (which is not considered
> an error) or an error code, so check for the error on flow_rule.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: d5ed8ac34cef ("RDMA/mlx5: Move default representors SQ steering to rule to modify QP")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--CqVFb5A8LpjztvkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcsLRCAAoJEORje4g2clinJTgP/2fgwFUh66hOcloEsSa6Yv0x
SjrXPwLwu+ppyOsmqyYHv3bgHmqkAH2h04hCRjeWHOfEU5hK4tmqnLuSM3cQ2Uxg
sXGaRSaQ6aqlQldjWtEM0Qtu9PdxeA1HVyLRyACtUdp9ze/pIKRU4DNVswoCazkA
RdhtjyEwq3pmZz7GkBYNjEtQFLxSnshEaghQvVdfcSdKBDZ7atlNeoKYgmz5LepZ
Xs5UIjKC+9oqD1Fv5yajbWBbAbJ9GCjSVkt5XW7P+G7fwlafUZ97jUF0kgEVC4Ib
LmKBniv3bmTLOnT5n2np+U7HJBUzpJmn0eDELVjZefBZAoTtcceK+xCT+J2Kf2QY
VhTXrUBrkgrZn8p8V+25655Hd4fHLujyvaC07Yn8evbBD3k5A6iysnkctbi3cPUS
Rhwa/vYJA6v+CDpUrBo2fg2KRrvIi6ghRUsiV6ItwQFF2WZQp6rBUsq8Hyxv6fSE
zr3Kh8GZ9lifEAJU57fE/I7m3yN3u0lPc6nVrtL5oR3KCdK6ZvYBG7njuBUDDg9m
7LtHN6syTZu/XUVJQkOKahYBicapEJusvReP74HtEYtVk53q1wToRnlyBbcLB2Za
5anuw9n7kKIzEJZNlxe77lJ+ZIE5SauT97n+m2qRBsOydnmlVp5GIE1+KmumQ7ZC
ny0e5BqclAnp/pnO3lUX
=j6pB
-----END PGP SIGNATURE-----

--CqVFb5A8LpjztvkH--
