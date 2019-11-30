Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15580C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD94A2075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SRYP/if9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfK3WFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:05:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:35495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfK3WFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575151523;
        bh=x0TZr+Zn4TKdey/kufD12/FaY6K7jn/4Q0qAw2Lh3jM=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=SRYP/if9zGvMXB/IM6IB32eI2imQjrpFy8FLx56HmQN1dRYczwticB4ho9R1bn0Dh
         AB2LTc6aYT1dnoJnv+7G4mh1NQoGkwGk80jMjk2wG1r1F8IvxX0wc78DqAerpWkvnW
         0MxvetBtZomzkqeusCPYH543Z4I8h6jRRz5vI7jI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.109]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MS3il-1iCbSi1Ec7-00TT6E; Sat, 30
 Nov 2019 23:05:23 +0100
Date:   Sat, 30 Nov 2019 23:05:20 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.5
Message-ID: <20191130220520.GA12883@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:jc4pZLQFebjwHsFWn0cmFlzew4yyM5x3TWsMrdY4SjjKUlDLtgi
 lsNJIAhQ7YwW/mvgsyECwPzC1X8G2eiUhapIw9emfVP+f5PECBayzhUeEuNwbCnQKXKK8nm
 vJkh3ZbddoSIixC1W464d8Wn1GNAed7DJHtTgLqteQfl4R+AEEtrEQzJLpn2ZATOWpgowkH
 S+P/vGkFHuwMpxAVx8Q9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C1NMR5U33vw=:Gc9flfjrZXNtnDBjHFdQM6
 UsuVuprAlTy+0SbCFmEU01pPG8NlW7JmX/fE4ImK8Qb7dGgrDO7efq92eSb4lVqcae+rWBm/4
 v0nMd5eefPF0DWvuxRRhFvHW3RJXEyMSoePqJ17FA7o7ET+4iGv+HBwEH5fwquK0DfeQllGuh
 i8nYcUCbuLdnJFeZ3h1q9CEymWDvkSkYcYg59XM1ePcZA97xE3sw3Ir5cWBt3GKCaMpCezp3H
 1HHMmmlKDw3VTFaDGggXK3ozow7grvYjZWFIGLsEUdiQyy3xkZy8SK7wlE3aNeYPf8c/DFO7b
 ZfpzTlKphM55fTCRDopZlQdCEVupQLi0LHaElZpruE35z9jrzQWCXqH6B6hJWwCOY4tFtYdgs
 YqTMpjwf2Fb3wX0YYaeObVoRB6sSQqA7XtEirlBCOS/zAKKw9CgkvAR/E7brnptMDZcfV3wbP
 KK4l6x39qJt4tAV/Zr6M1WFX/zx2c8/fjdUqsOKPOsDzQzzc25K9IgRUCCXzD4EpQ0RevWSPS
 AYeb3QwIXBMG3dg9539kJFacGrNx2XIdmifbSKo8i3T9v3weM+SQdV92Dt0e5o/n5tZoy0nd+
 jLWjQNqq4i+AG0ua7km/DqYBOwnRaiUGjn6tAmgBxqIiWoDu9931aA07xoYpOtghUCPCZ6yIq
 MI3uuHgxHt2m3qN2nMNj8pr7KIkNIts//ZNeGDL81ie/fEabTqnmpiNsFJrBTfw+bzQv6Jamx
 y1FoMkyyaLRexKO6DFDz8HGwZ8DhI70WFA34ctlsVXEfcMK4Xzk9UNT6GOvCJ22+Fviwap3S6
 j/tv1lKBm/9Qb8AoG1HtRtOHts+yEiFPd3GJk3xTA1QeFpYyO2YE4BkWOADl7AQjOvhakYoQ2
 Oh1M+dI3+NajHH+EqONe2baKDQai9Fpv9MSuzeqhHf6nKAyeGlxZErPehrOzai0mi3XhL2OSi
 aggSzF/i1mzh1J9CkizK24J/ftcE9Sg8kPpZXoXz8nHnqEB/azwBYddfdcM6lKHKxlHV3uKvT
 WFp7sU7xB3BqMCIAa2vvmCgZZp50iokHIXiNfLpKCRJ8fmyaHUQF/5Lfik5WJsJMPyakyHfPx
 +u/HxBvAhTKQIO09cGAsFgfqop9NKGTiOTzOt6AvVXv9YtI4Jlbfo+Li5isPAfgQHez7ibYa9
 Kk5T+Kr/ed2DESUVMDe2H/e8F8Hsz/yCiEFXAArREF0JlaQIAkjmEdpdVDD30GcFKD3+FE9Hu
 5EPo+iw0pHlrTqcOZIYB94xAm8OLPNHfzgDbn8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull new updates for the parisc architecture for kernel 5.5 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-1

Just trivial small updates: An assembler register optimization in the inlined
networking checksum functions, a compiler warning fix and don't unneccesary
print a runtime warning on machines which wouldn't be affected anyway.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (2):
      parisc: Do not hardcode registers in checksum functions
      kexec: Fix pointer-to-int-cast warnings

John David Anglin (1):
      parisc: Avoid spurious inequivalent alias kernel error messages

 arch/parisc/include/asm/checksum.h | 101 +++++++++++++++++++------------------
 arch/parisc/kernel/cache.c         |   2 +-
 kernel/kexec_file.c                |   4 +-
 3 files changed, 55 insertions(+), 52 deletions(-)
