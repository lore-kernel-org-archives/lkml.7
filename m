Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978ABC04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD82063F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfEEDVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 23:21:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:44607 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727055AbfEEDVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 23:21:16 -0400
X-UUID: b5b54521642041d094aec0121f9c5bd5-20190505
X-UUID: b5b54521642041d094aec0121f9c5bd5-20190505
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2135820257; Sun, 05 May 2019 11:21:00 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 5 May
 2019 11:20:56 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 5 May 2019 11:20:56 +0800
Message-ID: <1557026456.10179.261.camel@mhfsdcap03>
Subject: Re: linux-next: Tree for May 2 (drivers/usb/mtu3/mtu3_debugfs.o)
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Sun, 5 May 2019 11:20:56 +0800
In-Reply-To: <3e56059c-e024-324f-f584-75a806d9b0e0@infradead.org>
References: <20190502201028.707453d8@canb.auug.org.au>
         <3e56059c-e024-324f-f584-75a806d9b0e0@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: C34135B66CD1248BC920FDFC08C2E130B3749552C9C5D14BFBA1722239135E9A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
On Thu, 2019-05-02 at 08:17 -0700, Randy Dunlap wrote:
> On 5/2/19 3:10 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190501:
> > 
> 
> on i386:
> 
> ld: drivers/usb/mtu3/mtu3_debugfs.o: in function `ssusb_debugfs_create_root':
> mtu3_debugfs.c:(.text+0xba3): undefined reference to `usb_debug_root'
> 
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set     <<<<< no host-side USB
> # CONFIG_USB_PCI is not set
> CONFIG_USB_MTU3=y
> CONFIG_USB_MTU3_GADGET=y     <<<<< gadget-only mode
> # CONFIG_USB_MTU3_DEBUG is not set
> CONFIG_USB_MUSB_HDRC=m
> CONFIG_USB_MUSB_GADGET=y
> 
> usb_debug_root is in drivers/usb/core/usb.c, which is only built
> when CONFIG_USB is set/enabled.
> 
I'll fix it ASAP.

Thanks a lot

> 
> 
> Full randconfig file is attached.
> 


