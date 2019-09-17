Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE35C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560DA21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIQSPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:15:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42397 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfIQSPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:15:02 -0400
Received: by mail-io1-f71.google.com with SMTP id x9so6971171ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TdUY63cYPwUAhiSERKmtQgs4emkR4SLu25teSuvZpbs=;
        b=hRITXsJoCWGBHulzqixOM95/DX+6Y7AqA303irP5d302VI9PdlBK5eWdMNFpRH6Vfd
         VGR5SbWN8xhPDAiGMtSaXSh9/IsxOkhDa3CKQphqYpeXrz1Pvahb3FyCatHThpLsCWQw
         ycHpIfPw+pyJgPquO1LNjfMtP6JVacmaeqzHzMtk4gWKqA1IZJkQvZOVihlkWIwags+j
         My5JXxkoqtt4bTNpeVRRgqe7uGU23gXzkrW8fXtvfbIBrbvoJMan/XT9KHtGirqfkEPc
         Ohj9L1PJdtLo47JbHHrTtQLHu8pdz9xAGprbpmyMxdwEXg92rTC7PjR6/4o2QSfPPpR+
         m7sg==
X-Gm-Message-State: APjAAAVwu9UA0q1+tJAPofy2MwDJlMJ89X3EhtU5L3uqkZPRgrNFgAe+
        aSmpIUzL43FgebFxIyi2OLDr4mWEJKeCEfmHKGF1IDA/Sohy
X-Google-Smtp-Source: APXvYqzXxjiPXHnQKlM8/1HF/TBPAyTRl1ODWdYHoAAzlh0oP1tnA8+3BzBvwoeio3udP7pwTcAzsc/Hw4H0lu78QqTaKoMuFC+A
MIME-Version: 1.0
X-Received: by 2002:a6b:8b50:: with SMTP id n77mr28646iod.195.1568744100888;
 Tue, 17 Sep 2019 11:15:00 -0700 (PDT)
Date:   Tue, 17 Sep 2019 11:15:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909171405350.1590-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e08e490592c3b2c4@google.com>
Subject: Re: general protection fault in usb_set_interface
From:   syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mans@mansr.com, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

  drivers/usb/typec/altmodes/built-in.a
   CC      drivers/usb/misc/legousbtower.o
   AR      drivers/usb/musb/built-in.a
   CC      drivers/usb/host/sl811-hcd.o
   CC      drivers/usb/usbip/vhci_sysfs.o
   AR      drivers/usb/typec/mux/built-in.a
   CC      drivers/usb/serial/generic.o
   CC      drivers/usb/serial/bus.o
   CC      drivers/usb/usbip/vhci_tx.o
   CC      drivers/usb/serial/aircable.o
   CC      drivers/usb/typec/tcpm/tcpm.o
   CC      drivers/staging/rtl8712/usb_halinit.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.o
   AR      drivers/media/usb/zr364xx/built-in.a
   CC      drivers/staging/uwb/driver.o
   CC      drivers/staging/rtl8712/usb_ops.o
   CC      drivers/staging/rtl8712/usb_ops_linux.o
   CC      drivers/staging/rtl8712/rtl871x_io.o
   CC      drivers/staging/rtl8712/rtl8712_io.o
   CC      drivers/media/usb/uvc/uvc_debugfs.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.o
   CC      drivers/media/usb/uvc/uvc_metadata.o
   CC      drivers/usb/serial/ark3116.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.o
   CC      drivers/usb/serial/belkin_sa.o
   CC      drivers/media/usb/uvc/uvc_entity.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.o
   CC      drivers/gpu/drm/i915/i915_oa_sklgt4.o
   CC      drivers/gpu/drm/i915/i915_oa_bxt.o
   CC      drivers/usb/misc/rio500.o
   CC      drivers/usb/misc/usbtest.o
   CC      drivers/staging/wlan-ng/prism2usb.o
   CC      drivers/usb/misc/ehset.o
   CC      drivers/usb/serial/ch341.o
   CC      drivers/usb/storage/protocol.o
   CC      drivers/usb/typec/ucsi/trace.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8192cu/built-in.a
   CC      drivers/usb/usbip/vhci_rx.o
   CC      drivers/usb/usbip/vhci_hcd.o
   CC      drivers/usb/misc/trancevibrator.o
   CC      drivers/usb/typec/ucsi/ucsi.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.o
   CC      drivers/staging/uwb/drp.o
   CC      drivers/usb/host/sl811_cs.o
   CC      drivers/staging/uwb/drp-avail.o
   CC      drivers/usb/host/u132-hcd.o
   CC      drivers/staging/rtl8712/rtl871x_ioctl_linux.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/table.o
   AR      drivers/media/usb/uvc/built-in.a
