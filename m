Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574AFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E5B22444
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfKST5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:57:20 -0500
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:37360 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbfKST5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:57:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 41B74182CF668;
        Tue, 19 Nov 2019 19:57:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coat09_3f7cbed42d161
X-Filterd-Recvd-Size: 7563
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 Nov 2019 19:57:16 +0000 (UTC)
Message-ID: <cb41a8956be6cf11e9d25c1790eeb8c935b9ab29.camel@perches.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Switch to Marvell addresses
From:   Joe Perches <joe@perches.com>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm soc <arm@kernel.org>,
        Jan Glauber <jglauber@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "soc@kernel.org" <soc@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Nov 2019 11:56:53 -0800
In-Reply-To: <20191119185012.2fekd6f5gbpflpqe@rric.localdomain>
References: <20191119165549.14570-1-rrichter@marvell.com>
         <20191119165549.14570-4-rrichter@marvell.com>
         <64ace55545c028bc39b08370074aafd32e8fc5f5.camel@perches.com>
         <20191119185012.2fekd6f5gbpflpqe@rric.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 18:50 +0000, Robert Richter wrote:
> On 19.11.19 09:14:36, Joe Perches wrote:
> > On Tue, 2019-11-19 at 16:56 +0000, Robert Richter wrote:
> > >  W:	http://www.cavium.com
> > 
> > Might want to change these W: links too
> 
> Yeah, good catch, was searching only for @cavium, which did not work
> quite well here. Fixed that.

Maybe make that change globally in all the files other
than MAINTAINERS as well eventually.

arch/arm64/mm/numa.c:6: * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
arch/mips/cavium-octeon/octeon-usb.c:551:MODULE_AUTHOR("David Daney <david.daney@cavium.com>");
arch/mips/include/asm/octeon/cvmx-coremask.h:6: * Copyright (c) 2016  Cavium Inc. (support@cavium.com).
arch/mips/include/asm/octeon/cvmx-lmcx-defs.h:4: * Contact: support@cavium.com
arch/mips/include/asm/octeon/cvmx-rst-defs.h:4: * Contact: support@cavium.com
drivers/ata/ahci_octeon.c:99:MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
drivers/crypto/cavium/cpt/cptpf_main.c:668:MODULE_AUTHOR("George Cherian <george.cherian@cavium.com>");
drivers/crypto/cavium/cpt/cptvf_main.c:860:MODULE_AUTHOR("George Cherian <george.cherian@cavium.com>");
drivers/crypto/cavium/nitrox/nitrox_main.c:593:MODULE_AUTHOR("Srikanth Jampala <Jampala.Srikanth@cavium.com>");
drivers/i2c/busses/i2c-thunderx-pcidrv.c:6: *	    Jan Glauber <jglauber@cavium.com>
drivers/mmc/host/cavium-octeon.c:336:MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
drivers/mmc/host/cavium.c:11: *   David Daney <david.daney@cavium.com>
drivers/mmc/host/cavium.c:12: *   Peter Swain <pswain@cavium.com>
drivers/mmc/host/cavium.c:13: *   Steven J. Hill <steven.hill@cavium.com>
drivers/mmc/host/cavium.c:14: *   Jan Glauber <jglauber@cavium.com>
drivers/net/ethernet/cavium/common/cavium_ptp.c:338:MODULE_AUTHOR("Cavium Networks <support@cavium.com>");
drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn23xx_pf_regs.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn23xx_vf_regs.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn66xx_device.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn66xx_device.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn66xx_regs.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn68xx_device.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn68xx_device.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/cn68xx_regs.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_core.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_main.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_main.c:39:MODULE_AUTHOR("Cavium Networks, <support@cavium.com>");
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_vf_main.c:32:MODULE_AUTHOR("Cavium Networks, <support@cavium.com>");
drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/lio_vf_rep.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/liquidio_common.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/liquidio_image.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_config.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_console.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_device.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_device.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_droq.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_droq.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_iq.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_mailbox.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_main.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_network.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_nic.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/octeon_nic.h:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/request_manager.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/response_manager.c:4: * Contact: support@cavium.com
drivers/net/ethernet/cavium/liquidio/response_manager.h:4: * Contact: support@cavium.com
drivers/perf/thunderx2_pmu.c:5: * Author: Ganapatrao Kulkarni <gkulkarni@cavium.com>
drivers/perf/thunderx2_pmu.c:1054:MODULE_AUTHOR("Ganapatrao Kulkarni <gkulkarni@cavium.com>");
drivers/spi/spi-cavium-thunderx.c:6: * Authors: Jan Glauber <jglauber@cavium.com>
drivers/staging/octeon-usb/octeon-hcd.c:11: * Copyright (c) 2003-2010 Cavium Networks (support@cavium.com). All rights
drivers/staging/octeon-usb/octeon-hcd.c:3736:MODULE_AUTHOR("Cavium, Inc. <support@cavium.com>");
drivers/staging/octeon-usb/octeon-hcd.h:11: * Copyright (c) 2003-2010 Cavium Networks (support@cavium.com). All rights
drivers/usb/storage/unusual_devs.h:2140:/* Reported-by George Cherian <george.cherian@cavium.com> */
drivers/watchdog/octeon-wdt-main.c:607:MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");




