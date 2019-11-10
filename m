Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D3C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6643A2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573400553;
	bh=filNipiIL+CojQ5NHq1u4otFdr1sJVcSn9uBuU1tBT0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KWe2QHTIdk7R/Nzg6H6u06d2l12EywBFZE7MMwmGF1NEV9lM4C/fbrpcWCnA/Ivds
	 PNYeVSklCDt2QVMLaq08RWezGm9wilBE4kQyBrwHzFw6l3waigRgU83fEDMoAuSvfH
	 haEXToq+cVaEFJ2O14DwI6KRW8J5cydjSXUR0Pus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKJPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfKJPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:42:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398CE206DF;
        Sun, 10 Nov 2019 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573400550;
        bh=filNipiIL+CojQ5NHq1u4otFdr1sJVcSn9uBuU1tBT0=;
        h=Date:From:To:Cc:Subject:From;
        b=0ozdXLfVkNaM1MDdzNZISOpXniSTj6wqr2wSXKuXqFkW9/vh3JtEog23iS5oo+tp1
         qhmXa2/rBe2ZkqTvUYrn68F/2cchMwASUDAjCCRJY0h1rkhyL3FPYp8Yku7HEltThC
         5qEyYX5TclfnlzjOFMOpKfm1mRRcufEB2eFlzb+A=
Date:   Sun, 10 Nov 2019 16:42:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.4-rc7
Message-ID: <20191110154228.GA2867363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d6d5df1db6e9d7f8f76d2911707f7d5877251b02:

  Linux 5.4-rc5 (2019-10-27 13:19:19 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc7

for you to fetch changes up to 9d55499d8da49e9261e95a490f3fda41d955f505:

  intel_th: pci: Add Jasper Lake PCH support (2019-11-04 15:01:25 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.4-rc7

Here are a number of late-arrival driver fixes for issues reported for
some char/misc drivers for 5.4-rc7

These all come from the different subsystem/driver maintainers as things
that they had reports for and wanted to see fixed.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (4):
      intel_th: gth: Fix the window switching sequence
      intel_th: msu: Fix an uninitialized mutex
      intel_th: pci: Add Comet Lake PCH support
      intel_th: pci: Add Jasper Lake PCH support

Bard Liao (1):
      soundwire: intel: fix intel_register_dai PDI offsets and numbers

Colin Ian King (2):
      intel_th: msu: Fix missing allocation failure check on a kstrndup
      intel_th: msu: Fix overflow in shift of an unsigned int

Georgi Djakov (1):
      interconnect: Add locking in icc_set_tag()

Greg Kroah-Hartman (3):
      Merge tag 'icc-5.4-rc5' of https://git.linaro.org/people/georgi.djakov/linux into char-misc-linus
      Merge tag 'thunderbolt-fixes-for-v5.4-1' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-next
      Merge tag 'soundwire-5.4-rc6' of git://git.kernel.org/.../vkoul/soundwire into char-misc-linus

Leonard Crestez (1):
      interconnect: qcom: Fix icc_onecell_data allocation

Michal Suchanek (2):
      soundwire: depend on ACPI
      soundwire: depend on ACPI || OF

Mika Westerberg (3):
      thunderbolt: Read DP IN adapter first two dwords in one go
      thunderbolt: Fix lockdep circular locking depedency warning
      thunderbolt: Drop unnecessary read when writing LC command in Ice Lake

Pierre-Louis Bossart (1):
      soundwire: slave: fix scanf format

Wei Yongjun (1):
      intel_th: msu: Fix possible memory leak in mode_store()

 drivers/hwtracing/intel_th/gth.c   |  3 +++
 drivers/hwtracing/intel_th/msu.c   | 11 ++++++++---
 drivers/hwtracing/intel_th/pci.c   | 10 ++++++++++
 drivers/interconnect/core.c        |  4 ++++
 drivers/interconnect/qcom/qcs404.c |  3 ++-
 drivers/interconnect/qcom/sdm845.c |  3 ++-
 drivers/soundwire/Kconfig          |  1 +
 drivers/soundwire/intel.c          |  4 ++--
 drivers/soundwire/slave.c          |  3 ++-
 drivers/thunderbolt/nhi_ops.c      |  1 -
 drivers/thunderbolt/switch.c       | 28 +++++++++++-----------------
 11 files changed, 45 insertions(+), 26 deletions(-)
