Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A07C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ADD20B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHJKLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 06:11:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfHJKLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 06:11:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 465Hvp1Lwmz9sDQ;
        Sat, 10 Aug 2019 20:11:49 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-4 tag
Date:   Sat, 10 Aug 2019 20:11:49 +1000
Message-ID: <87imr5s522.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 5.3:

The following changes since commit d7e23b887f67178c4f840781be7a6aa6aeb52ab1:

  powerpc/kasan: fix early boot failure on PPC32 (2019-07-31 22:02:52 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-4

for you to fetch changes up to ed4289e8b48845888ee46377bd2b55884a55e60b:

  Revert "powerpc: slightly improve cache helpers" (2019-07-31 22:56:27 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.3 #4

Just one fix, a revert of a commit that was meant to be a minor improvement to
some inline asm, but ended up having no real benefit with GCC and broke booting
32-bit machines when using Clang.

Thanks to:
  Arnd Bergmann, Christophe Leroy, Nathan Chancellor, Nick Desaulniers, Segher
  Boessenkool.

- ------------------------------------------------------------------
Michael Ellerman (1):
      Revert "powerpc: slightly improve cache helpers"


 arch/powerpc/include/asm/cache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl1OmC4ACgkQUevqPMjh
pYBuKw/9H4ZMZpetAqOfJgfpByyhXlNRFriW1QS+KkMjjI60ZY1QYwZNFhZsUs8P
chpAvGnLv6zuJafOQ1hlxFa7wc70LTc/RRDRwWPFdtWdDl54OB3YvwFP2do2b/7D
gDtqCRMWTgtWdLx7ZpDk3qSN2mDxPRss//FO/UqtkTzNWh2LsQr9sbTZHc0BsIa/
VAyEZSGeFMkUBHjuCKoqyMZAc0aBk7HmJ4LN8zFGH6CtY05c1TBA4rN0qBnGBQI9
upNUgwbG2/vVS3t5YgHzHbrC8KfX+/8Oqo6ePLVlH39g0+wvp6avTeZDwrA7ZHtR
wNzHBxlLIpphOSRDr/fQk6yd69rVVbK14DZk3UHaz2qqyBkj3LxlRHKFIYWmPwoi
6E01ovThjSiHyxN1oPJfI1TXmhualhOlER9RTHPYsA20SnFYqAwH+TCydzuhvwAO
ueWSqKjK7O+KNhR1QJ3PGD6LIUWiPLMBG0a860Jg9oJ28/X5ZU/UqxBunoYUyQg+
u5bBViUtMkD8d7LEfQjvHSW9IpIRA/N2Y5cHTtmQxPEgspI/t/jXAxLEgkOBVkS2
kJoljNsTNFfKnyTD4v7zh5AABZquy5kyGLFBywQuloJ/7Jc4U3rBOqvRQ+f55E3s
naAU0Pf27Bob6VKKNPVeWP5OhPuYZ8YXHnvZ/fpcrYpA/k+xYsg=
=Dzq1
-----END PGP SIGNATURE-----
