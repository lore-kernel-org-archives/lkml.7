Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A842082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfCVLuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:45336 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728700AbfCVLuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 04:50:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="asc'?scan'208";a="157381266"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2019 04:49:59 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] usb: gadget: functions: add ftrace export over USB
In-Reply-To: <20190321123715.027e9369@gandalf.local.home>
References: <20170609061327.17899-1-felipe.balbi@linux.intel.com> <87ftrg8t3j.fsf@linux.intel.com> <20190321123715.027e9369@gandalf.local.home>
Date:   Fri, 22 Mar 2019 13:49:55 +0200
Message-ID: <87va0bdt7g.fsf@linux.intel.com>
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


Hi,

Steven Rostedt <rostedt@goodmis.org> writes:
>> Felipe Balbi <felipe.balbi@linux.intel.com> writes:
>> > Allow for ftrace data to be exported over a USB Gadget
>> > Controller. With this, we have a potentially very fast pipe for
>> > transmitting ftrace data to a Host PC for further analysis.
>> >
>> > Note that in order to decode the data, one needs access to kernel
>> > symbols in order to convert binary data into function names and what
>> > not.
>> >
>> > Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> > ---
>> >
>> > I wanted to take this through the gadget tree, but there is a
>> > dependency with a previous patch of mine adding and extra argument to
>> > the ->write() function. Hoping someone else will take it.=20=20
>>=20
>> This is still not upstream, I'll take it through my tree this time aroun=
d.
>>=20
>
> Can you post the latest to the list one more time. At least to make
> sure you got the naming correct ;-)
>
>   Not FTrace or f_trace.

The reason for the name was discussed already. See [1] and [2]

[1] https://marc.info/?i=3D878tl1qmrj.fsf@linux.intel.com
[2] https://marc.info/?i=3D20170609110717.3304f6b9@gandalf.local.home

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyUy+MACgkQzL64meEa
mQYSyA//UAdv8q0YIxsnPRtr0A97yMCnf2ek9v1xDrTf35+iHNJAqW75/KnhkI1h
3hRI+bllzLv3pasLTqUJ1obGeAwfSEUZmh4SPQg9jjFDaTy7gHYgDgeDWpaSb865
g+BYVRpUmWDjoSAqi4QixcBEx1lWp9DqZqbWbdyNzmNU5T2YkTnOf5NFjCSKK9oU
s0/eEbraz+Od3slimoFGiEm5/2b/+RY8u6E+GvIiMETGI1e//M+oLxH6Iq2bsWEZ
+3CjzKa72owlGWiBd2Jr7gSAfw69POJvakNqdSbCweQdMw6bHOMxQeJHruvLMx5A
jskqJKsOKgp/KEUwGWwIG4hdPc4Ll4Pj1bCWuBbuJqqdGYMYFnm5zq+4XPZwqmms
xXEP8ztEOPprsYJgf1CY4iGh+e5Z1L6tA5bSPfpMOojrQd8qTBdUZXltCa/Y6lpH
EA/2r7a9b1PSCUEQk3pp2dVRgImttQu0jIAcjhEv60eZJDVzDP4K3oesFVfOMHZH
3s0xnvcDhu8baX7WUsNGiBC3tLLJ9EWwDCBPW7h/ew1RDAgQo+aPj6CGcckRaHBr
6N0+hySAzLMNr9VPPh5DzMZBuq42RBt1EtvpdqjBM1EfL2uUqU+ldOzV4CMrux/j
DJjF490L6k9bjEyE1bEBsAxZvjvxjaMyDcd03v4qSUF/8WlClO4=
=LjAT
-----END PGP SIGNATURE-----
--=-=-=--
