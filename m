Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D278ECE58B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B45222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VLOiTfHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfJETcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 15:32:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:42921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfJETcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 15:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570303885;
        bh=guvfUw7HmyAnF4WXgsedYL2hAwkAjCvz6rxEvNIUWVM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VLOiTfHFWE5/G/mxJpblZMuKpCvfejA9gBZXIq4VyZNaFZLR9+KQK0LN1seqWeefb
         0BpHqBnlOs16N/aiU88Y6FbaYtv19R5wDTjoAgeR8N6l+WvNVPac4IVcZSaoXtsp9d
         Na7ZxP6jHKDdfbe1Dd9BnEfQl0tdWtmk/Oimrne0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.87]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1hruI63Blm-00juYL; Sat, 05
 Oct 2019 21:31:24 +0200
Date:   Sat, 5 Oct 2019 21:31:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Describe variadic macro argument in a
 Sphinx-compatible way
Message-ID: <20191005193123.GD19803@latitude>
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
 <20191004222439.GR2689@paulmck-ThinkPad-P72>
 <20191004232328.GC19803@latitude>
 <20191005133330.GX2689@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20191005133330.GX2689@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:TlKj5B/bW4AxfRFvk6Os9qa05J1tntDvMuM9dg2FalzlxrC3t4I
 +ZJBwL2eFkpMtGN1K4iA7+SViqhdauDgbrjIX3WXQGiE4TX5HkfhvkSxRZe/88bSxUxEG+F
 PnYusFm4nxP8tCcHmhTReNZqn9n8n2PaJBbk/XmymxLpGh5KXa8uDL1r+CQAJDjpFUi49lT
 kpJpzTGMHYZEIZGxZMFtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cPOH8VLYsjI=:I7KzBD0MUEOJuRlPl2iONf
 AMoMMYrjMrkUtkJzM3GZXYch8fWeMXEHehg05wPO70E6VCq81nIhFRoJMqQ1Pbh3amFrjk8Bk
 OgdTmpfni5fYYsOIkFbSrbgkrCtYtvASvn8Iw/EAu8OSsUC8p+HRBBSQk1N2yAnC2SANkxi62
 sTpnUPD0iH6+xgj/ObhoAD0kBo8gAZEl1HfQ51oUEM8Gb4Fpu3BX4VkFDmWQL+OUQRwCrTs0v
 wZTUvDvjltkxeuBFPMK7YPZoGw3RoFvn6tA53mL5qycKV+/V9uq+rcpkZL7oNzwWx2Pwr74CB
 t0pQGzfK0psm8yVv1PYEug2DTC4ED7BEqgq/3iXAbPEs/8SpoTpmKlCTT5sfvAqWsFN0Hq5tt
 RDbMAG9nYoEJQYu364172mEkAT80sRM981QAQZedM1apgizJ6krTHe9U9hPjgdkwS2ySNB1Gm
 DYT0K+4CUUbd9iq0rAAL/xxPldhfx3ZjI6kpwZDQ/+XzMgXGvwU57yVASO0zY6qDQZFigvB29
 Jdv8UB+BO0ixRqbSjQUOGaaVPdSyJl954sHiI2UoRYaT+3c1EQMdCR0uyRsPTD2Yr/6ejQQo7
 udx0sYltpgYKaSjMGDaFFMo8xJKrXy/8/lx5YT4mMWNdeXx+UJ3j5IYOWUiIs8WoiyxwZTOgT
 gZirTZZcSJY5ZvPph/+A9FlAwN77X0+ZKnG7EsoQ8mvt+3pBrY+J1mFkJQtslA8UnfGKRY3Fl
 texl4FXqK2HN77dLm9BhpAdKQFZcNSSlx/1/ByhcWybnY1CxOnJZhrjJ5tGVf+fElxm0HQOU1
 QrAgLPpGWLNB+aoc1hNs6JQuR2zwEJ97nWx0AKL5wHxqtMRifFlVkYfqfV4sxAu7inePInodA
 EBsXIfoOX/R8MjNoCd/DExCQM2hzC4J3xQPNUyBJXxl0WR9NGfbcjZiXZLP7/oOarrJYrA9C0
 aX+PIKL7+EvSGrqSQA1T3PDH9uu+99tuK0M3FZ4Zlrjpwxf6AHQjjn2B1ektsomJVJRVlwnU4
 SMkRFlHUoV9p4ToxX2OZE+2NSTd40f/11aQs0WTSLkOLMsGCqgpU3cNRRII/65dXeL8N6E1gk
 jb045SDgaiw+Y1WNJ5chMPwE3vb4QFafF/TsBKmbxfe+4+thdVXhkrbXxzy1eGD4XuFVAAGNS
 ASx4ut3afDBlY6LrwS8bxi7nf7eiu0rXmxybBDQ+M+R0C2+g7/z6wpwzv/tiv2IRdtLW/IN5t
 SPqtCZc4dX7HKDKBCwo8998hEGDELWYVounPCLTig9m8+5gHP8SP4fM5qtFY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2019 at 06:33:30AM -0700, Paul E. McKenney wrote:
