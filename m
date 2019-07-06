Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D6C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE14C21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 07:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGFH2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 03:28:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44010 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfGFH2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 03:28:00 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CE57428A417;
        Sat,  6 Jul 2019 08:27:58 +0100 (BST)
Date:   Sat, 6 Jul 2019 09:27:55 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c <linux-i3c@lists.infradead.org>
Subject: [GIT PULL] i3c: Changes for 5.3
Message-ID: <20190706092755.1e0e8275@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C PR for 5.3.

Regards,

Boris

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.3

for you to fetch changes up to ede2001569c32e5bafd2203c7272bbd3249e942e:

  i3c: master: Use struct_size() helper (2019-07-04 12:05:14 +0200)

----------------------------------------------------------------
* Drop support for 10-bit I2C addresses
* Add support for limited bus mode
* Fix the Cadence DT binding doc
* Use struct_size() to allocate a DEFSLVS packet

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      i3c: master: Use struct_size() helper

Przemyslaw Gaj (2):
      i3c: Drop support for I2C 10 bit addresing
      dt-bindings: i3c: Document dropped support for I2C 10 bit devices

Qii Wang (1):
      dt-bindings: i3c: cdns: Use correct cells for I2C device

Vitor Soares (3):
      i3c: fix i2c and i3c scl rate by bus mode
      i3c: add mixed limited bus mode
      i3c: dw: add limited bus mode support

 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt |  2 +-
 Documentation/devicetree/bindings/i3c/i3c.txt             |  4 +++-
 drivers/i3c/master.c                                      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/i3c/master/dw-i3c-master.c                        |  7 +------
 drivers/i3c/master/i3c-master-cdns.c                      | 10 +---------
 include/linux/i3c/master.h                                | 10 ++++++----
 6 files changed, 71 insertions(+), 44 deletions(-)
