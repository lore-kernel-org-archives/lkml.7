Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD82B21019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551680812;
	bh=Vium3mBj9I6RjwBV0bGoveo24/PCh3NRnmBMTPtCG1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dQ8H44ZQBr9GGDh/8E/tMyj8Xj4NlR4fAScQUkc0WdPLluXCcZEu8QK5hUtXRPvLB
	 t/+w1UO9kzftVLekcdQVMi/qV37+7XJ/u8PY0mH5ujdHPDFKNLmT9TZsrYmDIGlcm9
	 Mlu6qU7duD95MDKhLscqkN7Zuw1oz/JCzofzebPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfCDG0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:26:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfCDG0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:26:50 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70EA920823;
        Mon,  4 Mar 2019 06:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551680810;
        bh=Vium3mBj9I6RjwBV0bGoveo24/PCh3NRnmBMTPtCG1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqi5SsYQlw5tdJQPg+fn4vl8IUJ75qz1xOxlU/7b3lP/4EzVsFJjd8WCieTrp8NGR
         QCY68ASPhfpGH4UYFV0Ez/uZzV+IyoR8OS7ug00KpZJUt6ZSV3LegmXaacBfBzfR7T
         S12JZ8NbDyo5FFGP/MOoFtJPnLkMf40rxC/laJb0=
Date:   Mon, 4 Mar 2019 08:26:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Roi Dayan <roid@mellanox.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Britstein <elibr@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] net/mlx5e: Remove redundant assignment
Message-ID: <20190304062645.GZ15253@mtr-leonro.mtl.com>
References: <20190302193933.GA13467@embeddedor.com>
 <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9r3HF47jptiQlX4s"
Content-Disposition: inline
In-Reply-To: <da1f1300-20f4-2929-078b-71ac1772a933@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9r3HF47jptiQlX4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 03, 2019 at 03:20:57PM +0000, Roi Dayan wrote:
>
>
> On 02/03/2019 21:39, Gustavo A. R. Silva wrote:
> > Remove redundant assignment to tun_entropy->enabled.
> >
> > Addesses-Coverity-ID: 1477328 ("Unused value")
> > Fixes: 97417f6182f8 ("net/mlx5e: Fix GRE key by controlling port tunnel entropy calculation")
>
> the commit doesn't fix any real issue but is more of a cleanup.
> so I'm not sure if fixes line is relevant or not.
> beside that looks ok.

It doesn't matter if it is real issue or not, the code is wrong and
should be fixed. This alone is enough to see the Fixes line.

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>

--9r3HF47jptiQlX4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcfMUlAAoJEORje4g2clinGywP/0ZpFYeue+bt8fx34KHJ8tyF
bpIcORNXSGq00bKlxkQzVcXWxUl8PsWDpYjfnGVX3dq1GypbNkRcqIW8hWxvfyYR
YmCTEsFFts1CguikXedcKIfBKg8dHWu4FZi2qzbAvn4nzdx/fUUK/1mu/P+3S+Gx
lDaChHQn83cR7Raik28S8ArJZLbSqebaZyYL+DkG6r1NE8to6EzTmdL/V6f9Z79W
DjZNbjJQ7ktZ0iHkPcSDDuPJadgAk6dViSiE4oYT8ZLGFo1v9Wj4S4BJiAkPlU1I
UAI+fGx4TpKYijDZqcNCIDyM2F0PlZqQmk/4Bb9bfgJP0ZE9kEumIq7oHydumgfl
C71HWwNnGXCbOYuk9xO5QSIIemn8fiOnWbQceckHIK9e39aKfFjp0io+rQ/JvMRP
2gXHig1hZ+soFSKhVXP8uM9n0D83JMDMWR9drcO7w1hvSrXE5EhzmfQ0uEopaYpA
H+4vSv6i8cnTNaYpSLF0aN6On+MzHXOwLs6eLRRtPqbSjJbA5Ul9GhQ/ZWq7w7u9
91wGT6PbwcfGQkP2RRATahTw5CjLSZ53r5FUS4VKmj+IlI4c0GaQUhnN7vKBDz8f
+V/iaXJyeiDxNZK7EGSMK7aNC+l50AXfmA9oKgrQL+A4vBeUKBFoZeBYCtIiAWiV
+gu47+oFj1mntPV+xdxK
=aGGP
-----END PGP SIGNATURE-----

--9r3HF47jptiQlX4s--