> On Sat, Oct 05, 2019 at 01:23:28AM +0200, Jonathan Neusch=C3=A4fer wrote:
> > On Fri, Oct 04, 2019 at 03:24:39PM -0700, Paul E. McKenney wrote:
> > > On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neusch=C3=A4fer wr=
ote:
> > > > Without this patch, Sphinx shows "variable arguments" as the descri=
ption
> > > > of the cond argument, rather than the intended description, and pri=
nts
> > > > the following warnings:
> > > >=20
> > > > ./include/linux/rculist.h:374: warning: Excess function parameter '=
cond' description in 'list_for_each_entry_rcu'
> > > > ./include/linux/rculist.h:651: warning: Excess function parameter '=
cond' description in 'hlist_for_each_entry_rcu'
> >=20
> > Hmm, small detail that I didn't realize before: It's actually the
> > kernel-doc script, not Sphinx, that can't deal with variadic macro
> > arguments and thus requires this patch.
> >=20
> > So it may also be possible to fix the script instead. (I have not
> > looked into how much work that would be.)
>=20
> OK, thank you for letting me know.  I will keep your patch for the
> moment, but please let me know if the fix can be elsewhere.
>=20
> 							Thanx, Paul

Turns out the actual fix in scripts/kernel-doc is easy enough:

--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1449,6 +1449,10 @@ sub push_parameter($$$$) {
 	      # handles unnamed variable parameters
 	      $param =3D "...";
 	    }
+	    elsif ($param =3D~ /\w\.\.\.$/) {
+	      # for named variable parameters of the form `x...`, remove the dots
+	      $param =3D~ s/\.\.\.$//;
+	    }
 	    if (!defined $parameterdescs{$param} || $parameterdescs{$param} eq ""=
) {
 		$parameterdescs{$param} =3D "variable arguments";
 	    }

=2E.. but there are other macros in the code base that are documented
using the 'x...' syntax, so I guess it's best to take my initial patch
(or something similar) now, and I'll fix kernel-doc later, in a longer
patchset that also cleans up the fallout.


Thanks,
Jonathan Neusch=C3=A4fer

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl2Y74EACgkQCDBEmo7z
X9seLBAApUhpXCs+cuFaUMDhWI3bq2Q0cDj+W9ZnnWTky3ACzDpWMaGdXQUeAIHG
dMB28qPTK3i+Jz1Ua9CBpTMnFZ1WYxNyXoxwWfL9kfLNZ3b3B1nQ0o1dlsD5W+Yt
ZpZNnazTlc+eV+qhtuU5Li0bql13Yflp30Hi7Xul/NttHfP17QUfqjKyg53+4+tE
1afWISDq4npnET4eZ3uQkcgxs+Q4IaCSeezIPQpicCgCrrVbXg+c79Lru5lhreU9
S/TLHymw1lwN3Nfvp1NDos3NleAR8N4s4pAcCOGzS8E73Hvrir6tUsxDfCB6JOie
6HYB5o7NdEHJHic6KKXSzVHcORCGh/SfAIstWqAVYhjMZqKjCUXIDkAkCWNOGy6Z
u0QLPW6oJG5AMB4k+kqQvaRYB6VMjjju/d+qFMtSf7Bq0NzCoD0N3c42fkLPiHcr
6rUaEiCYU/VeTBUM+RwkoPs47H6dmfhvjeaQvvEGoWEmwHJGBKhA2Y71cOUj7oWS
Vc+dWcCxBT2vSzgK8fARvBZgjNFnTNpDydNxukWHYRF3CXxwQXQ3JOnsQPG8rbXI
YnG/tKZOjzuFWMVA3kkGBNfpcBPfvYaKsQnfpl+or5Pu/JHywjhd50JwebMkHMBq
1MqhCraA45/lC2JgOcz+6a7AGxkSydeU/jvWQHifJXS6bBjETV4=
=LvVB
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
