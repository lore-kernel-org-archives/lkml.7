Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A004218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 02:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfCWC6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 22:58:45 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:52003 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCWC6o (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 22 Mar 2019 22:58:44 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Sat, 23 Mar 2019 03:58:43 +0100
Received: from [192.168.0.30] (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Sat, 23 Mar 2019 02:58:18 +0000
Message-ID: <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, thibodux@gmail.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io,
        luca abeni <luca.abeni@santannapisa.it>
Date:   Sat, 23 Mar 2019 03:58:16 +0100
In-Reply-To: <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
         <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HnIYLTilu4YL1C/gCxSx"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HnIYLTilu4YL1C/gCxSx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-22 at 18:10 -0400, Boris Ostrovsky wrote:
> On 3/22/19 2:29 PM, thibodux@gmail.com wrote:
> > From: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>
> >=20
> > The original timer slop value has not changed since the
> > introduction
> > of the Xen-aware Linux kernel code. This commit provides users an
> > opportunity to tune timer performance given the refinements to
> > hardware and the Xen event channel processing. It also mirrors
> > a feature in the Xen hypervisor - the "timer_slop" Xen command line
> > option.
>=20
> Is there any data that shows effects of using this new parameter?
>=20
Yes, I've done some research and experiments on this. I did it together
with a friend, which I'm Cc-ing, as I'm not sure we're ready/capable to
share the results, yet (Luca?).

What I think I can anticipate is that having such a high value for
timer slop in the kernel, for the Xen clockevent device is (together
with the also quite high default value of timer_slop in Xen itself)
responsible for really high vcpu wakeup latencies.

Lowering those two values, reduces such latencies dramatically.

Regards,
Dario
--=20
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

--=-HnIYLTilu4YL1C/gCxSx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlyVoMgACgkQFkJ4iaW4
c+52Kg//eFjYf2HKPb7vNVUox18exTWL9qtU97e92MAVB/ikaUUucDfysCqZdSob
6b2tkrUBpM3D3691Ro4715p0dRhXubMRit08Y91La9UcGuamaXgECnHep0EoN3lw
CKh6PLUwu4OIfZ5fElhO3ZbMzBW4k2aHTnLCq5h9fZF1DqfOTXhu19K5DREHb+FH
Qlbok5iT+zIaRdWr+UHU4XJ+pTL8Nj1Pc1VsOq8iyKSA6152xDQ/oCYh9M5MT4UE
io1s0Kf7xKkF6msKQSQu3iLsLXboxRZmlW0QeTv0pA48MOB2NWQDYqPb23kLVy4v
W9zGzHAxJcfqT6+RbfFResGfn8W92St2EGsP9PkN/dM4L4ZDZidXYtyXAToNAdqC
kNwpJ0ezplM7/1x++tGhWRQLAKYNRKgfRTrPuIdMELQz9z1ZD/Mo8nmBeBj6YC+j
LLyT7n+BqGjE66kdo1Hghl1ZxdTrQYaC9xSH/P0NvaMCNll7HbOPKPSU19WySzZn
Is+N9yUf9NG2uxNRva/0b8GMGvKZH3DgrOs+O9rEkkCvArTyJZleuZjrC92fU5uf
kq0BPNPcIMc/d+jaUIsToJetlpB2jFpCiSAE9duEWpPZcsB2JUEEcNsvJkqxluhj
n2fjWizfFbMYip6wUckcbI4D6BxTcRy6DnjICQLIs5GK4aqyYnM=
=Ujww
-----END PGP SIGNATURE-----

--=-HnIYLTilu4YL1C/gCxSx--

