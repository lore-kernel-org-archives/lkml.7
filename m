Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A6C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PJTy7S5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfHSMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:09:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51750 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:09:04 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7JC8s3n023197;
        Mon, 19 Aug 2019 07:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566216534;
        bh=KFdSQOsdjhK41C1HepacSpv9P02yCCkQhKBtTM2IF48=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PJTy7S5j7V4i2lzbXHVxmVQmQb0lp2eV86qreaKsIM2kz9WSUIBo7BRTnpNRpFvqi
         71TCxpJm5vzVMUk4qGvpaKCl1/Dw9beBsLwCzcberat7XzjfE2ZKA8ZLDvnzEWuZwf
         /M648WcEhbaWSQqOoaSat+WJidGIf9HrAqukWN0s=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7JC8sdZ072063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Aug 2019 07:08:54 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 19
 Aug 2019 07:08:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 19 Aug 2019 07:08:53 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7JC8pDp049587;
        Mon, 19 Aug 2019 07:08:51 -0500
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Pawel Laszczak <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>
References: <Pine.LNX.4.44L0.1908151037120.1664-100000@iolanthe.rowland.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <ede5f5b6-12c9-9120-7378-48e7cd42de57@ti.com>
Date:   Mon, 19 Aug 2019 15:08:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1908151037120.1664-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2019 17:39, Alan Stern wrote:
> On Thu, 15 Aug 2019, Roger Quadros wrote:
> 
>> Felipe & Alan,
>>
>> On 21/07/2019 21:32, Pawel Laszczak wrote:
>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>>
>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>> Host Only (XHCI)configurations.
>>>
>>> The current driver has been validated with FPGA burned. We have support
>>> for PCIe bus, which is used on FPGA prototyping.
>>>
>>> The host side of USBSS-DRD controller is compliance with XHCI
>>> specification, so it works with standard XHCI Linux driver.
>>
>> While testing this driver I encountered the following issue if I do the following.
>>
>> 1) USB port is "otg" and nothing connected so it is in IDLE mode to begin with.
>>    i.e. HCD & UDC not registered.
>>
>> 2) Load mass storage gadget with backing medium.
>>    > modprobe g_mass_storage file=lun stall=0
>>
>> [   28.172142] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers
>>
>> 3) Connect port to PC host
>>
>> [   30.564767] cdns-usb3 6000000.usb: Initialized  ep0 support:  
>> [   30.570591] cdns-usb3 6000000.usb: Initialized  ep1out support: BULK, INT ISO
>> [   30.577713] cdns-usb3 6000000.usb: Initialized  ep2out support: BULK, INT ISO
>> [   30.584835] cdns-usb3 6000000.usb: Initialized  ep3out support: BULK, INT ISO
>> [   30.591957] cdns-usb3 6000000.usb: Initialized  ep4out support: BULK, INT ISO
>> [   30.599078] cdns-usb3 6000000.usb: Initialized  ep5out support: BULK, INT ISO
>> [   30.606199] cdns-usb3 6000000.usb: Initialized  ep6out support: BULK, INT ISO
>> [   30.613320] cdns-usb3 6000000.usb: Initialized  ep7out support: BULK, INT ISO
>> [   30.620441] cdns-usb3 6000000.usb: Initialized  ep8out support: BULK, INT ISO
>> [   30.627562] cdns-usb3 6000000.usb: Initialized  ep9out support: BULK, INT ISO
>> [   30.634684] cdns-usb3 6000000.usb: Initialized  ep10out support: BULK, INT ISO
>> [   30.641893] cdns-usb3 6000000.usb: Initialized  ep11out support: BULK, INT ISO
>> [   30.649100] cdns-usb3 6000000.usb: Initialized  ep12out support: BULK, INT ISO
>> [   30.656309] cdns-usb3 6000000.usb: Initialized  ep13out support: BULK, INT ISO
>> [   30.663516] cdns-usb3 6000000.usb: Initialized  ep14out support: BULK, INT ISO
>> [   30.670724] cdns-usb3 6000000.usb: Initialized  ep15out support: BULK, INT ISO
>> [   30.677935] cdns-usb3 6000000.usb: Initialized  ep1in support: BULK, INT ISO
>> [   30.684979] cdns-usb3 6000000.usb: Initialized  ep2in support: BULK, INT ISO
>> [   30.692020] cdns-usb3 6000000.usb: Initialized  ep3in support: BULK, INT ISO
>> [   30.699057] cdns-usb3 6000000.usb: Initialized  ep4in support: BULK, INT ISO
>> [   30.706097] cdns-usb3 6000000.usb: Initialized  ep5in support: BULK, INT ISO
>> [   30.713135] cdns-usb3 6000000.usb: Initialized  ep6in support: BULK, INT ISO
>> [   30.720175] cdns-usb3 6000000.usb: Initialized  ep7in support: BULK, INT ISO
>> [   30.727213] cdns-usb3 6000000.usb: Initialized  ep8in support: BULK, INT ISO
>> [   30.734252] cdns-usb3 6000000.usb: Initialized  ep9in support: BULK, INT ISO
>> [   30.741289] cdns-usb3 6000000.usb: Initialized  ep10in support: BULK, INT ISO
>> [   30.748414] cdns-usb3 6000000.usb: Initialized  ep11in support: BULK, INT ISO
>> [   30.755536] cdns-usb3 6000000.usb: Initialized  ep12in support: BULK, INT ISO
>> [   30.762661] cdns-usb3 6000000.usb: Initialized  ep13in support: BULK, INT ISO
>> [   30.769785] cdns-usb3 6000000.usb: Initialized  ep14in support: BULK, INT ISO
>> [   30.776910] cdns-usb3 6000000.usb: Initialized  ep15in support: BULK, INT ISO
>> [   30.786313] Mass Storage Function, version: 2009/09/11
>> [   30.791455] LUN: removable file: (no medium)
>> [   31.039497] lun0: unable to open backing file: 500M.bin
>> [   31.158689] g_mass_storage 6000000.usb: failed to start g_mass_storage: -2
>> [   31.165606] cdns-usb3 6000000.usb: Failed to register USB device controller
>> [   31.172585] cdns-usb3 6000000.usb: set 2 has failed, back to 0
>>
>> Now, -2 is ENOENT i.e.	/* No such file or directory */
>> The file is present so that's not the real issue.
>>
>> The call trace to fsg_lun_open is below
>>
>> [   30.952877]  fsg_lun_open+0x24/0x42c [usb_f_mass_storage]
>> [   30.958259]  fsg_common_create_lun+0xc8/0x2b8 [usb_f_mass_storage]
>> [   30.964422]  fsg_common_create_luns+0xa4/0x104 [usb_f_mass_storage]
>> [   30.970670]  msg_bind+0xd8/0x1e0 [g_mass_storage]
>> [   30.975360]  composite_bind+0x7c/0x180 [libcomposite]
>> [   30.980396]  udc_bind_to_driver+0x68/0x110 [udc_core]
>> [   30.985432]  check_pending_gadget_drivers+0x74/0xd8 [udc_core]
>> [   30.991247]  usb_add_gadget_udc_release+0x180/0x1e8 [udc_core]
>> [   30.997062]  usb_add_gadget_udc+0x10/0x18 [udc_core]
>> [   31.002010]  __cdns3_gadget_init+0x3a0/0x628 [cdns3]
>> [   31.006959]  cdns3_role_start+0x6c/0xd0 [cdns3]
>> [   31.011473]  cdns3_hw_role_switch+0x80/0xe8 [cdns3]
>> [   31.016336]  cdns3_drd_thread_irq+0x10/0x20 [cdns3]
>> [   31.021197]  irq_thread_fn+0x28/0x78
>> [   31.024757]  irq_thread+0x124/0x1b8
>> [   31.028233]  kthread+0x124/0x128
>> [   31.031447]  ret_from_fork+0x10/0x18
>>
>> Is opening the backing file from irq_thread_fn the issue here?
>> If yes, how to resolve this?
> 
> I would guess that it probably is related to that.
> 
> In any case, the backing filename should be an explicit complete path.  
> Who knows what the current directory will be when the actual open call
> takes place?

This seems to be the case. It works fine with complete path.

Do we need to care about this in the mass storage gadget or just
rely on the user to provide the full path?

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
