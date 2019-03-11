Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B81204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCKAeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfCKAeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 20:34:15 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCBA20657;
        Mon, 11 Mar 2019 00:25:34 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu fix for v5.1
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <c2d18bdf-e9ed-6c43-57ea-695b82417530@linux-m68k.org>
Date:   Mon, 11 Mar 2019 10:25:31 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only a single change to provide platform side support for the eDMA
hardware module on the ColdFire MCF5441X SoC.

Regards
Greg




The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

   Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to d7e9d01ac2920959b474c6363dba269a868f4db9:

   m68k: add ColdFire mcf5441x eDMA platform support (2019-02-25 11:04:05 +1000)

----------------------------------------------------------------
Angelo Dureghello (1):
       m68k: add ColdFire mcf5441x eDMA platform support

  arch/m68k/coldfire/device.c       | 81 +++++++++++++++++++++++++++++++++++++++
  arch/m68k/coldfire/m5441x.c       |  4 +-
  arch/m68k/include/asm/m5441xsim.h | 15 ++++++++
  3 files changed, 98 insertions(+), 2 deletions(-)
