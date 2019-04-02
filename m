Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07083C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7254208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554201134;
	bh=uicpaanTKMQdtRKOYGTTcTPcjTVK47G9uVWxDPh5RKs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kRaSS8WE0Jv8F+91NniVL8L0/0nsRoKQFCGjR1L488EXrw8hgxmtuCF892XH3Uc28
	 FvsPaQq3dpvB+1TOAgnJlpRtud+F4+gBD35ZmszMakKO4q6LDYOu4L/yct5o+SUGc8
	 4NnD7/XK1r18zKsilQV3AQkD9R+nAydqs+emRfHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfDBKcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:32:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB3C2084C;
        Tue,  2 Apr 2019 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554201130;
        bh=uicpaanTKMQdtRKOYGTTcTPcjTVK47G9uVWxDPh5RKs=;
        h=From:To:Cc:Subject:Date:From;
        b=1pzkcbBZ/MQKy6r1v3mKfQxu9OzkeCLFo/k/HOeH80YUu/miOmsIR6M8LARI/UVi7
         Ldv/8MB3BQjevlQoPI2uyw0GcphMN+NrhZfOilpU7ETKve6suhFYVvYHzdz+PE+zKM
         ze2cKKFbM5d9nqdqLHOHmNS0hZSh+UZoTPW/x2i8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/16] staging: fix up remaining SPDX problems in drivers/staging
Date:   Tue,  2 Apr 2019 12:31:47 +0200
Message-Id: <20190402103203.14959-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still some remaining SPDX file identifiers missing in the
drivers/staging/ tree.  When a new-developer comes along and tries to
fix up checkpatch.pl issues, and sends in a SPDX change, it is almost
always wrong as the developer doesn't really know the meaning behind the
tags or what needs to be done.

To fix this all up, just resolve all of the remaining SPDX identifier
issues in drivers/staging all at once.  Yes, this involved deleting an
entire driver, whose license was very odd and questionable, but once
that license is properly resolved, we can add it back if needed.

