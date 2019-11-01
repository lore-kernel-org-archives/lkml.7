Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC68CCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D0F217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKASIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:08:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:37740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbfKASIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:08:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 624D2B4C8;
        Fri,  1 Nov 2019 18:08:04 +0000 (UTC)
Message-ID: <b0bc6ad6c485117731f715a00992c0e414ba8b85.camel@suse.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Greg Kerr <kerrnel@chromium.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 01 Nov 2019 19:07:59 +0100
In-Reply-To: <CAJGSLMtnxSqKvu3C7WQhMUUbzRXmfU1MVyLz8GcAQcAscdaZdw@mail.gmail.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
         <20191031184236.GE5738@pauld.bos.csb>
         <CANaguZCqHnR8b_68SSA_rfdkinVg8vLH66jQ_GhMsdOjuUHe3g@mail.gmail.com>
         <CAJGSLMtnxSqKvu3C7WQhMUUbzRXmfU1MVyLz8GcAQcAscdaZdw@mail.gmail.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kiEQsxrUjoC0Xq2LCIPe"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kiEQsxrUjoC0Xq2LCIPe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-11-01 at 09:35 -0700, Greg Kerr wrote:
> Has anyone considering shipping a V1 implementation which just allows
> threads from the same process to share a core together? And then
> iterating on that? Would that be simpler to implement or do the same
> fundamental problems exist as tagging arbitrary processes with
> cookies?
>=20
IMO, the latter, i.e., the same fundamental problem exist.

It's _tasks_ having to be scheduled in a certain way.

It does not matter much, as far as the necessary modifications to the
scheduler are concerned, whether those tasks are independent processes,
or threads or the same process, or vcpus of a VMs, etc...

Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-kiEQsxrUjoC0Xq2LCIPe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl28dIAACgkQFkJ4iaW4
c+6urxAA65yruhBKWSetTLrTdsl0zGlUKdeLYpinBuvhQ1Hp4Ml8LtDwQzTSPitX
b4JkJ9OHmknXRNfE/B9rYoUUAD/ZyJHTXn16AwWbiV+/EB+bQR9gEh8/q6HmT8Ic
SWhx65UQ5nn0jcl6YBw2QHxI3poxLCMhOPvOQDbHGJ1JLMoBHxskl8GpCc1M8rkn
ZpbscnqeEgLo/aGQindvCph2IJ43qPhixGDE/RpqYTjrfMz4aNcn/qCVhgLkMKKp
Zf+k/sSdwsYYZDJ9UbilFTSkHZvxJVovt8t9cUw8hJTPFbEtaW/mmfctmfZ5Eg56
DTzqgxMXPG0Ys719n1tltCnNMBo4MzEoE0YXv3n8AkbA4F1wb3dOTXuR54HaB2Dh
QKsHZku+kCfw3eLaGTFBteen0xSwV0B6rkyRpbblms0J88a1oO1haM97EKRaSdtJ
7hhq/Np+dz/hr67QhVQQozh6+XCljBnSdytchx1MMcKM6wfFBAu0T4U+jFEXe4b+
ncAFZIwRey42B5Z8OnIHNBZaSDAl/EIeiPNL6YGgdlByRRR2eChRknDtlmnSTdAl
lPbSNlX3OwO5DCxQlGjSj9cgaATYriwAR4bXwVYdnsuS1rLU4CxhNef04qhz04p/
DmpFLu3C5/+/HORiNVXw0Nf5N3e5HbRg3TLyN+kDZNnFt5MICX8=
=aaLJ
-----END PGP SIGNATURE-----

--=-kiEQsxrUjoC0Xq2LCIPe--

