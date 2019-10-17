Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D35ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A80214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408826AbfJQKUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:20:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731275AbfJQKUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:20:22 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL2tJ-0005xB-Ao; Thu, 17 Oct 2019 12:20:21 +0200
Message-Id: <20191017101900.925994783@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 17 Oct 2019 12:19:00 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Sebastian Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [patch 0/2] x86/ioapic: Prevent inconsistent state
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fell through the cracks:

  https://lore.kernel.org/lkml/20180717162531.7d4dmhbu5ijqg2uw@linutronix.de/

Instead of applying it as is, I've split it up into two pieces:

  - Fix the inconsistent mask state

  - Rename the functions

so the fix can be trivialy backported.

Thanks,

	tglx



