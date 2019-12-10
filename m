Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80141C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0CA2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLJLn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:43:56 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38896 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726957AbfLJLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:43:55 -0500
Received: from faui04g.informatik.uni-erlangen.de (faui04g.informatik.uni-erlangen.de [131.188.30.137])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2270A241838;
        Tue, 10 Dec 2019 12:43:54 +0100 (CET)
Received: by faui04g.informatik.uni-erlangen.de (Postfix, from userid 66991)
        id C8BE1843353; Tue, 10 Dec 2019 12:43:53 +0100 (CET)
From:   Simon Geis <simon.geis@fau.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Simon Geis <simon.geis@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Adam Zerella <adam.zerella@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        Lukas Panzer <lukas.panzer@fau.de>
Subject: [PATCH v2 00/10] PCMCIA/i82092: Fix style issues in i82092.c
Date:   Tue, 10 Dec 2019 12:43:24 +0100
Message-Id: <20191210114333.12239-1-simon.geis@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes all style issues in i82092.c
detected by checkpatch.pl.

Version 2 changes:
- merge whitespace patches into a single patch
- convert ?-operator to if statement (patch 7)
- rewrite commit messages
- add i82092 to subject
- modify enter/leave macro

Simon Geis (10):
  PCMCIA/i82092: use dev_<level> instead of printk
  PCMCIA/i82092: add/remove spaces to improve readability
  PCMCIA/i82092: remove braces around single statement blocks
  PCMCIA/i82092: insert blank line after declarations
  PCMCIA/i82092: change code indentation
  PCMCIA/i82092: move assignment out of if condition
  PCMCIA/i82092: shorten the lines with over 80 characters
  PCMCIA/i82092: include <linux/io.h> instead of <asm/io.h>
  PCMCIA/i82092: improve enter/leave macro
  PCMCIA/i82092: remove ifdef 0 block

 drivers/pcmcia/i82092.c   | 685 ++++++++++++++++++++------------------
 drivers/pcmcia/i82092aa.h |  16 +-
 2 files changed, 377 insertions(+), 324 deletions(-)

-- 
2.20.1

