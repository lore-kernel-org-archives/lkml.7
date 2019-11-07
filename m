Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF99C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B4E2075C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573155126;
	bh=KHBa+k7hyLQ0MV0ubF5yXoe3GPRCg6Ei4nXyQ7DcToA=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=mK1QUIvRtez9wdR1KgMqu6qRRQUVJtuOLsRh5eU4Gg166NPOMCcY+5Uia7fEphWi/
	 rM6ik/kd12cPHvSUEVRflGYy7lElOSeaXdVuhU1R1PUnqwfV1e2s0cQ1yop63UeE+s
	 mzK6zR1CVnrc8zmuKQuC5vLDZHD+3eGVTlNUFAYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKGTcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:32:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfKGTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:32:03 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFC52075C;
        Thu,  7 Nov 2019 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573155123;
        bh=KHBa+k7hyLQ0MV0ubF5yXoe3GPRCg6Ei4nXyQ7DcToA=;
        h=Date:From:To:cc:Subject:From;
        b=SDJyJT5EsN4cJy3QsL3vUtnb1JzCoDLR6CXru/KKIyvCu8e1LRfxGe0RCvFiucygH
         Nb2MptfJUQUTc430DxBP7IV9G1gDwXMgcmoVT4VmAFfz3f6oPB1jZQSCV6iDKSaHt1
         wYU88V9XklPD9MwP0ENMvUT5xhnO3gHw7keNzbZ8=
Date:   Thu, 7 Nov 2019 20:32:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.1911072028330.1799@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive two fixes for HID subsystem:

=====
- regression fix for i2c-hid power management, from Hans de Goede
- signed vs unsigned API fix for Wacom driver, from Jason Gerecke
=====

Thanks.

----------------------------------------------------------------
Hans de Goede (1):
      HID: i2c-hid: Send power-on command after reset

Jason Gerecke (1):
      HID: wacom: generic: Treat serial number and related fields as unsigned

 drivers/hid/i2c-hid/i2c-hid-core.c |  4 ++++
 drivers/hid/wacom.h                | 15 +++++++++++++++
 drivers/hid/wacom_wac.c            | 10 ++++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
Jiri Kosina
SUSE Labs

