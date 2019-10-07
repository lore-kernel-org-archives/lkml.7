Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F4ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3F920673
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfJGQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:19:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:45452 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbfJGQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:19:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 069EDAD3E;
        Mon,  7 Oct 2019 16:19:29 +0000 (UTC)
Date:   Mon, 7 Oct 2019 18:19:26 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] cgroup, blkcg: prevent dirty inodes to pin dying memory
 cgroups
Message-ID: <20191007161925.GA23403@blackbody.suse.cz>
References: <20191004221104.646711-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20191004221104.646711-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2019 at 03:11:04PM -0700, Roman Gushchin <guro@fb.com> wrote:
> An inode which is getting dirty for the first time is associated
> with the wb structure (look at __inode_attach_wb()). It can later
> be switched to another wb under some conditions (e.g. some other
> cgroup is writing a lot of data to the same inode), but generally
> stays associated up to the end of life of the inode structure.
What about dissociating the wb structure from the charged cgroup after
the particular writeback finished? (I understand from your description
that wb structure outlives the dirtier and is kept due to other inode
(read) users, not sure if that's correct assumption.)

Michal

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2bZYYACgkQia1+riC5
qSgwXw/+Jt1YK9cwMYaKpGSYTvnZ7Gfx4QQ08b3nHeqwiAdaYqDv4KpZHcEBL4bY
XRyuxPlOHGhhAaZm+OvpR1Daix3FGb1LIaHwnagJ/6Uwu8lOoJXaKMmOh/GNLtgS
7jtLPWL/S9mSvvUlzNCzTZG0AFgvS2VdUYVb7oDRaDZs8eIffRulCIu5B2aDwvKo
2WWM8TAP2/ftiK8RUxOitGAi2upzk72dD2bg+7H0ffQL0wvCTCNEWAw5LUCL4cJF
+tpJPWkMAObCgGVfUNUx0KQaba0raoX1XM6W+eWWQVEzdTaR04MT7Y40qodSZDM1
ub7r6RGNAGitKQgoGKH5EE2rLhMcn4NP3qpNzkKAbaM+mV4+XcJEq6SnvwJwNtLW
xQFKWKQZqV049kLct3O+c1JpKGuZCKkXrc1+iYw4cIXwkfScyKQuPTBvavGZNpyJ
g+VDOsHUFI7FwYUPfL+HdtMTVdR2kTiFF3COLzhlSdH7L9DcFr4Usa8Q4BHZqL6G
d84ZbQmBAztcQYO3Br547otZ8zdEEeBkkbyzhYzEc7lpQxI6CYTavIwR05EnHecI
gzulHK2aLikIpgokf3k4QcF7BbVblqyIdPIES3ZDR0MWSiWE+boHXYdO8JhK1AAw
GXPuJQH7ibuUCHPu3+iZ/jlubKFvs4h4IBKIpqgbV17iKvpdwJQ=
=PXQV
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