scripts/Makefile.build:497: recipe for target 'drivers/media/usb' failed
make[2]: *** [drivers/media/usb] Error 2
scripts/Makefile.build:497: recipe for target 'drivers/media' failed
make[1]: *** [drivers/media] Error 2
make[1]: *** Waiting for unfinished jobs....
   CC      drivers/usb/misc/uss720.o
   CC      drivers/usb/storage/transport.o
   CC      drivers/usb/misc/usbsevseg.o
   CC      drivers/usb/usbip/stub_dev.o
   CC      drivers/usb/misc/usb251xb.o
   CC      drivers/staging/uwb/drp-ie.o
   CC      drivers/usb/serial/cp210x.o
   CC      drivers/usb/serial/cyberjack.o
   CC      drivers/usb/serial/cypress_m8.o
   CC      drivers/gpu/drm/i915/i915_oa_kblgt2.o
   CC      drivers/usb/host/bcma-hcd.o
   CC      drivers/usb/host/r8a66597-hcd.o
   CC      drivers/usb/misc/yurex.o
   CC      drivers/usb/misc/usb3503.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.o
   CC      drivers/staging/wlan-ng/p80211conv.o
   CC      drivers/usb/host/ssb-hcd.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.o
   CC      drivers/staging/uwb/est.o
   CC      drivers/usb/misc/usb4604.o
   CC      drivers/usb/misc/chaoskey.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.o
   CC      drivers/staging/rtl8712/rtl871x_ioctl_rtl.o
   CC      drivers/usb/usbip/stub_main.o
   CC      drivers/usb/misc/lvstest.o
   CC      drivers/usb/storage/usb.o
   CC      drivers/usb/storage/initializers.o
   CC      drivers/usb/storage/sierra_ms.o
   CC      drivers/gpu/drm/drm_vblank.o
   CC      drivers/gpu/drm/drm_syncobj.o
   CC      drivers/usb/typec/ucsi/ucsi_acpi.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.o
   CC      drivers/usb/host/fotg210-hcd.o
   CC      drivers/staging/uwb/ie.o
   CC      drivers/gpu/drm/i915/i915_oa_kblgt3.o
   CC      drivers/staging/wlan-ng/p80211req.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/pwrseq.o
   CC      drivers/staging/wlan-ng/p80211wep.o
   CC      drivers/staging/wlan-ng/p80211netdev.o
   CC      drivers/usb/serial/usb_debug.o
   CC      drivers/staging/rtl8712/rtl871x_ioctl_set.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.o
   CC      drivers/usb/usbip/stub_rx.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.o
   CC      drivers/usb/usbip/stub_tx.o
   CC      drivers/staging/uwb/ie-rcv.o
   CC      drivers/usb/typec/class.o
   CC      drivers/usb/serial/digi_acceleport.o
   AR      drivers/usb/typec/ucsi/built-in.a
   AR      drivers/usb/misc/built-in.a
   CC      drivers/gpu/drm/i915/i915_oa_glk.o
   CC      drivers/staging/uwb/lc-dev.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.o
   CC      drivers/usb/usbip/vudc_dev.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8192ce/built-in.a
   CC      drivers/usb/typec/tcpm/fusb302.o
   CC      drivers/usb/storage/option_ms.o
   CC      drivers/usb/storage/usual-tables.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.o
   CC      drivers/staging/rtl8712/rtl8712_led.o
   CC      drivers/usb/typec/mux.o
   CC      drivers/usb/typec/bus.o
   CC      drivers/usb/typec/tcpm/tcpci.o
   CC      drivers/gpu/drm/i915/i915_oa_cflgt2.o
   CC      drivers/gpu/drm/i915/i915_oa_cflgt3.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.o
   CC      drivers/staging/uwb/lc-rc.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.o
   CC      drivers/usb/host/max3421-hcd.o
   CC      drivers/usb/usbip/vudc_sysfs.o
   CC      drivers/usb/serial/io_edgeport.o
   CC      drivers/usb/serial/io_ti.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.o
   CC      drivers/usb/typec/tps6598x.o
   CC      drivers/usb/storage/alauda.o
   CC      drivers/usb/storage/cypress_atacb.o
   CC      drivers/usb/storage/datafab.o
   CC      drivers/gpu/drm/i915/i915_oa_cnl.o
   CC      drivers/usb/usbip/vudc_tx.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.o
   CC      drivers/staging/rtl8712/rtl871x_mlme.o
   CC      drivers/staging/rtl8712/ieee80211.o
   CC      drivers/staging/uwb/neh.o
   CC      drivers/usb/usbip/vudc_rx.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/table.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.o
   AR      drivers/usb/typec/tcpm/built-in.a
   CC      drivers/gpu/drm/drm_lease.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/table.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.o
   AR      drivers/usb/typec/built-in.a
   CC      drivers/staging/uwb/pal.o
   CC      drivers/staging/uwb/radio.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.o
   CC      drivers/staging/uwb/reset.o
   CC      drivers/usb/usbip/vudc_transfer.o
   CC      drivers/gpu/drm/drm_writeback.o
   CC      drivers/usb/usbip/vudc_main.o
   AR      drivers/staging/wlan-ng/built-in.a
   CC      drivers/gpu/drm/drm_client.o
   CC      drivers/usb/storage/ene_ub6250.o
   CC      drivers/staging/uwb/rsv.o
   CC      drivers/usb/serial/empeg.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/table.o
   CC      drivers/usb/serial/f81232.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.o
   CC      drivers/staging/uwb/scan.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.o
   CC      drivers/staging/rtl8712/rtl871x_mp_ioctl.o
   CC      drivers/staging/uwb/uwb-debug.o
   CC      drivers/usb/storage/freecom.o
   CC      drivers/gpu/drm/i915/i915_oa_icl.o
   CC      drivers/usb/serial/f81534.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.o
   CC      drivers/net/wireless/realtek/rtlwifi/base.o
   CC      drivers/net/wireless/realtek/rtlwifi/cam.o
   CC      drivers/gpu/drm/drm_client_modeset.o
   CC      drivers/gpu/drm/drm_hdcp.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8192ee/built-in.a
   CC      drivers/gpu/drm/drm_ioc32.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.o
   AR      drivers/usb/usbip/built-in.a
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723com/main.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.o
   CC      drivers/gpu/drm/drm_atomic_uapi.o
   CC      drivers/usb/serial/ftdi_sio.o
   CC      drivers/staging/rtl8712/rtl871x_mp.o
   CC      drivers/staging/wusbcore/host/whci/asl.o
   CC      drivers/gpu/drm/drm_panel.o
   CC      drivers/gpu/drm/drm_of.o
   AR      drivers/usb/host/built-in.a
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723com/dm_common.o
   CC      drivers/usb/serial/garmin_gps.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723com/fw_common.o
   CC      drivers/staging/uwb/uwbd.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.o
   CC      drivers/usb/storage/isd200.o
   CC      drivers/net/wireless/realtek/rtlwifi/core.o
   AR      drivers/gpu/drm/i915/built-in.a
   CC      drivers/usb/serial/ipaq.o
   CC      drivers/staging/rtl8712/mlme_linux.o
   CC      drivers/net/wireless/realtek/rtlwifi/debug.o
   CC      drivers/net/wireless/realtek/rtlwifi/efuse.o
   CC      drivers/staging/uwb/umc-bus.o
   CC      drivers/staging/uwb/umc-dev.o
   CC      drivers/staging/uwb/umc-drv.o
   CC      drivers/staging/wusbcore/host/whci/debug.o
   CC      drivers/staging/wusbcore/crypto.o
   CC      drivers/gpu/drm/drm_agpsupport.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8192se/built-in.a
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.o
   CC      drivers/staging/rtl8712/recv_linux.o
   CC      drivers/staging/wusbcore/devconnect.o
   CC      drivers/staging/wusbcore/dev-sysfs.o
   CC      drivers/staging/uwb/whci.o
   CC      drivers/staging/wusbcore/mmc.o
   CC      drivers/staging/wusbcore/pal.o
   CC      drivers/staging/wusbcore/host/whci/hcd.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/pwrseq.o
   CC      drivers/staging/rtl8712/xmit_linux.o
   CC      drivers/staging/rtl8712/usb_intf.o
   CC      drivers/gpu/drm/drm_debugfs.o
   CC      drivers/usb/storage/jumpshot.o
   CC      drivers/staging/uwb/whc-rc.o
   CC      drivers/gpu/drm/drm_debugfs_crc.o
   CC      drivers/usb/storage/karma.o
   CC      drivers/usb/serial/ipw.o
   CC      drivers/usb/storage/onetouch.o
   CC      drivers/usb/serial/ir-usb.o
   CC      drivers/gpu/drm/drm_mipi_dsi.o
   CC      drivers/net/wireless/realtek/rtlwifi/ps.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8192de/built-in.a
   CC      drivers/staging/wusbcore/host/hwa-hc.o
   CC      drivers/staging/uwb/hwa-rc.o
   CC      drivers/staging/wusbcore/rh.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8723com/built-in.a
   CC      drivers/staging/wusbcore/reservation.o
   CC      drivers/staging/rtl8712/os_intfs.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.o
   CC      drivers/staging/wusbcore/host/whci/hw.o
   CC      drivers/usb/storage/realtek_cr.o
   CC      drivers/staging/wusbcore/host/whci/init.o
   CC      drivers/staging/wusbcore/host/whci/int.o
   CC      drivers/staging/rtl8712/rtl871x_pwrctrl.o
   CC      drivers/usb/storage/sddr09.o
   CC      drivers/usb/serial/iuu_phoenix.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.o
   CC      drivers/staging/rtl8712/rtl8712_recv.o
   CC      drivers/usb/storage/sddr55.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.o
   CC      drivers/gpu/drm/drm_panel_orientation_quirks.o
   CC      drivers/usb/storage/shuttle_usbat.o
   CC      drivers/staging/wusbcore/security.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/pwrseq.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.o
   CC      drivers/staging/wusbcore/wusbhc.o
   CC      drivers/staging/rtl8712/rtl871x_recv.o
   CC      drivers/staging/rtl8712/rtl871x_sta_mgt.o
   CC      drivers/staging/rtl8712/rtl871x_xmit.o
   CC      drivers/staging/rtl8712/rtl8712_xmit.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/table.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.o
   CC      drivers/usb/serial/keyspan.o
   CC      drivers/usb/serial/keyspan_pda.o
   AR      drivers/staging/uwb/built-in.a
   AR      drivers/gpu/drm/built-in.a
   CC      drivers/staging/wusbcore/wa-hc.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/pwrseq.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.o
   CC      drivers/staging/wusbcore/host/whci/qset.o
   CC      drivers/staging/wusbcore/host/whci/pzl.o
   AR      drivers/gpu/built-in.a
   CC      drivers/staging/wusbcore/host/whci/wusb.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.o
   CC      drivers/net/wireless/realtek/rtlwifi/rc.o
   CC      drivers/net/wireless/realtek/rtlwifi/regd.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/table.o
   CC      drivers/net/wireless/realtek/rtlwifi/stats.o
   CC      drivers/net/wireless/realtek/rtlwifi/pci.o
   CC      drivers/staging/wusbcore/wa-rpipe.o
   CC      drivers/staging/wusbcore/wa-nep.o
   AR      drivers/usb/storage/built-in.a
   CC      drivers/net/wireless/realtek/rtlwifi/usb.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/table.o
   CC      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.o
   CC      drivers/staging/wusbcore/wa-xfer.o
   CC      drivers/staging/wusbcore/cbaf.o
   CC      drivers/usb/serial/kobil_sct.o
   CC      drivers/usb/serial/kl5kusb105.o
   CC      drivers/usb/serial/metro-usb.o
   CC      drivers/usb/serial/mct_u232.o
   CC      drivers/usb/serial/mos7720.o
   CC      drivers/usb/serial/mos7840.o
   CC      drivers/usb/serial/mxuport.o
   CC      drivers/usb/serial/navman.o
   CC      drivers/usb/serial/omninet.o
   CC      drivers/usb/serial/opticon.o
   CC      drivers/usb/serial/option.o
   CC      drivers/usb/serial/oti6858.o
   CC      drivers/usb/serial/pl2303.o
   CC      drivers/usb/serial/qcaux.o
   CC      drivers/usb/serial/qcserial.o
   CC      drivers/usb/serial/quatech2.o
   CC      drivers/usb/serial/safe_serial.o
   AR      drivers/staging/rtl8712/built-in.a
   CC      drivers/usb/serial/sierra.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8723be/built-in.a
   CC      drivers/usb/serial/usb-serial-simple.o
   CC      drivers/usb/serial/spcp8x5.o
   AR      drivers/staging/wusbcore/host/whci/built-in.a
   AR      drivers/staging/wusbcore/host/built-in.a
   CC      drivers/usb/serial/ssu100.o
   CC      drivers/usb/serial/symbolserial.o
   CC      drivers/usb/serial/usb_wwan.o
   CC      drivers/usb/serial/ti_usb_3410_5052.o
   CC      drivers/usb/serial/upd78f0730.o
   CC      drivers/usb/serial/visor.o
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8723ae/built-in.a
   CC      drivers/usb/serial/wishbone-serial.o
   CC      drivers/usb/serial/xsens_mt.o
   CC      drivers/usb/serial/whiteheat.o
   AR      drivers/staging/wusbcore/built-in.a
   AR      drivers/staging/built-in.a
   AR      drivers/usb/serial/built-in.a
   AR      drivers/usb/built-in.a
   AR      drivers/net/wireless/realtek/rtlwifi/rtl8821ae/built-in.a
   AR      drivers/net/wireless/realtek/rtlwifi/built-in.a
   AR      drivers/net/wireless/realtek/built-in.a
   AR      drivers/net/wireless/built-in.a
   AR      drivers/net/built-in.a
Makefile:1083: recipe for target 'drivers' failed
make: *** [drivers] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=176045b5600000


Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
dashboard link: https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f8611d600000

