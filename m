Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A52C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DC820715
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLASx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 13:53:26 -0500
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:54419 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfLASx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 13:53:26 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id xB1Ir8KB022637
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 1 Dec 2019 19:53:08 +0100
Date:   Sun, 1 Dec 2019 19:53:08 +0100
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [git pull] FireWire (IEEE 1394) update post v5.4
Message-ID: <20191201195308.363d0b83@kant>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from the tag "firewire-update" at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git firewire-update

to receive the following FireWire (IEEE 1394) subsystem updates:

  - another y2038 fix

  - janitorial: code movement

Arnd Bergmann (1):
      firewire: ohci: stop using get_seconds() for BUS_TIME

Stefan Richter (1):
      firewire: core: code cleanup after vm_map_pages_zero introduction

 drivers/firewire/core-cdev.c | 3 ++-
 drivers/firewire/core-iso.c  | 7 -------
 drivers/firewire/core.h      | 2 --
 drivers/firewire/ohci.c      | 2 +-
 4 files changed, 3 insertions(+), 11 deletions(-)

Tanks,
-- 
Stefan Richter
-======---== ==-- ----=
http://arcgraph.de/sr/
