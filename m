Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE2620673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="grVB1+Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFUPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:37:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rsF6ZDuxwaVcPadCwdMbqn4T2dTXRmToUIIz/tv2f+U=; b=grVB1+JeEgTga6AxlsRaJ8qem
        o3+nM0BAZf/MXHz1XWoig+y9Qt5Wy3kKFWkSCvctat+PNOL+PYPtit7thmNzOJE2fkag4Sc2H+RUF
        CthyKl8+VUhrx22/XUgbCfOvS2tm5+MtaOb1/IqdvjgoN5DSpo9FZC5HRBqQvMGEq2TQOjZN0OCnt
        iGouEZFcRgdRPPQP7gPeEfRusJyH5kiqlZ5Q62jElQqJPrSaxHuo25m2wGWZvElpfQK5xinaIvAEt
        28j1OotSgMotMxMU7WM2cjAxMMavHQz9U9xaV8Bni0AlOYZnMIWqDuKcSACpf9aQVod/gZYvPHAZO
        BDPUVtlpg==;
Received: from [177.97.20.138] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heLbt-0003Wn-5o; Fri, 21 Jun 2019 15:37:53 +0000
Date:   Fri, 21 Jun 2019 12:37:50 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 0/6] Produce ABI guide without escaping ReST source
 files
Message-ID: <20190621123750.764bbad2@coco.lan>
In-Reply-To: <20190621100441.183e7cd2@coco.lan>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
        <20190621093915.4a466f79@coco.lan>
        <20190621100441.183e7cd2@coco.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 21 Jun 2019 10:04:41 -0300
Mauro Carvalho Chehab <mchehab@infradead.org> escreveu:

> Em Fri, 21 Jun 2019 09:39:15 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> 
> > Em Fri, 21 Jun 2019 09:32:00 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> >   
> > > Hi Greg,
> > > 
> > > As you proposed to give it a try on removing the escape code from the
> > > script which parses the ReST file, I changed a few things there,
> > > adding the capability of selectively enabling to output an ABI sub-dir
> > > without escaping things that would crash Sphinx.
> > > 
> > > PS.: As for now this is just a RFC, I'm not getting the ABI file
> > > maintainers, copying just LKML, linux-doc ML, plus you and Jon.
> > > 
> > > I also manually fixed the contents of ABI/stable, in order for it to
> > > pass without causing troubles.
> > > 
> > > I added all patches from ABI and features at this branch:
> > > 
> > > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=abi_patches_v4.1
> > > 
> > > The html output is at https://www.infradead.org/~mchehab/rst_features/,
> > > and you can see the resulting ABI guide on:
> > > 
> > > 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> > > 
> > > No Sphinx crashes/warnings happen when building it.
> > > 
> > > That's my personal notes about such work:
> > > 
> > > 1) Documentation/ABI/stable/sysfs-class-infiniband
> > > 
> > > It had some title captions inside it, like:
> > > 
> > > 	Errors info:
> > >                 -----------
> > > 
> > > For one of the "What:"
> > > 
> > > Sphinx is really pick with title markups. As the entire Documentation/stable is
> > > parsed as if it were a single document, there should be a coherency on what
> > > character is used to markup a level-one title. I mean, if one document uses:
> > > 
> > > foo
> > > ----
> > > 
> > > For the first level, all other documents should use "---...-" as well.
> > > 
> > > The alternative would be to have one entry for every single file at
> > > Documentation/admin-guide/abi-*.rst, with, IMHO, it would be a lot
> > > harder to maintain.
> > > 
> > > So, the best seems to let clear at ABI/README about how titles/subtitles
> > > should be used inside files, if any.
> > > 
> > > 2) Some documents there use a "Values:" tag, with is not defined as a
> > > valid one at ABI/README. The script handles it as part of the description,
> > > so no harm done;
> > > 
> > > 3) Among the 47 files under ABI/stable, 14 of them names the file
> > > contents, using a valid ReST markup for the document title. That is shown
> > > at the index at:
> > > 
> > > 	https://www.infradead.org/~mchehab/rst_features/admin-guide/abi.html
> > > 
> > > 
> > > - ABI stable symbols
> > > 
> > >   -  sysfs interface for Mellanox ConnectX HCA IB driver (mlx4)
> > >   -  sysfs interface for Intel IB driver qib
> > >   -  sysfs interface for Intel(R) X722 iWARP i40iw driver
> > >   -  sysfs interface for QLogic qedr NIC Driver
> > >   -  sysfs interface for NetEffect RNIC Low-Level iWARP driver (nes)
> > >   -  sysfs interface for Cisco VIC (usNIC) Verbs Driver
> > >   -  sysfs interface for Chelsio T3 RDMA Driver (cxgb3)
> > >   -  sysfs interface for Chelsio T4/T5 RDMA driver (cxgb4)
> > >   -  sysfs interface for Intel Omni-Path driver (HFI1)
> > >   -  sysfs interface for VMware Paravirtual RDMA driver
> > >   -  sysfs interface for Mellanox Connect-IB HCA driver mlx5
> > >   -  sysfs interface for Emulex RoCE HCA Driver
> > >   -  sysfs interface for Broadcom NetXtreme-E RoCE driver
> > >   -  sysfs interface for Mellanox IB HCA low-level driver (mthca)
> > > 
> > > I liked that, but ideally all ABI files should either use it or not.
> > > 
> > > 4) I was expecting to have troubles with asterisk characters inside the
> > > ABI files. That was not the case: I had to escape just one occurrence on
> > > a single file of the 47 ones inside ABI/stable. 
> > > 
> > > -
> > > 
> > > My conclusion from this experiment is that it is worth cleaning the ABI
> > > files for them to be parsed without needing to escape non-ReST compliant
> > > parts of the ABI file.
> > > 
> > > Perhaps we could keep rst-compliant the stable, obsolete and removed
> > > directories only, and gradually moving stuff from ABI/testing to ABI/stable,
> > > while fixing them to be rst-compliant.    
> > 
> > Btw, adding :rst: to kernel-abi markup at abi-obsolete.rst and 
> > abi-removed.rst produced just two warnings:
> > 
> > get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1689: ERROR: Unexpected indentation.
> > get_abi.pl rest --dir $srctree/Documentation/ABI/obsolete --rst-source:1692: WARNING: Block quote ends without a blank line; unexpected unindent.
> > 
> > I'll fix those too at my repository.
> > 
> > I suspect, however, that Documentation/ABI/testing with its 353 files will
> > require a lot more care.  
> 
> Disabling the escaping logic for ABI/testing won't cause crashes with Sphinx
> 1.4.9 (it will probably cause more harm on newer versions), but will require 
> a lot care, as it introduces 248 new errors/warnings:

