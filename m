Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C38C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7886C20673
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407486AbfIUGiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:38:55 -0400
Received: from mout01.posteo.de ([185.67.36.141]:50995 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405424AbfIUGiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:38:55 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 02:38:53 EDT
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 645A0160062
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2019 08:31:48 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46b12W2JCBz6tmB;
        Sat, 21 Sep 2019 08:31:47 +0200 (CEST)
Date:   Sat, 21 Sep 2019 08:31:50 +0200
From:   Michele Martone <michelemartone@users.sourceforge.net>
To:     linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Cc:     cocci@systeme.lip6.fr, Julia Lawall <julia.lawall@lip6.fr>
Subject: Munich, Germany, Oct. 8th: Intro to Semantic Patching with Coccinelle
Message-ID: <20190921063150.GN5628@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org, cocci@systeme.lip6.fr,
        Julia Lawall <julia.lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear Kernel Hackers,

Coccinelle is a tool routinely used to automatically upgrade Linux
kernel drivers, or catch certain bugs in C programs, or to restructure
C programs.

So some of you may be interested in the following event I'm holding=20
near Munich, Germany:

***************************************************************************=
****
  "Introduction to Semantic Patching of C programs with Coccinelle"

Tuesday, October 8, 2019, 10:00 - 17:00
Leibniz Supercomputing Centre (LRZ) of the Bavarian Academy of Sciences and
Humanities, Garching near Munich, Boltzmannstr. 1


The maintenance of a large software project can be very demanding. External
factors like evolving third-party software library APIs, or constantly chan=
ging
hardware platforms might require significant code adaptions for the code to=
 run
efficiently, or to run at all. Failure in coping with this can lead to
obsolescence, loss of performance, incompatibility, vendor lock-in, bugs.

Have you ever wondered how to detect and manipulate specified classes of C =
code
constructs, be it for code analysis, or better, to restructure an arbitrari=
ly
large codebase according to a specified, non-trivial `pattern', without wri=
ting
a C compiler?

In this training we introduce you to a tool to do exactly this: match and
restructure C codebases in a programmatic, formal way. The training will al=
so
show how to analyze code looking for interesting patterns (e.g. bugs),
integrate with your Python scripts to achieve the custom transformations you
need, and leverage Coccinelle's limited C++ support. Special attention will=
 be
on performance-oriented transformations, of other interests of HPC
practitioners.

After this training, you shall be able to write your own code transformatio=
ns,
be it for a refactoring, performance improvement, paving the way to an
experimental fork, or for debugging and further analysis.

Teacher: Dr. Michele Martone (LRZ)

Registration and further information
 https://www.lrz.de/services/compute/courses/2019-10-08_hspc1w19/
***************************************************************************=
****

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAl2Fw9YACgkQ4OZpyO8SWLghnwCdGLcErUKXkG79dWWpy28cdFRY
qWcAn1RLl2oJtf+J6R7c81WrTUE3YSsR
=ZVAf
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
