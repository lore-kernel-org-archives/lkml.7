Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86877C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8BE206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nL3/dHiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfHOMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:12:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56192 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHOMMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:12:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7FCCJWA089522;
        Thu, 15 Aug 2019 07:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565871139;
        bh=4gpKC7yemuUvaitWirj0vyOMRvFCwHnsQPxxXWDVljs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nL3/dHiw3s9VQUI5J5LNYNiClw9EHuv5HLwNezULHtWpqzreeShkoE2i9GSq2xUTb
         dlIifJLA9TkjOgXrUWbz76RSN04NsMG99Z0uvnroJlLQmPRkPGflWNLiLZC90C5WJ1
         2mRNrYc+RfP5sydPmj8kw6vzCORxZi3pPjjj46bs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7FCCJvu108273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Aug 2019 07:12:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 15
 Aug 2019 07:12:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 15 Aug 2019 07:12:12 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7FCC9Fk031062;
        Thu, 15 Aug 2019 07:12:09 -0500
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
To:     Pawel Laszczak <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <9f54d3d5-da99-327b-631e-fad1329dcde4@ti.com>
Date:   Thu, 15 Aug 2019 15:12:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563733939-21214-1-git-send-email-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe & Alan,

On 21/07/2019 21:32, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> 
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
> 
> The current driver has been validated with FPGA burned. We have support
> for PCIe bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance with XHCI
> specification, so it works with standard XHCI Linux driver.

While testing this driver I encountered the following issue if I do the following.

1) USB port is "otg" and nothing connected so it is in IDLE mode to begin with.
   i.e. HCD & UDC not registered.

2) Load mass storage gadget with backing medium.
   > modprobe g_mass_storage file=lun stall=0

[   28.172142] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers

3) Connect port to PC host

[   30.564767] cdns-usb3 6000000.usb: Initialized  ep0 support:  
[   30.570591] cdns-usb3 6000000.usb: Initialized  ep1out support: BULK, INT ISO
[   30.577713] cdns-usb3 6000000.usb: Initialized  ep2out support: BULK, INT ISO
[   30.584835] cdns-usb3 6000000.usb: Initialized  ep3out support: BULK, INT ISO
[   30.591957] cdns-usb3 6000000.usb: Initialized  ep4out support: BULK, INT ISO
[   30.599078] cdns-usb3 6000000.usb: Initialized  ep5out support: BULK, INT ISO
[   30.606199] cdns-usb3 6000000.usb: Initialized  ep6out support: BULK, INT ISO
[   30.613320] cdns-usb3 6000000.usb: Initialized  ep7out support: BULK, INT ISO
[   30.620441] cdns-usb3 6000000.usb: Initialized  ep8out support: BULK, INT ISO
[   30.627562] cdns-usb3 6000000.usb: Initialized  ep9out support: BULK, INT ISO
[   30.634684] cdns-usb3 6000000.usb: Initialized  ep10out support: BULK, INT ISO
[   30.641893] cdns-usb3 6000000.usb: Initialized  ep11out support: BULK, INT ISO
[   30.649100] cdns-usb3 6000000.usb: Initialized  ep12out support: BULK, INT ISO
[   30.656309] cdns-usb3 6000000.usb: Initialized  ep13out support: BULK, INT ISO
[   30.663516] cdns-usb3 6000000.usb: Initialized  ep14out support: BULK, INT ISO
[   30.670724] cdns-usb3 6000000.usb: Initialized  ep15out support: BULK, INT ISO
[   30.677935] cdns-usb3 6000000.usb: Initialized  ep1in support: BULK, INT ISO
[   30.684979] cdns-usb3 6000000.usb: Initialized  ep2in support: BULK, INT ISO
[   30.692020] cdns-usb3 6000000.usb: Initialized  ep3in support: BULK, INT ISO
[   30.699057] cdns-usb3 6000000.usb: Initialized  ep4in support: BULK, INT ISO
[   30.706097] cdns-usb3 6000000.usb: Initialized  ep5in support: BULK, INT ISO
[   30.713135] cdns-usb3 6000000.usb: Initialized  ep6in support: BULK, INT ISO
[   30.720175] cdns-usb3 6000000.usb: Initialized  ep7in support: BULK, INT ISO
[   30.727213] cdns-usb3 6000000.usb: Initialized  ep8in support: BULK, INT ISO
[   30.734252] cdns-usb3 6000000.usb: Initialized  ep9in support: BULK, INT ISO
[   30.741289] cdns-usb3 6000000.usb: Initialized  ep10in support: BULK, INT ISO
[   30.748414] cdns-usb3 6000000.usb: Initialized  ep11in support: BULK, INT ISO
[   30.755536] cdns-usb3 6000000.usb: Initialized  ep12in support: BULK, INT ISO
[   30.762661] cdns-usb3 6000000.usb: Initialized  ep13in support: BULK, INT ISO
[   30.769785] cdns-usb3 6000000.usb: Initialized  ep14in support: BULK, INT ISO
[   30.776910] cdns-usb3 6000000.usb: Initialized  ep15in support: BULK, INT ISO
[   30.786313] Mass Storage Function, version: 2009/09/11
[   30.791455] LUN: removable file: (no medium)
[   31.039497] lun0: unable to open backing file: 500M.bin
[   31.158689] g_mass_storage 6000000.usb: failed to start g_mass_storage: -2
[   31.165606] cdns-usb3 6000000.usb: Failed to register USB device controller
[   31.172585] cdns-usb3 6000000.usb: set 2 has failed, back to 0