And they come from 71 different files (list enclosed). I didn't look on them,
and I'll stop handling here for now, as I need to handle some other stuff.

Yet, manually fixing those 71 ABI files doesn't sound a too hard work. It
can probably be done on a single day.

So, I suspect we could enable :rst: and manually fix those.

Regards,
Mauro

-

Files that have issues when assuming that they're ReST friendly:

    configfs-spear-pcie-gadget
    configfs-usb-gadget
    configfs-usb-gadget-hid
    configfs-usb-gadget-rndis
    configfs-usb-gadget-uac1
    configfs-usb-gadget-uvc
    debugfs-ec
    debugfs-pktcdvd
    dev-kmsg
    evm
    ima_policy
    procfs-diskstats
    sysfs-block
    sysfs-block-device
    sysfs-bus-acpi
    sysfs-bus-event_source-devices-format
    sysfs-bus-i2c-devices-pca954x
    sysfs-bus-iio
    sysfs-bus-iio-adc-envelope-detector
    sysfs-bus-iio-cros-ec
    sysfs-bus-iio-dfsdm-adc-stm32
    sysfs-bus-iio-lptimer-stm32
    sysfs-bus-iio-magnetometer-hmc5843
    sysfs-bus-iio-temperature-max31856
    sysfs-bus-iio-timer-stm32
    sysfs-bus-intel_th-devices-msc
    sysfs-bus-rapidio
    sysfs-bus-thunderbolt
    sysfs-bus-usb
    sysfs-bus-usb-devices-usbsevseg
    sysfs-bus-vfio-mdev
    sysfs-class-cxl
    sysfs-class-led
    sysfs-class-mic.txt
    sysfs-class-ocxl
    sysfs-class-power
    sysfs-class-power-twl4030
    sysfs-class-rc
    sysfs-class-scsi_host
    sysfs-class-typec
    sysfs-devices-platform-ACPI-TAD
    sysfs-devices-platform-docg3
    sysfs-devices-platform-sh_mobile_lcdc_fb
    sysfs-devices-system-cpu
    sysfs-devices-system-ibm-rtl
    sysfs-driver-bd9571mwv-regulator
    sysfs-driver-genwqe
    sysfs-driver-hid-logitech-lg4ff
    sysfs-driver-hid-wiimote
    sysfs-driver-samsung-laptop
    sysfs-driver-toshiba_acpi
    sysfs-driver-toshiba_haps
    sysfs-driver-wacom
    sysfs-firmware-acpi
    sysfs-firmware-dmi-entries
    sysfs-firmware-gsmi
    sysfs-firmware-memmap
    sysfs-fs-ext4
    sysfs-hypervisor-xen
    sysfs-kernel-boot_params
    sysfs-kernel-mm-hugepages
    sysfs-platform-asus-laptop
    sysfs-platform-asus-wmi
    sysfs-platform-at91
    sysfs-platform-eeepc-laptop
    sysfs-platform-ideapad-laptop
    sysfs-platform-intel-wmi-thunderbolt
    sysfs-platform-sst-atom
    sysfs-platform-usbip-vudc
    sysfs-ptp
    sysfs-uevent

Thanks,
Mauro
