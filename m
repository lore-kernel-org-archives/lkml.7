Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B185721787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="h10ju8+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfK1P1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:27:41 -0500
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:35075
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726594AbfK1P1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1574954859; bh=BBopnqo6qohFLaZDooxmr9jLgdzlSTJflqclumYEoow=; h=Date:From:To:Cc:Subject:References:From:Subject; b=h10ju8+H2GjcW9b8CtTWsyLgQ+A1aV9j7mgiwYISBqkLVtZ9bSeEHfjw8xz10X5eKaatMYzrPvx+NeIf8Q/xIkGC2ZnvugK1X+88M61YMyC8q+fMHPc8t0pT8lfF0FP5vQ/0AQ5jc6CcFU/AARkCK748lMvtV0eJQA5ec2l+rWNq89dZLiygeGUzd/Avr4mAqxGmwZWlKGSfnkEx7098XVcOrCcL+piD40E4YIc9+nxVzsOFMmRMzii983RA+j83JdkcQpYsKMPDmGbY8HlH1ImMm+5JC9jy3tBoSR7uAWOpfyOqAWT+Tq526KW9xchL39hCFF14Z+IKUs0+yD3KbQ==
X-YMail-OSG: Xm6URX4VM1nRaeWmaNTm7ugAZVF1L..zbE2al1IEpUB6LFNtWbxbj7kKssMf3ZQ
 u6855OT2XAlkeoc9s.jbZ5pRjpzDaCZBbpYQRwjGQT5SqwO8RU6nrYngsHcwNMev24UHrntN2LfC
 RfOwA7jPdEXC8v0Wu5OciarIVZ42HzbBbNdQmwHh69_iv.zCrpQZwyyWOXjYJLXwyTjdgKSyDL3d
 SzA5DR_n1fMh_q4uxXvb6VeiMiUM0C.frGcJVur5ZejGqIbMOTriLRfFmlhqEOhiuVRGYPMYBicH
 mo6Qza1uphzTQDaoKSHn24QIqi9GqWFl_iUma86XgqMe87o1E9ucCst4O1.V_btr2ubB3XzEko9b
 Rw.EZLY42n..cbgL7v4r6Pj37V4bmFap56c8i6q4y0w8b5TwTUz2e7RHQiYCaxFdfcS8MM9Q20Hd
 c9t5BYXtG_hTcUaARsdRPiUDcDrULNxywVOsHy6RBJv_IxuqNibd94391R0NQpKEmvI0oujl.ulE
 q_zdzRMddCyfoIyXhR34NPo0hUw8318Dtv_1Wxj5VqLR5jRzrnAED39emgTV63el6xOrNcQOYR0Y
 2gxyXhMTY1XUgaI1Q3O1N5fE.gkdWf3SIOwcWdJzTkchmmLVriFpgxrg1n_wsaCF2ARxFs7flC77
 EvLXnktbStcSwUE8J87RkeebghSEEsCzB7ZTQtnoMSy2YcNXty.9XThCggTUXx3DWQtPfbiyoAkn
 M74jxHBL4QI6rv53NtX.3gKMUuVXPyGcnTjoKaOfHsJzOEY55Tah7ihCYrU0jGXHN0YQ.9Durc3E
 GsiWG4BYu9aBotsVbXGOEtnVxF1aOU.JGV0z7lIiPHnw8U9WzKW1BALEb1kZ_V5MtWWFA36J3VZV
 MT83bWHyACiqJ.ni3H7LKMvEqYaFMDJbWERynFvbf_HCWF7.Tr0JPySc.m0qW15TYIIF1spc7ORB
 wQyMDsLg417WhVOKmTviO4FWsVv4.G_Wy80RXIwqchVQcAQJMaJcbbl0jlB3FPndF8dBdsVsei3J
 kwulrVk43s2PCV8R2k9eM0_.j3cyebDCWE2dNIyFjbG1DhMpd9AScUXmnk6yO77SQz8pHEwvNAes
 t.kjcGagwuEEXebvtGtH86cIw7I.E3wYT0GLmYqXHlhRhgIfT8ZxusbHEwaZuWcXplj4ENJyUKwn
 QSqEfWi8P8sPc5_.nbJANbJQMNa1zVXEeqIGF927vXBRDDI78sTVAoPdPqvZICvYHiVXiYNBNNIT
 KxHLGOBCF__10cffNyDzp2FiaDL7Kr8xT4bjlAF19EC_Egn0y9L_mdSTCCd9MCotKKw19sflv8fQ
 XGeweunuehWEVgT5we1aSDaaIvtD1WgrXhEOjRNCbRTGMxSqF_u_9KXAgWYBVW_OwT.nrSjo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Nov 2019 15:27:39 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3a3072f52d7e668a9fb4b87cdd2c6c03;
          Thu, 28 Nov 2019 15:27:34 +0000 (UTC)
Date:   Thu, 28 Nov 2019 23:27:16 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: [GIT PULL] erofs updates for 5.5
Message-ID: <20191128152711.GA4993@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
References: <20191128152711.GA4993.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.5-rc1?

No major kernel updates for this round since I'm fully diving
into LZMA algorithm internals now to provide high CR XZ algorihm
support. It needs more work and time for me to get a better
compression time.

All commits have been in linux-next and tested with no smoke out.
This merges cleanly with master.

Happy Thanksgiving!
Gao Xiang

The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.5-rc1

for you to fetch changes up to 3dcb5fa23e16ef50b09e7a56b47d8e4c04ca09c0:

  erofs: remove unnecessary output in erofs_show_options() (2019-11-24 11:02:41 +0800)

----------------------------------------------------------------
Updates since last change:
- Introduce superblock checksum support;
- Set iowait when waiting I/O on the sync decompression path;
- Several code cleanups.

----------------------------------------------------------------
Chengguang Xu (1):
      erofs: remove unnecessary output in erofs_show_options()

Gao Xiang (6):
      erofs: clean up collection handling routines
      erofs: remove dead code since managed cache is now built-in
      erofs: get rid of __stagingpage_alloc helper
      erofs: clean up decompress queue stuffs
      erofs: set iowait for sync decompression
      erofs: drop all vle annotations for runtime names

Pratik Shinde (1):
      erofs: support superblock checksum

 fs/erofs/Kconfig        |   1 +
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |   3 +-
 fs/erofs/internal.h     |   7 +-
 fs/erofs/super.c        |  39 ++++++-
 fs/erofs/utils.c        |  17 ++-
 fs/erofs/zdata.c        | 288 +++++++++++++++++++++---------------------------
 fs/erofs/zdata.h        |   8 +-
 fs/erofs/zmap.c         |  28 ++---
 9 files changed, 190 insertions(+), 203 deletions(-)