Now, -2 is ENOENT i.e.	/* No such file or directory */
The file is present so that's not the real issue.

The call trace to fsg_lun_open is below

[   30.952877]  fsg_lun_open+0x24/0x42c [usb_f_mass_storage]
[   30.958259]  fsg_common_create_lun+0xc8/0x2b8 [usb_f_mass_storage]
[   30.964422]  fsg_common_create_luns+0xa4/0x104 [usb_f_mass_storage]
[   30.970670]  msg_bind+0xd8/0x1e0 [g_mass_storage]
[   30.975360]  composite_bind+0x7c/0x180 [libcomposite]
[   30.980396]  udc_bind_to_driver+0x68/0x110 [udc_core]
[   30.985432]  check_pending_gadget_drivers+0x74/0xd8 [udc_core]
[   30.991247]  usb_add_gadget_udc_release+0x180/0x1e8 [udc_core]
[   30.997062]  usb_add_gadget_udc+0x10/0x18 [udc_core]
[   31.002010]  __cdns3_gadget_init+0x3a0/0x628 [cdns3]
[   31.006959]  cdns3_role_start+0x6c/0xd0 [cdns3]
[   31.011473]  cdns3_hw_role_switch+0x80/0xe8 [cdns3]
[   31.016336]  cdns3_drd_thread_irq+0x10/0x20 [cdns3]
[   31.021197]  irq_thread_fn+0x28/0x78
[   31.024757]  irq_thread+0x124/0x1b8
[   31.028233]  kthread+0x124/0x128
[   31.031447]  ret_from_fork+0x10/0x18

Is opening the backing file from irq_thread_fn the issue here?
If yes, how to resolve this?

cheers,
-roger

