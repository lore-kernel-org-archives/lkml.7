Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D5C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E130726A32
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B8IhMCKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFCWU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:20:27 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:34748 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbfFCWU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:20:27 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4BFF9C0095;
        Mon,  3 Jun 2019 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559595844; bh=R+FVTEWGulAWEKsPb0obkH8ecitpx7eLDBgOUZworRU=;
        h=To:CC:From:Subject:Date:From;
        b=B8IhMCKQ3u/nIyeziU5WaOmUKM/JOM/21m4kGjtL9jbSiX4BV7exT/0uWl1SzS34P
         nr/xiAJT8RDTWNTs5LpvR1m7/KixO/XVpN/Aj1Xh18bKvvQyBFql92+kknomw70VI1
         3Aw9PIVF4TPafUSPC4Q0E2QqYs4msGMqx+foiu51G/4nFtbGxxxahPpPDo6p7m8BPJ
         l0Ta2LPTimxgiHCi/vE4SOuqK1WDsQp/Ut+DyJR9AXvs8tduohqIksrg+DQJP5cJje
         AlATMFZrQWpKFvshIp7N+ZMQFfLPExjFrm2yXmzySIj91fMujcF2Gg2UfCfcow4UNd
         Ge33dYlGr/lYQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8A5AEA0093;
        Mon,  3 Jun 2019 21:04:23 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Jun 2019 14:04:23 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Jun 2019 02:34:20 +0530
Received: from [10.10.161.35] (10.10.161.35) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Jun 2019 02:34:32 +0530
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Jose Abreu" <Jose.Abreu@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.2-rc4
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <e1a01d01-fccc-fab8-7022-9a18bb4d8f10@synopsys.com>
Date:   Mon, 3 Jun 2019 14:04:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.35]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull.

Thx,
-Vineet
------------------------->
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.2-rc4

for you to fetch changes up to 46e04c25e72f002d0d14be072300c2dd827d99b6:

  ARC: [plat-hsdk] Get rid of inappropriate PHY settings (2019-05-28 10:09:31 -0700)

----------------------------------------------------------------
ARC fixes for 5.2-rc4

 - Fix for userspace trying to access kernel vaddr space

 - HSDK platform DT updates

 - Cleanup some build warnings

----------------------------------------------------------------
Alexey Brodkin (1):
      ARC: [plat-hsdk] Get rid of inappropriate PHY settings

Eugeniy Paltsev (3):
      ARC: mm: SIGSEGV userspace trying to access kernel virtual memory
      ARC: [plat-hsdk]: enable creg-gpio controller
      ARC: [plat-hsdk]: Add support of Vivante GPU

Jose Abreu (2):
      ARC: [plat-hsdk]: Add missing multicast filter bins number to GMAC node
      ARC: [plat-hsdk]: Add missing FIFO size entry in GMAC node

Vineet Gupta (1):
      ARC: fix build warnings

 arch/arc/boot/dts/hsdk.dts      | 45 +++++++++++++++++++++++++++++++++++++----
 arch/arc/configs/hsdk_defconfig |  3 ++-
 arch/arc/include/asm/cmpxchg.h  | 14 +++++++++----
 arch/arc/mm/fault.c             |  9 +++------
 arch/arc/mm/tlb.c               | 13 +++++++-----
 5 files changed, 64 insertions(+), 20 deletions(-)
