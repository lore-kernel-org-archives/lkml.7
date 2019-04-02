Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE93620830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDBFoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:44:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:51056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfDBFon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:44:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 22:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,298,1549958400"; 
   d="asc'?scan'208";a="136797253"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2019 22:44:41 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC] Allowing modules to control tracing subsystem
In-Reply-To: <87h8bvffth.fsf@linux.intel.com>
References: <87h8bvffth.fsf@linux.intel.com>
Date:   Tue, 02 Apr 2019 08:44:31 +0300
Message-ID: <87k1gdezb4.fsf@linux.intel.com>
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

Felipe Balbi <felipe.balbi@linux.intel.com> writes:
> Hi guys,
>
> I've been thinking about turning my f-trace.c USB function [1] into an
> implementation of the USB Debug Class [2]. In order to support all
> requests, I would need means to control parts of the tracing subsystem,
> for example enabling and disabling tracing, flushing the trace buffer,
> changing trace buffer size, choose which trace events to enable, etc.
>
> Some of those functions (e.g. print_trace_line()) are available for
> things like trace_kdb.c [3], but they're not available for modules;
> i.e. they're not exported symbols.
>
> This will involve a rather large change to tracing subsystem however we
> could rely on such infrastructure for remote debugging of e.g. IVIs,
> phones, etc.
>
> The USB Debug Class already predicts the presence of JTAG access and
> Hardware tracing modules to be exported over USB. It also allows for
> GDB-type access. Adding our linux kernel tracing would make it into a
> complete tracing solution.
>
> In order to fully support this we would need, not only to expose some
> internal trace functions for modules, but I suppose the trace format
> would have to be slightly better defined so that it be decoded remotely
> give access to vmlinux.
>
> What do you guys think about this? Would this be something that folks
> would be interested in? Currently we can only export ftrace data, not
> trace events or anything else. Ideally we would export raw trace buffer
> entries to be decoded at a later moment.
>
> cheers
>
> [1] https://marc.info/?i=3D20190321094748.7031-1-felipe.balbi@linux.intel=
.com
> [2] https://www.usb.org/sites/default/files/documents/usb_debug_class_rev=
_1_0_final_0.pdf
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/trace/trace_kdb.c#n20

A gentle reminder here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyi9sEACgkQzL64meEa
mQaEvg//TSMz2p0hj3O7GdFFjVDBRXFkzRRQSLCwZZIpB44AnXcOCz/762WXBtg+
PCSEA8d63PV4AzmIw5mmvr33A6ivSWU/aoM1s+Cdj+NvaWu0m+VvE2TMNJPDvfGq
OnlkoUrBpW36cxbzSnFvMlilBdR16nXYioyim7CnkZDH+kJp4w3BXpVHWnKm7y7N
NmabZ62Re7wcEz0bz8BQ9vSfPWoaW0PqgNZQzB5dcyWSa7pDI9FMEp7Hcs9+rjUM
vEwUMJjjaqf0VLWIZjg+6EEOQ2brx/6On7nQ3ocflR7PJTAlaBy40wES9PHlyVyr
Uvk1oReiBphykqz233QGkLz2hr7z9iv74j+95uOA+JQ04/+xWOmdQw7dZo+LENto
Bv6TBktjDnfD6Do35IhswggoUejQV194pHxml7zjHaHD8zbIGNsHFBP/0y6LUp0J
JCoM5kQ7di1PAMCure5PRafmTsoYnp9BEpkvyAM63nojejx4ZwHT1GbL5oDFxCN5
YOP49uwQxH9KHhzx66j5WBCuN7oMcyKlPDWF0c8RI4zs/rkyW7iHnzxvAXOSl2dB
XDtkMYOaiq5H23pIHYTCfvDtuoNBl6YQ+5PcgyqXeneaMqbsORMfuIaT8K2Grz5h
mhtz6VGuDPa76t9r4KW4UlJwUc8ZSjvudrFxGZMisPSmeJ1EsHc=
=iVXs
-----END PGP SIGNATURE-----
--=-=-=--
