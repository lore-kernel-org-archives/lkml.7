Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A23C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86C217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfC3MsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 08:48:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54280 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfC3MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 08:48:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hADOP-0000PK-EG; Sat, 30 Mar 2019 08:47:25 -0400
Message-ID: <c95e80728f218e94e96875a598a3f78fcf15ac82.camel@surriel.com>
Subject: Re: [PATCH 2/5] x86: Convert some slow-path static_cpu_has()
 callers to boot_cpu_has()
From:   Rik van Riel <riel@surriel.com>
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Joerg Roedel <jroedel@suse.de>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        linux-edac@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        virtualization@lists.linux-foundation.org, x86@kernel.org
Date:   Sat, 30 Mar 2019 08:47:20 -0400
In-Reply-To: <20190330112022.28888-3-bp@alien8.de>
References: <20190330112022.28888-1-bp@alien8.de>
         <20190330112022.28888-3-bp@alien8.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7z6HLHtaMuWI3fxAcNFu"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7z6HLHtaMuWI3fxAcNFu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-03-30 at 12:20 +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> Using static_cpu_has() is pointless on those paths, convert them to
> the
> boot_cpu_has() variant.

Oh, nice. That name much better conveys what it does.

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-7z6HLHtaMuWI3fxAcNFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlyfZVkACgkQznnekoTE
3oOdxggAqUX6qMFnfLWAtCCPapWspPumlMmhbRWe6NT9lL4VRHYED/NIKb/PsbdJ
uvX2u9OHG74Zf7UcJfLhadrfwtcy1HdPwRFfaE/sHS2SWloS/OmN3ret677pq0a7
S9nO+PDRPZ1v01iGc0s0P1ixeU3zp8gDVSNQaMsImIXuNwHBmzQ9BjKG+/58MwHk
ZwIGn/ZBTfagCdyIZByvewWBTGX49VQ05OjRjV4rE2bQ0Eg3Pp/Ov9wUCetzlqVe
Tq7MaXvPJ00Iuazo65vi7wwu8z6ubzE+5EF2SQGepYTX6b1O1lRs+7Oh6lAKGeTL
3exjitqcMVwbs6Q67HXaClLY3VfWAQ==
=oBPG
-----END PGP SIGNATURE-----

--=-7z6HLHtaMuWI3fxAcNFu--

