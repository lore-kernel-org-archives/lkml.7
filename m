Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1804C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E6218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553936668;
	bh=83l7bs0jMNJCY7CCRY2bsQk+K/tGfm44ibo+/skpJ/w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=yimYOq8FSBdXIJmnTouNp+fU9ooJdCeS70qNQu13VkFQ0l1b2mNSpRJDaOIZN8hNg
	 OUlrahAu4uWb/AO7QduiZAyJtpd5JKieK/s4d4QY0EgapinKOAEX+JnH4rCUUW/v7p
	 HU8QeleJ1SA2IfUpv7eXBGFZLqcfbOKuEpAssd5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfC3JE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfC3JE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:04:26 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C6E218AE;
        Sat, 30 Mar 2019 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553936665;
        bh=83l7bs0jMNJCY7CCRY2bsQk+K/tGfm44ibo+/skpJ/w=;
        h=Date:From:To:Cc:Subject:From;
        b=yrgQ4ddnVRtPeQYtZ2VpCZ5jLviVd+w7oSXOJ52f8gNfmC2dO1No1szG5Z7Xrq7i9
         JPjUhx5dJH4sbm9HKfxH+WM6Z+7ZbS8Ni+0crlkjYb8nXwryox9wm0dt526T+ZBAbw
         INykioUojC1KWmk58PkohYZTbM2zFaGaTphJ+EI0=
Date:   Sat, 30 Mar 2019 10:04:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging driver fixes for 5.1-rc3
Message-ID: <20190330090421.GA5644@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.1-rc3

for you to fetch changes up to cc26358f89c3e493b54766b1ca56cfc6b14db78a:

  staging: vt6655: Remove vif check from vnt_interrupt (2019-03-29 17:25:45 +0100)

----------------------------------------------------------------
Staging driver fixes for 5.1-rc3

Here are some small staging driver fixes for 5.1-rc3, and one driver
removal.

The biggest thing here is the removal of the mt7621-eth driver as a
"real" network driver was merged in 5.1-rc1 for this hardware, so this
old driver can now be removed.

Other than that, there are just a number of small fixes, all resolving
reported issues and some potential corner cases for error handling
paths.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (1):
      staging: octeon-ethernet: fix incorrect PHY mode

Aditya Pakki (3):
      staging: rtl8188eu: Fix potential NULL pointer dereference of kcalloc
      staging: rtlwifi: rtl8822b: fix to avoid potential NULL pointer dereference
      staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc

Arnd Bergmann (2):
      staging: olpc_dcon_xo_1: add missing 'const' qualifier
      staging: axis-fifo: add CONFIG_OF dependency

Chao Yu (1):
      staging: erofs: fix to handle error path of erofs_vmap()

Dan Carpenter (2):
      staging: rtl8712: uninitialized memory in read_bbreg_hdl()
      staging: vc04_services: Fix an error code in vchiq_probe()

Gao Xiang (2):
      staging: erofs: fix error handling when failed to read compresssed data
      staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()

Ian Abbott (1):
      staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest

Malcolm Priestley (2):
      staging: vt6655: Fix interrupt race condition on device start up.
      staging: vt6655: Remove vif check from vnt_interrupt

Maxim Zhukov (1):
      staging, mt7621-pci: fix build without pci support

NeilBrown (2):
      staging: remove mt7621-eth
      staging: mt7621-dts: update ethernet settings.

Samuel Thibault (1):
      staging: speakup_soft: Fix alternate speech with other synths

 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/axis-fifo/Kconfig                  |    1 +
 drivers/staging/comedi/comedidev.h                 |    2 +
 drivers/staging/comedi/drivers.c                   |   33 +-
 drivers/staging/comedi/drivers/ni_mio_common.c     |   10 +-
 drivers/staging/erofs/dir.c                        |   45 +-
 drivers/staging/erofs/unzip_vle.c                  |   45 +-
 drivers/staging/erofs/unzip_vle_lz4.c              |    7 +-
 drivers/staging/mt7621-dts/gbpc1.dts               |   29 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |   73 +-
 .../devicetree/bindings/net/mediatek-net-gsw.txt   |   48 -
 drivers/staging/mt7621-eth/Kconfig                 |   39 -
 drivers/staging/mt7621-eth/Makefile                |   14 -
 drivers/staging/mt7621-eth/TODO                    |   13 -
 drivers/staging/mt7621-eth/ethtool.c               |  250 ---
 drivers/staging/mt7621-eth/ethtool.h               |   15 -
 drivers/staging/mt7621-eth/gsw_mt7620.h            |  277 ---
 drivers/staging/mt7621-eth/gsw_mt7621.c            |  297 ---
 drivers/staging/mt7621-eth/mdio.c                  |  275 ---
 drivers/staging/mt7621-eth/mdio.h                  |   27 -
 drivers/staging/mt7621-eth/mdio_mt7620.c           |  173 --
 drivers/staging/mt7621-eth/mtk_eth_soc.c           | 2176 --------------------
 drivers/staging/mt7621-eth/mtk_eth_soc.h           |  716 -------
 drivers/staging/mt7621-eth/soc_mt7621.c            |  161 --
 drivers/staging/mt7621-pci/Kconfig                 |    1 +
 drivers/staging/octeon/ethernet-mdio.c             |    2 +-
 drivers/staging/octeon/ethernet.c                  |   40 +-
 drivers/staging/octeon/octeon-ethernet.h           |    4 +-
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c         |    2 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |    9 +-
 drivers/staging/rtl8188eu/include/rtw_xmit.h       |    2 +-
 drivers/staging/rtl8712/rtl8712_cmd.c              |   10 +-
 drivers/staging/rtl8712/rtl8712_cmd.h              |    2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   14 +-
 drivers/staging/rtl8723bs/include/rtw_xmit.h       |    2 +-
 drivers/staging/rtlwifi/phydm/rtl_phydm.c          |    2 +
 drivers/staging/rtlwifi/rtl8822be/fw.c             |    2 +
 drivers/staging/speakup/speakup_soft.c             |   16 +-
 drivers/staging/speakup/spk_priv.h                 |    1 +
 drivers/staging/speakup/synth.c                    |    6 +
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |    8 +-
 drivers/staging/vt6655/device_main.c               |   11 +-
 43 files changed, 276 insertions(+), 4587 deletions(-)
 delete mode 100644 drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
 delete mode 100644 drivers/staging/mt7621-eth/Kconfig
 delete mode 100644 drivers/staging/mt7621-eth/Makefile
 delete mode 100644 drivers/staging/mt7621-eth/TODO
 delete mode 100644 drivers/staging/mt7621-eth/ethtool.c
 delete mode 100644 drivers/staging/mt7621-eth/ethtool.h
 delete mode 100644 drivers/staging/mt7621-eth/gsw_mt7620.h
 delete mode 100644 drivers/staging/mt7621-eth/gsw_mt7621.c
 delete mode 100644 drivers/staging/mt7621-eth/mdio.c
 delete mode 100644 drivers/staging/mt7621-eth/mdio.h
 delete mode 100644 drivers/staging/mt7621-eth/mdio_mt7620.c
 delete mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.c
 delete mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.h
 delete mode 100644 drivers/staging/mt7621-eth/soc_mt7621.c
