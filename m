Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686AE2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfC1Q0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfC1Q0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:26:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33A7EC0B6179
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:26:47 +0000 (UTC)
Received: from localhost (ovpn-116-113.ams2.redhat.com [10.36.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DED751F26;
        Thu, 28 Mar 2019 16:26:38 +0000 (UTC)
Date:   Thu, 28 Mar 2019 16:26:37 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] MAiNTAINERS: add Paolo, Stefan for virtio blk/scsi
Message-ID: <20190328162637.GD18536@stefanha-x1.localdomain>
References: <20190327153753.29827-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20190327153753.29827-1-mst@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 28 Mar 2019 16:26:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 11:38:53AM -0400, Michael S. Tsirkin wrote:
> Jason doesn't really have the time to review blk/scsi
> patches. Paolo and Setfan agreed to help out.
>=20
> Thanks guys!
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=20
> changes from v1:
> - use R tag for new reviewers
> - readd Jason as M
>=20
>  MAINTAINERS | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcnPW9AAoJEJykq7OBq3PIsKEH/0x6AAm5ay+SLiH9tnDPTGTb
NJ3y/b+NNxRIMDmNEo9TNOa1DX4q2z3xB4MMOHtrPuw4g6Ahq7DHpVCm74Nvax+c
mtNyyoUdNzG4tMwBkRfeuma+XtPocD7tkcpGhP/uFTDZkFE++1r5jyKotjUltFqa
d3cBe0QjdMDS7zSWQ6p2ilUue8PCSbN40f2LD9HKK2JrszW07aco+C4NDcG0fI2Q
o4Pj/nsivOvx1sKZLUyx+HxR30UxcELqbhoJWlIYxgm1ZeeEiWH43+BCUAT/t4jW
5/qi0ExqbKTKOfFNBM73jUZPVLzcWnpO95zY8F0T+dbNtgAkDNTr9Tnq5TUVP50=
=QusT
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
