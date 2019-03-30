Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25271C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61AF218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553936646;
	bh=9XpoHmj+dDePqF7x6cgjJlgDCldztdWkSvqcNO4PSQU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QlTn9Hx3Y7RDt2NHEX6j640bqmVtXeMBrIokGET+0xgYqfO71Uvlada/83BkT9pIn
	 i1SbiXHz/t66tNa2UrAEl1MOO9l6ja3HiSTmNLsxkHDe0LwalEz/fG04BIckCDJ5Of
	 PpNWFQLCJtd+qsNhggUy7EiyLXWMpLjjuzLdm6zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfC3JEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730462AbfC3JEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:04:04 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE082184D;
        Sat, 30 Mar 2019 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553936643;
        bh=9XpoHmj+dDePqF7x6cgjJlgDCldztdWkSvqcNO4PSQU=;
        h=Date:From:To:Cc:Subject:From;
        b=BgJvISHUxGi4A3gFwbIp34uZu0dcE3MAfbMj5EpS74oHC2XbJBWwwmjJsfky8eaU5
         r3Y/iuesttZ2oncbdZpsfvEO39Zjg9bWZ9LV1Z0GPGykcdow/frd9DH3deoJ2QKtMh
         CWgp4cJSJTk8IrEcD9/MVuPGG0BCXg2y80a1BHgk=
Date:   Sat, 30 Mar 2019 10:04:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial fixes for 5.1-rc3
Message-ID: <20190330090400.GA5598@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc3

for you to fetch changes up to f4e68d58cf2b20a581759bbc7228052534652673:

  tty: fix NULL pointer issue when tty_port ops is not set (2019-03-28 01:21:21 +0900)

----------------------------------------------------------------
TTY/Serial fixes for 5.1-rc3

Here are some small tty and serial driver fixes for 5.1-rc3.

Nothing major here, just a number of potential problems fixes for error
handling paths, as well as some other minor bugfixes for reported issues
with 5.1-rc1.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (2):
      serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
      serial: max310x: Fix to avoid potential NULL pointer dereference

Erin Lo (1):
      dt-bindings: serial: Add compatible for Mediatek MT8183

Fabien Dessenne (1):
      tty: fix NULL pointer issue when tty_port ops is not set

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Kangjie Lu (2):
      tty: atmel_serial: fix a potential NULL pointer dereference
      tty: mxs-auart: fix a potential NULL pointer dereference

Mao Wenan (1):
      sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()

Nathan Chancellor (1):
      tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup

Petr Štetiar (1):
      serial: ar933x_uart: Fix build failure with disabled console

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

 .../devicetree/bindings/serial/mtk-uart.txt        |  1 +
 drivers/tty/serial/ar933x_uart.c                   | 24 ++++------
 drivers/tty/serial/atmel_serial.c                  | 52 +++++++++++++++-------
 drivers/tty/serial/kgdboc.c                        |  4 +-
 drivers/tty/serial/max310x.c                       |  2 +
 drivers/tty/serial/mvebu-uart.c                    |  3 ++
 drivers/tty/serial/mxs-auart.c                     |  4 ++
 drivers/tty/serial/qcom_geni_serial.c              |  2 +-
 drivers/tty/serial/sc16is7xx.c                     | 12 ++++-
 drivers/tty/serial/sh-sci.c                        | 12 +----
 drivers/tty/tty_port.c                             | 10 ++---
 11 files changed, 75 insertions(+), 51 deletions(-)