> 
> Change since v9:
> - Removed duplicated cdns3_mode array. The same array is defined in 
>   drivers/usb/common/common.c. It required some change in common API.
>   the appropirate patch was posted separately.
> - Replaced generic cdns3_dbg with serparate trace events.
> - Replaced cdns3_handshake with readl_poll_timeout_atomic function
> - Added threaded irq handler for handling DRD/OTG irq instead workqueue.
> - Removed support for debug_disable. It's no longer neeeded. 
> - Moved mode attribute under usb root.
> - Changed DRD switching role implementation. This version of the driver uses
>   common roles interface.
> - removed not implemented cdns3_idle_role_start and cdns3_exit_role_start.
> - Added support for DRD/OTG irq for Cadence platform.
> - Fixed bug in cdns3_mode_show/cdns3_mode_write with changing mode. There was a problem with switching mode. 
> - Added support for PM suspend/resume.
> - Simplified cdns3/Makefile file.
> 
> Change since v8:
> - Fixed compilation error by moving drivers/usb/gadget/debug.c back to
>   drivers/usb/common/debug.c. The previous version caused compilation
>   error when dwc3 or cdns3 driver was built-in kernel and libcomposite
>   was built as module.
>  
> Change since v7:
> - Updated dt-binding.
> - Simplified debugfs file as suggested by Heikki Krogerus.
> - Changed some dev_info to dev_dbg.
> - Added support for additional PHY. Now driver can use both USB2 PHY
>   and USB3 PHY.
> - Fixed issue in algorithm checking the number of allocated on-chip buffers.
> - Moved common code form drivers/usb/common/debug.c to
>   drivers/usb/gadget/debug.c.
> - Removed warning generated by sh4-linux-gcc compiler for trace.h file.
> - L1 issue: moved resuming after setting DRDY. It should protect against 
>   potential racing.
> - LPM packet acknowledge has been disabled during control transfer.
> - Aded setting AXI Non-Secure mode in DMA_AXI_CTRL register. 
> 
> Change since v6:
> - Fixed issue with L1 support. Controller has issue with hardware 
>   resuming from L1 state. It was fixed in software. 
> - Fixed issues related with Transfer Ring Size equal 2. 
> - Fixed issue with removing cdns3.ko module. Issue appeared on the latest 
>   version of kernel.
> - Added separate interrupt resources for host, device and otg. It was 
>   added mainly for compatibility with TI J721e platforms. 
> - Added enabling ISO OUT just before arming endpoint. It's recommended by 
>   controller specification.
> - Added support for 0x0002450d controller version. This version allows to set 
>   DMULT mode per endpoint. It also fixes WA1 issue.
> - Added support for separate interrupt line for Device and OTG/DRD.
> - Removed drd_update_mode from drd_init, 'desired_dr_mode' is not yet correctly
>   set based on enabled drivers and dr_mode in DT.
> - Added phy power on/off.
> - Added setting dma and coherent mask to 32-bits, because controller can do
>   only 32-bit access.
> - Added Idle state for Type-C for platform TI J721e as suggested by Roger. 
> - Improved the flow according with Figure 24 from Software OTG Control user
>   guide as sugested by Roger.
> 
> Change since v5:
> - Fixed controller issue with handling SETUP that has occurred on 0x0002450C
>   controller version. In some case EP_STS_SETUP is reported but SETUP
>   packet has not been copied yet to system memory. This bug caused that
>   driver started handling the previous SETUP packet.
> - Added handling ZLP for EP0.
> - Removed unused cdns3_gadget_ep0_giveback function.
> - Fixed issue with disabling endpoint. Added waiting for clearing EP_STS_DBUSY
>   bit between disabling endpoint and calling EP_CMD_EPRST command.
>   EP_CMD_EPRST command can be called only when DMA is stopped.
> - Fixed issue: EP_CFG_TDL_CHK is currently supported only for OUT direction,
>   It was enabled for both IN/OUT direction.
> - Improved resetting of interrupt in cdns3_device_irq_handler.
> - Fixed issue with ISOC IN transfer in cdns3_ep_run_transfer function. In some
>   cases driver set incorrect Cycle Bit in TRBs.
> - Fixed issue in function cdns3_ep_onchip_buffer_reserve. Driver assigned 
>   incorrect value to priv_dev->out_mem_is_allocated field.
> 
> Change since v5:
> - fixed compilation error.
> 
> Changes since v4:
> - fixed issue: with choosing incorrect dr_mode in cdns3_core_init_role.
> - speed up DRD timings by adding an appropriate entry to OTGSIMULATE
>   register in cdns3_drd_init function.
> - added detecting transition to DEV_IDLE/H_IDLE state instead using
>   usleep_range in cdns3_drd_switch_gadget and cdns3_drd_switch_host functions.
> - fixed issue with setting incorrect burst and mult field during endpoint
>   configuration. 
> - fixed issue in WA1 algorithm. The previous one could not work correct with
>   slow CPU or in case the access to AXI bus would be blocked for some time.
> - fixed issue with compilation driver occurred when driver was configured
>   as build in. This fix required to move cdns3_handshake function from
>   gadget.c to core.c file.
> - added missing pci_disable_device in cdns3-pci-wrap.c file.
> - fixed issue with pm_runtime_get_sync in cdns3_role_switch function.
> - fixed incorrect condition in cdns3_decode_usb_irq function.
> - removed cdns3_data_flush function - is no longer used.
> - fixed issue in cdns3_descmissing_packet function - fixed incorrect condition
> - added missed callback informing upper layer about reset event.
> - added resetting endpoint in cdns3_gadget_ep_disable function.
> - fixed issue: added statement removing request from descmiss_req_list in
>   cdns3_gadget_ep_disable function.
> - fixed issue in cdns3_ep_onchip_buffer_reserve.
> - fixed issue with incorrect calculation the number of required on-chip buffer 
>   for OUT endpoints cdns3_ep_onchip_buffer_reserve.
> - fixed issue in __cdns3_gadget_init function: pm_runtime_get_sync was in
>   incorrect place in.
> - removed some typos and improved comments as suggested by reviewers.
> - made some other minor changes as suggested by revivers.
> 
> Changes since v3:
> - updated dt-binding as suggested by Rob Herring
> - updated patch 002, 003 and 004 according with patch:
>   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/
>   ?h=next&id=7790b3556fccc555ae422f1576e97bf34c8ab8b6 posted by Felipe Balbi.
> - fixed issues related to isochronous transfers.
> - improved algorithm calculating number of on-chip buffers required
>   by endpoints.
> - fixed incorrect macro EP_CFG_MULT in gadget.h file.
> - fixed potential issue with incorrect order of instruction - added wmb().
> - made some minor changes suggested by reviewers.
> 
> *Changes since v2:
> - made some text correction in Kconfig file as suggested by Randy Dunlap.
> - simplified Makefile as suggested by Peter Chan.
> - removed phy-names from dt-binding as suggested Rob Herring.
> - changed cdns3-usb.txt to cdns3-usb3.txt as suggested by Rob Herring.
> - added checking error code in some function in drd.c file 
>   as suggested by Peter Chan.
> - added reg-names to dt-binding documentation as suggested by Chunfeng Yun.
> - replaced platform_get_resource with platform_get_resource_byname.
> - made other changes suggested by Chunfeng Yun.
> - fixed bug in cdns3_get_id. Now function return id instead 1.
> - added trace_cdns3_log trace event.
> - simplify cdns3_disable_write function.
> - create separate patch for work around related with blocking endpoint 
>   issue.
> - Fixed issue related with stale data address in TRB. 
>   Issue: At some situations, the controller may get stale data address
>   in TRB at below sequences:
>   1. Controller read TRB includes data address.
>   2. Software updates TRBs includes data address and Cycle bit.
>   3. Controller read TRB which includes Cycle bit.
>   4. DMA run with stale data address.
> - Fixed issue without transfer. In some cases not all interrupts
>   disabled in Hard IRQ was enabled in Soft Irq.
> - Modified LFPS minimal U1 Exit time for controller revision 0x00024505.
> - Fixed issue - in some case selected endpoint was unexpectedly changed.
> - Fixed issue - after clearing halted endpoint transfer was not started.
> - Fixed issue - in some case driver send ACK instead STALL in status phase.
> - Fixed issues related to dequeue request.
> - Fixed incorrect operator in cdns3_ep_run_transfer function.
> 
> Changes since v1:
>  - Removed not implemented Suspend/Resume functions.
>  - Fixed some issues in debugging related functions.
>  - Added trace_cdns3_request_handled marker.
>  - Added support for Isochronous transfer. 
>  - Added some additional descriptions.
>  - Fixed compilation error in cdns3_gadget_ep_disable.
>  - Added detection of device controller version at runtime.
>  - Upgraded dt-binding documentation.
>  - Deleted ENOSYS from phy initialization section. It should be also removed
>    from generic PHY driver.
>  - added ep0_stage flag used during enumeration process.
>  - Fixed issue with TEST MODE.
>  - Added one common function for finish control transfer.
>  - Separated some decoding function from dwc3 driver to common library file,
>    and removed equivalents function from debug.h file as suggested  by Felipe.
>  - replaced function name cdns3_gadget_unconfig with cdns3_hw_reset_eps_config.
>  - Improved algorithm fixing hardware issue related to blocking endpoints.
>    This issue is related to on-chip shared FIFO buffers for OUT packets. 
>    Problem was reported by Peter Chan.
>  - Changed organization of endpoint array in cdns3_device object.  
>       - added ep0 to common eps array
>       - removed cdns3_free_trb_pool and cdns3_ep_addr_to_bit_pos macros.
>       - removed ep0_trb_dma, ep0_trb fields from cdns3_device.
>  - Removed ep0_request and ep_nums fields from cdns3_device.
>  - Other minor changes according with Felipe suggestion.
> 
> ---
> 
> Pawel Laszczak (6):
>   dt-bindings: add binding for USBSS-DRD controller.
>   usb:common Separated decoding functions from dwc3 driver.
>   usb:common Patch simplify usb_decode_set_clear_feature function.
>   usb:common Simplify usb_decode_get_set_descriptor function.
>   usb:cdns3 Add Cadence USB3 DRD Driver
>   usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
> 
>  .../devicetree/bindings/usb/cdns-usb3.txt     |   45 +
>  drivers/usb/Kconfig                           |    2 +
>  drivers/usb/Makefile                          |    2 +
>  drivers/usb/cdns3/Kconfig                     |   46 +
>  drivers/usb/cdns3/Makefile                    |   17 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c            |  203 ++
>  drivers/usb/cdns3/core.c                      |  554 ++++
>  drivers/usb/cdns3/core.h                      |  109 +
>  drivers/usb/cdns3/debug.h                     |  171 ++
>  drivers/usb/cdns3/debugfs.c                   |   87 +
>  drivers/usb/cdns3/drd.c                       |  390 +++
>  drivers/usb/cdns3/drd.h                       |  166 +
>  drivers/usb/cdns3/ep0.c                       |  914 ++++++
>  drivers/usb/cdns3/gadget-export.h             |   28 +
>  drivers/usb/cdns3/gadget.c                    | 2672 +++++++++++++++++
>  drivers/usb/cdns3/gadget.h                    | 1334 ++++++++
>  drivers/usb/cdns3/host-export.h               |   28 +
>  drivers/usb/cdns3/host.c                      |   71 +
>  drivers/usb/cdns3/trace.c                     |   11 +
>  drivers/usb/cdns3/trace.h                     |  493 +++
>  drivers/usb/common/Makefile                   |    1 +
>  drivers/usb/common/debug.c                    |  268 ++
>  drivers/usb/dwc3/debug.h                      |  252 --
>  drivers/usb/dwc3/trace.h                      |    2 +-
>  include/linux/usb/ch9.h                       |   27 +
>  25 files changed, 7640 insertions(+), 253 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h
>  create mode 100644 drivers/usb/common/debug.c
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
