Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF73C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255D92087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfGHMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:43:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36495 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGHMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:43:27 -0400
Received: by mail-yb1-f193.google.com with SMTP id t10so4666146ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 05:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version;
        bh=NSYJEc3Xb8BpBcoONOuMb72hVaZmCQHkx6o8X/fhj5A=;
        b=scPph9+l+zAR2FYuRWdSZZqtjMZvGtoYmYZFXfvW3s/IQV+bijM+LrjTazixwTBJUk
         EDSuHof3SsWkn6jFyfvPLg9ApnqZYD8//S+Z+SOi6eYQYUvjasxtF/pGrzxWytdQEl+0
         5dV93mcbjJvr+BRzWAdIOJokjO6Wz0TEJVcjoizlAQ/xzdCS+baYxXU54Qzh+yOQOPO8
         IRirOy1ywzUaXITH7mLCMoKbLZMPV3YpjJNf3xQCCSSo1MdXQO9DQE5sTvoeb5l/A0ux
         zysX8jmqaEpGAF6bmW4pU3/14uJuaHrl6MuWfIJwo0tzDM7zxM5+dxn2/XpyRp0WSeaq
         XsKQ==
X-Gm-Message-State: APjAAAW3k4NzklHXZ2qb3Wb0Bv9EUSifXkXIjbnEGwbhThFuY5G/vgzC
        q3OoWgWDhtQ4g3z4kfgaEdzpQPKYBPI=
X-Google-Smtp-Source: APXvYqz+3S0x2Xs/6Off+12Z/U4+aeO6+WMG4y9P/FIC7VRSDuNqkAdUXVS3He3YO1LfzbmQW1lw4g==
X-Received: by 2002:a25:380e:: with SMTP id f14mr9067240yba.334.1562589806517;
        Mon, 08 Jul 2019 05:43:26 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-2606-A000-1100-37D-0-0-0-43E.dyn6.twc.com. [2606:a000:1100:37d::43e])
        by smtp.gmail.com with ESMTPSA id q132sm4791440ywb.26.2019.07.08.05.43.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 05:43:25 -0700 (PDT)
Message-ID: <fc29b04c3efadbde6ac0352a124a6f436cdf5146.camel@redhat.com>
Subject: [GIT PULL] file lease fix and tracepoint for v5.3
From:   Jeff Layton <jlayton@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, ira.weiny@intel.com,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 08 Jul 2019 08:43:10 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fHhRQ0Z100z9G7eXU0Zr"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fHhRQ0Z100z9G7eXU0Zr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec=
:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/lock=
s-v5.3-1

for you to fetch changes up to 387e3746d01c34457d6a73688acd90428725070b:

  locks: eliminate false positive conflicts for write lease (2019-06-19 08:=
49:38 -0400)

----------------------------------------------------------------

Just a couple of small lease-related patches this cycle. One from Ira
to add a new tracepoint that fires during lease conflict checks, and
another patch from Amir to reduce false positives when checking for
lease conflicts.

----------------------------------------------------------------
Amir Goldstein (1):
      locks: eliminate false positive conflicts for write lease

Ira Weiny (1):
      locks: Add trace_leases_conflict

 fs/locks.c                      | 62 +++++++++++++++++++++++++++++++++++++=
+++++--------------------
 include/linux/fs.h              |  4 ++--
 include/trace/events/filelock.h | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 22 deletions(-)
--=20
Jeff Layton <jlayton@redhat.com>

--=-fHhRQ0Z100z9G7eXU0Zr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJHBAABCAAxFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAl0jOl4THGpsYXl0b25A
cmVkaGF0LmNvbQAKCRAADmhBGVaCFX5bD/4hGYrSj7x0M+cABtK3mLDWL/hXM6Vj
Itt20M0hu8r6eXLKi+LX4k9wjUhHihh1W5wOcV9cygm/yUInQNXksH1eqpH8Uxbm
XSwtq35zgU93xWI4WBN54oxq38OS1GlFDjQhi0mnVmSfkA3qH+xeYeVCPq2XXE6Z
nIUcHlaSo+ieC5LFxBS6IlWf4k/kNocGE9w0/aXXO3Y/gfHt0JMEtPTLKAzCDLmZ
ZPj0p37hw4oshOSsXzn38b1v9hsM6WZxxd4HdVcvAvjFB+UDZVtXqCr5ShVPdBJ7
S5CQDr5f1tWAKLKislkV0S+JjgwilAEZJkhtrFiirzCY4jtU5caVf1AyKUXEuQwR
Bgt03APcgSvDVrBVtWVLkMMXPkR9l3kktxIVNKvfuqxNa3/wB++H+7AF9CstKGFB
R2oS0Ds4BU4PMuiVUVx+gZsv+guiNFqfhBsyxk9JmN5mCyFY+d6XN/5J27PY8o2D
vZVDvmlToXpXAxkvrRZDzssP4naMXNfRsHZUvjZZtsnOxySVj3RzGC0kPSNxQKtR
DCJokiJ7cRuFJP1SZi1ZQRs7QIiubBOqBgKlGP1g8e0OnYLdy8/bmsnHidml9sBm
BylZAUEXQ8nCzUcLcIcDNMUL6HMyxHJHnwV6xJLsDR0iJdvAPHhN7fzOKzH0iWy/
2fVwiZ4qhRobRg==
=Le+h
-----END PGP SIGNATURE-----

--=-fHhRQ0Z100z9G7eXU0Zr--

