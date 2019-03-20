Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B424C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4441F2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553070895;
	bh=qRZab14eP7sQ4OC4smP21B5fzgo7KSOJOGmIYy+8cBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=EfDzry8DPWkAcUeIpb9nT3AzBmKIzqW56e5uXbhAajRTJV9p/JLDSMEZ+hPpn0ism
	 9Dq5x4yAM9UmG55J8ncXZAQOsckgzANOdVReyQbsClA4zvK3tX6ruysc/BEy8gVC2N
	 dpKdtRC+i0mr5AdNVwYHIHVyMSvkDsy88d2lpG2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfCTIex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:34:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:22756 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfCTIex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:34:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 01:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="asc'?scan'208";a="330243418"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 20 Mar 2019 01:34:49 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/38] vfs: Convert gadgetfs to fs_context
In-Reply-To: <27311.1553067744@warthog.procyon.org.uk>
References: <87o966uj6z.fsf@linux.intel.com> <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk> <155257998686.13720.8551460564620091523.stgit@warthog.procyon.org.uk> <27311.1553067744@warthog.procyon.org.uk>
Date:   Wed, 20 Mar 2019 10:34:45 +0200
Message-ID: <87imweueoq.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

David Howells <dhowells@redhat.com> writes:

> Felipe Balbi <balbi@kernel.org> wrote:
>
>> looks like a mostly mechanical change. Do you want this to go through
>> the USB tree or FS tree?
>
> I'm going to try and get all of these to go through the Al's vfs tree sin=
ce
> there are dependent cleanup patches that remove code that's then obsolete.

In that case, here's my ack:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

>> Also, do you mind doing the same for drivers/usb/gadget/function/f_fs.c?
>
> Sure.  The reason I hadn't already done it is that it doesn't look entire=
ly
> trivial.

oh, no rush :-) Just thought I'd mention.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyR+yUACgkQzL64meEa
mQbQ6A/+Nbvo0NIhqV7llh3gjU6rGpNqzBubdpCvsj7SztYe7KHCz1FXR3UD3N6P
BEL5zqzx/wwkfviEfPpsfoeAr14QxUXZykzs9XXudIdwi+yQjdZhI7akfZzs55uG
nfJi8vtaBhNb65bVubfBKVx8Lf6b1vBUBYu+XlAN2wYqiYf0mAFtKCwRhcn5mPt/
tjm2or4Hz6iZvN/OAkJ+0YxUg1WH2zHg4T360jeA34oNadxUh30+oW+swSzup2QN
MIG8ca4a9fY5oamsBagRgWs9somqCfTEbZWUxVIEEveZoTyuMt5A3I9ZxGkpFb8K
LI+M6gyqMhsoLQvRJVv9ApNbv/cIemlIo2Fu2alYd8sPdSKlndiRSqbFR7EBBAjw
twHYrqQctWjwrVgOpB7HduuNa9d9sUjAsgqgihL3+JZ77j+yghOUT5ie9FMe1z/N
M9YufNtVPW7YZH2NDUF23lHTwByFw4wEzqzmKsSLeagD6syMzbI1erOTqXiQrUe6
9iQ+d5Me+X3A35vX2guMcyRBmHZ6Q/oiMOz+Xbn5gsMzZW8Gt4QFm9avbG1k1DH/
0bAZgU0gIWJYbXMQdpOkyW2k3bvCNvlyoOPZNGqMUqH6IeliXL9FWrzWHN8Heo+R
70+GNwbtOLUY1lfuU/PAwWZEifAJ+CSI7wd4dubBWlr9j7eZgHk=
=yJmM
-----END PGP SIGNATURE-----
--=-=-=--