Greg Kroah-Hartman (16):
  staging: add missing SPDX lines to Kconfig files
  staging: add missing SPDX lines to Makefile files
  staging: m57621-mmc: delete driver from the tree.
  staging: sm750fb: add proper SPDX identifier to driver
  staging: vc04_services: add proper SPDX identifier for dual licensed
    files
  staging: vc04_services: remove remaining redundant license text
  staging: comedi: quatec_daqp_cs: add proper SPDX identifier to driver
  staging: iio: add proper SPDX identifiers to remaining driver files
  staging: rtl8192u: add proper SPDX identifiers on files that did not
    have them.
  staging: ralink-gdma: add proper SPDX identifiers on ralink-gdma file
  staging: rtl8192e: add proper SPDX identifiers on files that did not
    have them.
  staging: rtl8192e: delete license file.
  staging: media: zoran: add proper SPDX identifiers on files that did
    not have them.
  staging: media: soc_camera: add proper SPDX identifiers on files that
    did not have them.
  staging: media: imx: add proper SPDX identifiers on files that did not
    have them.
  staging: media: tegra-vde: add proper SPDX identifiers on file that
    did not have it.

 drivers/staging/Kconfig                       |    3 +-
 drivers/staging/Makefile                      |    1 -
 drivers/staging/android/Kconfig               |    1 +
 drivers/staging/android/Makefile              |    1 +
 drivers/staging/android/ion/Kconfig           |    1 +
 drivers/staging/axis-fifo/Kconfig             |    1 +
 drivers/staging/axis-fifo/Makefile            |    1 +
 drivers/staging/board/Kconfig                 |    1 +
 drivers/staging/board/Makefile                |    1 +
 drivers/staging/clocking-wizard/Kconfig       |    1 +
 drivers/staging/clocking-wizard/Makefile      |    1 +
 drivers/staging/comedi/Kconfig                |    1 +
 .../comedi/drivers/ni_routing/tools/Makefile  |    1 +
 .../staging/comedi/drivers/quatech_daqp_cs.c  |    1 +
 drivers/staging/comedi/kcomedilib/Makefile    |    1 +
 drivers/staging/emxx_udc/Kconfig              |    1 +
 drivers/staging/emxx_udc/Makefile             |    1 +
 drivers/staging/fbtft/Kconfig                 |    1 +
 drivers/staging/fsl-dpaa2/Kconfig             |    1 +
 drivers/staging/fsl-dpaa2/Makefile            |    1 +
 drivers/staging/fwserial/Kconfig              |    1 +
 drivers/staging/fwserial/Makefile             |    1 +
 drivers/staging/gasket/Kconfig                |    1 +
 drivers/staging/gasket/Makefile               |    1 +
 drivers/staging/gdm724x/Kconfig               |    1 +
 drivers/staging/goldfish/Kconfig              |    1 +
 drivers/staging/goldfish/Makefile             |    1 +
 drivers/staging/greybus/Kconfig               |    1 +
 drivers/staging/gs_fpgaboot/Kconfig           |    1 +
 drivers/staging/gs_fpgaboot/Makefile          |    1 +
 drivers/staging/iio/Kconfig                   |    1 +
 drivers/staging/iio/accel/Kconfig             |    1 +
 drivers/staging/iio/accel/Makefile            |    1 +
 drivers/staging/iio/accel/adis16203.c         |    3 +-
 drivers/staging/iio/accel/adis16240.c         |    3 +-
 drivers/staging/iio/adc/Kconfig               |    1 +
 drivers/staging/iio/adc/ad7192.c              |    3 +-
 drivers/staging/iio/adc/ad7192.h              |    3 +-
 drivers/staging/iio/adc/ad7280a.c             |    3 +-
 drivers/staging/iio/adc/ad7280a.h             |    3 +-
 drivers/staging/iio/adc/ad7780.c              |    3 +-
 drivers/staging/iio/adc/ad7816.c              |    3 +-
 drivers/staging/iio/addac/Kconfig             |    1 +
 drivers/staging/iio/addac/Makefile            |    1 +
 drivers/staging/iio/addac/adt7316-i2c.c       |    3 +-
 drivers/staging/iio/addac/adt7316-spi.c       |    3 +-
 drivers/staging/iio/addac/adt7316.c           |    4 +-
 drivers/staging/iio/addac/adt7316.h           |    3 +-
 drivers/staging/iio/cdc/Kconfig               |    1 +
 drivers/staging/iio/cdc/Makefile              |    1 +
 drivers/staging/iio/cdc/ad7150.c              |    3 +-
 drivers/staging/iio/cdc/ad7746.c              |    3 +-
 drivers/staging/iio/cdc/ad7746.h              |    3 +-
 drivers/staging/iio/frequency/Kconfig         |    1 +
 drivers/staging/iio/frequency/Makefile        |    1 +
 drivers/staging/iio/frequency/ad9832.c        |    3 +-
 drivers/staging/iio/frequency/ad9832.h        |    3 +-
 drivers/staging/iio/frequency/ad9834.c        |    3 +-
 drivers/staging/iio/frequency/ad9834.h        |    3 +-
 drivers/staging/iio/frequency/dds.h           |    3 +-
 .../staging/iio/impedance-analyzer/Kconfig    |    1 +
 .../staging/iio/impedance-analyzer/Makefile   |    1 +
 .../staging/iio/impedance-analyzer/ad5933.c   |    3 +-
 drivers/staging/iio/meter/Kconfig             |    1 +
 drivers/staging/iio/meter/ade7854-i2c.c       |    3 +-
 drivers/staging/iio/meter/ade7854-spi.c       |    3 +-
 drivers/staging/iio/meter/ade7854.c           |    3 +-
 drivers/staging/iio/resolver/Kconfig          |    1 +
 drivers/staging/iio/resolver/Makefile         |    1 +
 drivers/staging/iio/resolver/ad2s1210.c       |    6 +-
 drivers/staging/ks7010/Kconfig                |    1 +
 drivers/staging/ks7010/Makefile               |    1 +
 drivers/staging/media/Kconfig                 |    1 +
 drivers/staging/media/bcm2048/Kconfig         |    1 +
 drivers/staging/media/bcm2048/Makefile        |    1 +
 drivers/staging/media/davinci_vpfe/Kconfig    |    1 +
 drivers/staging/media/davinci_vpfe/Makefile   |    1 +
 drivers/staging/media/imx/Kconfig             |    1 +
 drivers/staging/media/imx/imx-ic-common.c     |    6 +-
 drivers/staging/media/imx/imx-ic-prp.c        |    6 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c   |    6 +-
 drivers/staging/media/imx/imx-ic.h            |    6 +-
 drivers/staging/media/imx/imx-media-capture.c |    6 +-
 drivers/staging/media/imx/imx-media-csi.c     |    6 +-
 drivers/staging/media/imx/imx-media-dev.c     |    6 +-
 drivers/staging/media/imx/imx-media-fim.c     |    6 +-
 .../staging/media/imx/imx-media-internal-sd.c |    6 +-
 drivers/staging/media/imx/imx-media-of.c      |    6 +-
 drivers/staging/media/imx/imx-media-utils.c   |    6 +-
 drivers/staging/media/imx/imx-media-vdic.c    |    6 +-
 drivers/staging/media/imx/imx-media.h         |    6 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c    |    6 +-
 drivers/staging/media/ipu3/Kconfig            |    1 +
 drivers/staging/media/ipu3/Makefile           |    1 +
 drivers/staging/media/mt9t031/Kconfig         |    1 +
 drivers/staging/media/mt9t031/Makefile        |    1 +
 drivers/staging/media/rockchip/vpu/Kconfig    |    1 +
 drivers/staging/media/rockchip/vpu/Makefile   |    1 +
 drivers/staging/media/soc_camera/Kconfig      |    1 +
 drivers/staging/media/soc_camera/imx074.c     |    6 +-
 drivers/staging/media/soc_camera/mt9t031.c    |    6 +-
 drivers/staging/media/soc_camera/soc_camera.c |    6 +-
 .../staging/media/soc_camera/soc_mediabus.c   |    6 +-
 .../staging/media/soc_camera/soc_mt9v022.c    |    6 +-
 drivers/staging/media/soc_camera/soc_ov5642.c |    6 +-
 drivers/staging/media/soc_camera/soc_ov9740.c |    6 +-
 drivers/staging/media/sunxi/Kconfig           |    1 +
 drivers/staging/media/sunxi/Makefile          |    1 +
 drivers/staging/media/sunxi/cedrus/Kconfig    |    1 +
 drivers/staging/media/sunxi/cedrus/Makefile   |    1 +
 drivers/staging/media/tegra-vde/Kconfig       |    1 +
 drivers/staging/media/tegra-vde/Makefile      |    1 +
 drivers/staging/media/tegra-vde/uapi.h        |   11 +-
 drivers/staging/media/zoran/Kconfig           |    1 +
 drivers/staging/media/zoran/videocodec.h      |   17 +-
 drivers/staging/media/zoran/zoran.h           |   12 +-
 drivers/staging/media/zoran/zoran_card.c      |   12 +-
 drivers/staging/media/zoran/zoran_card.h      |   12 +-
 drivers/staging/media/zoran/zoran_device.c    |   12 +-
 drivers/staging/media/zoran/zoran_device.h    |   12 +-
 drivers/staging/media/zoran/zoran_driver.c    |   13 +-
 drivers/staging/media/zoran/zoran_procfs.c    |   12 +-
 drivers/staging/media/zoran/zoran_procfs.h    |   12 +-
 drivers/staging/media/zoran/zr36016.c         |   18 +-
 drivers/staging/media/zoran/zr36016.h         |   18 +-
 drivers/staging/media/zoran/zr36050.c         |   18 +-
 drivers/staging/media/zoran/zr36050.h         |   18 +-
 drivers/staging/media/zoran/zr36057.h         |   12 +-
 drivers/staging/media/zoran/zr36060.c         |   18 +-
 drivers/staging/media/zoran/zr36060.h         |   18 +-
 drivers/staging/most/Kconfig                  |    1 +
 drivers/staging/most/cdev/Kconfig             |    1 +
 drivers/staging/most/cdev/Makefile            |    1 +
 drivers/staging/most/dim2/Kconfig             |    1 +
 drivers/staging/most/dim2/Makefile            |    1 +
 drivers/staging/most/i2c/Kconfig              |    1 +
 drivers/staging/most/i2c/Makefile             |    1 +
 drivers/staging/most/net/Kconfig              |    1 +
 drivers/staging/most/net/Makefile             |    1 +
 drivers/staging/most/sound/Kconfig            |    1 +
 drivers/staging/most/sound/Makefile           |    1 +
 drivers/staging/most/usb/Kconfig              |    1 +
 drivers/staging/most/usb/Makefile             |    1 +
 drivers/staging/most/video/Kconfig            |    1 +
 drivers/staging/most/video/Makefile           |    1 +
 drivers/staging/mt7621-dma/Kconfig            |    1 +
 drivers/staging/mt7621-dma/Makefile           |    1 +
 drivers/staging/mt7621-dts/Kconfig            |    1 +
 drivers/staging/mt7621-dts/Makefile           |    1 +
 drivers/staging/mt7621-mmc/Kconfig            |    8 -
 drivers/staging/mt7621-mmc/Makefile           |   42 -
 drivers/staging/mt7621-mmc/TODO               |    8 -
 drivers/staging/mt7621-mmc/board.h            |   63 -
 drivers/staging/mt7621-mmc/dbg.c              |  311 ---
 drivers/staging/mt7621-mmc/dbg.h              |  106 -
 drivers/staging/mt7621-mmc/mt6575_sd.h        |  485 -----
 drivers/staging/mt7621-mmc/sd.c               | 1859 -----------------
 drivers/staging/mt7621-pci-phy/Kconfig        |    1 +
 drivers/staging/mt7621-pci-phy/Makefile       |    1 +
 drivers/staging/mt7621-pci/Kconfig            |    1 +
 drivers/staging/mt7621-pci/Makefile           |    1 +
 drivers/staging/mt7621-pinctrl/Kconfig        |    1 +
 drivers/staging/mt7621-pinctrl/Makefile       |    1 +
 drivers/staging/mt7621-spi/Kconfig            |    1 +
 drivers/staging/mt7621-spi/Makefile           |    1 +
 drivers/staging/netlogic/Kconfig              |    1 +
 drivers/staging/netlogic/Makefile             |    1 +
 drivers/staging/nvec/Kconfig                  |    1 +
 drivers/staging/octeon-usb/Kconfig            |    1 +
 drivers/staging/octeon/Kconfig                |    1 +
 drivers/staging/olpc_dcon/Kconfig             |    1 +
 drivers/staging/olpc_dcon/Makefile            |    1 +
 drivers/staging/pi433/Kconfig                 |    1 +
 drivers/staging/pi433/Makefile                |    1 +
 drivers/staging/ralink-gdma/Kconfig           |    1 +
 drivers/staging/ralink-gdma/Makefile          |    1 +
 drivers/staging/ralink-gdma/ralink-gdma.c     |    7 +-
 drivers/staging/rtl8188eu/Kconfig             |    1 +
 drivers/staging/rtl8192e/Kconfig              |    1 +
 drivers/staging/rtl8192e/license              |  339 ---
 drivers/staging/rtl8192e/rtl8192e/Kconfig     |    1 +
 .../staging/rtl8192e/rtl8192e/r8190P_def.h    |   18 +-
 .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |   17 +-
 .../rtl8192e/rtl8192e/r8190P_rtl8256.h        |   17 +-
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c |   17 +-
 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h |   16 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   19 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |   22 +-
 .../rtl8192e/rtl8192e/r8192E_firmware.c       |   17 +-
 .../rtl8192e/rtl8192e/r8192E_firmware.h       |   16 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h |   18 +-
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.c  |   18 +-
 .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  |   16 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |   17 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.h    |   16 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h |   16 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h   |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   20 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |   16 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h    |   16 +-
 .../staging/rtl8192e/rtl8192e/rtl_eeprom.c    |   19 +-
 .../staging/rtl8192e/rtl8192e/rtl_eeprom.h    |   21 +-
 .../staging/rtl8192e/rtl8192e/rtl_ethtool.c   |   18 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c   |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h   |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |   17 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h    |   17 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h    |   19 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |   17 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h    |   17 +-
 drivers/staging/rtl8192e/rtl819x_BA.h         |   16 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |   16 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |   16 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     |   16 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h        |   16 +-
 drivers/staging/rtl8192e/rtl819x_TS.h         |   16 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |   16 +-
 drivers/staging/rtl8192e/rtllib.h             |    6 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c  |    6 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c   |    6 +-
 drivers/staging/rtl8192e/rtllib_debug.h       |   22 +-
 drivers/staging/rtl8192e/rtllib_module.c      |   19 +-
 drivers/staging/rtl8192e/rtllib_rx.c          |   20 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     |    5 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |    5 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |   22 +-
 drivers/staging/rtl8192e/rtllib_wx.c          |   19 +-
 drivers/staging/rtl8192u/Kconfig              |    1 +
 .../staging/rtl8192u/ieee80211/ieee80211.h    |    6 +-
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |    7 +-
 .../rtl8192u/ieee80211/ieee80211_crypt.h      |    6 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |    6 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |    6 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |    6 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |    6 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |    3 +-
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c |    3 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |   17 +-
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   17 +-
 drivers/staging/rtl8192u/r8180_93cx6.c        |    2 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c      |    2 +-
 drivers/staging/rtl8192u/r8192U_core.c        |   16 +-
 drivers/staging/rtl8192u/r8192U_hw.h          |    2 +-
 drivers/staging/rtl8192u/r8192U_wx.c          |    2 +-
 drivers/staging/rtl8192u/r8192U_wx.h          |    2 +-
 drivers/staging/rtl8712/Kconfig               |    1 +
 drivers/staging/rtl8723bs/Kconfig             |    1 +
 drivers/staging/rtlwifi/Kconfig               |    1 +
 drivers/staging/rtlwifi/Makefile              |    1 +
 drivers/staging/rtlwifi/btcoexist/Makefile    |    1 +
 drivers/staging/rtlwifi/rtl8822be/Makefile    |    1 +
 drivers/staging/rts5208/Kconfig               |    1 +
 drivers/staging/rts5208/Makefile              |    1 +
 drivers/staging/sm750fb/Kconfig               |    1 +
 drivers/staging/sm750fb/Makefile              |    1 +
 drivers/staging/sm750fb/ddk750.h              |    1 +
 drivers/staging/sm750fb/ddk750_swi2c.c        |    1 +
 drivers/staging/sm750fb/ddk750_swi2c.h        |    1 +
 drivers/staging/sm750fb/sm750.c               |    1 +
 drivers/staging/speakup/Kconfig               |    1 +
 drivers/staging/unisys/Kconfig                |    1 +
 drivers/staging/unisys/Makefile               |    1 +
 drivers/staging/unisys/visorhba/Kconfig       |    1 +
 drivers/staging/unisys/visorhba/Makefile      |    1 +
 drivers/staging/unisys/visorinput/Kconfig     |    1 +
 drivers/staging/unisys/visorinput/Makefile    |    1 +
 drivers/staging/unisys/visornic/Kconfig       |    1 +
 drivers/staging/unisys/visornic/Makefile      |    1 +
 drivers/staging/vboxvideo/Kconfig             |    1 +
 drivers/staging/vc04_services/Kconfig         |    1 +
 .../vc04_services/bcm2835-audio/Kconfig       |    1 +
 .../vc04_services/bcm2835-audio/Makefile      |    1 +
 .../vc04_services/bcm2835-camera/Kconfig      |    1 +
 .../vc04_services/interface/vchi/vchi.h       |   34 +-
 .../vc04_services/interface/vchi/vchi_cfg.h   |   34 +-
 .../interface/vchi/vchi_common.h              |   34 +-
 .../vc04_services/interface/vchiq_arm/vchiq.h |   34 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c      |   34 +-
 .../interface/vchiq_arm/vchiq_arm.c           |   32 +-
 .../interface/vchiq_arm/vchiq_arm.h           |   32 +-
 .../interface/vchiq_arm/vchiq_cfg.h           |   34 +-
 .../interface/vchiq_arm/vchiq_connected.c     |   34 +-
 .../interface/vchiq_arm/vchiq_connected.h     |   34 +-
 .../interface/vchiq_arm/vchiq_core.c          |   34 +-
 .../interface/vchiq_arm/vchiq_core.h          |   34 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       |   32 +-
 .../interface/vchiq_arm/vchiq_debugfs.h       |   34 +-
 .../interface/vchiq_arm/vchiq_if.h            |   34 +-
 .../interface/vchiq_arm/vchiq_ioctl.h         |   34 +-
 .../interface/vchiq_arm/vchiq_pagelist.h      |   34 +-
 .../interface/vchiq_arm/vchiq_shim.c          |   34 +-
 .../interface/vchiq_arm/vchiq_util.c          |   34 +-
 .../interface/vchiq_arm/vchiq_util.h          |   34 +-
 drivers/staging/vme/Makefile                  |    1 +
 drivers/staging/vme/devices/Kconfig           |    1 +
 drivers/staging/vme/devices/Makefile          |    1 +
 drivers/staging/vt6655/Kconfig                |    1 +
 drivers/staging/vt6656/Kconfig                |    1 +
 drivers/staging/wilc1000/Kconfig              |    1 +
 drivers/staging/wlan-ng/Kconfig               |    1 +
 303 files changed, 444 insertions(+), 4976 deletions(-)
 delete mode 100644 drivers/staging/mt7621-mmc/Kconfig
 delete mode 100644 drivers/staging/mt7621-mmc/Makefile
 delete mode 100644 drivers/staging/mt7621-mmc/TODO
 delete mode 100644 drivers/staging/mt7621-mmc/board.h
 delete mode 100644 drivers/staging/mt7621-mmc/dbg.c
 delete mode 100644 drivers/staging/mt7621-mmc/dbg.h
 delete mode 100644 drivers/staging/mt7621-mmc/mt6575_sd.h
 delete mode 100644 drivers/staging/mt7621-mmc/sd.c
 delete mode 100644 drivers/staging/rtl8192e/license

-- 
2.21.0

