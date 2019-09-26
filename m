Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142A3C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7764206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 06:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392919AbfIZGeN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:34:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47666 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388934AbfIZGeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 02:34:12 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 622AECECD9;
        Thu, 26 Sep 2019 08:43:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCHv2] Bluetooth: trivial: tidy up printk message output from
 btrtl.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190909184446.9049-1-rsalvaterra@gmail.com>
Date:   Thu, 26 Sep 2019 08:34:10 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui <rui@arrandale.lan>
Content-Transfer-Encoding: 8BIT
Message-Id: <C9B9ED17-F82B-4F25-996E-C1880AC49E1B@holtmann.org>
References: <20190909184446.9049-1-rsalvaterra@gmail.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

> v2: also remove new line from hci_h5.c
> 
> The rtl_dev_* calls in the Realtek USB Bluetooth driver add unnecessary
> device prefixes and new lines at the end of most messages, which make the
> dmesg output look like this:
> 
> [    5.667121] sd 0:0:0:0: [sda] Attached SCSI disk
> [    5.736869] Bluetooth: hci0: RTL: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821
> 
> [    5.737853] Bluetooth: hci0: RTL: rom_version status=0 version=1
> 
> [    5.737857] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8821a_fw.bin
> 
> [    5.737946] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8821a_config.bin
> 
> [    5.737965] bluetooth hci0: Direct firmware load for rtl_bt/rtl8821a_config.bin failed with error -2
> [    5.737972] Bluetooth: hci0: RTL: cfg_sz -2, total sz 17428
> 
> [    5.997375] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> Clean this up by removing extraneous new lines and redundant device prefixes,
> with the following result:
> 
> [    5.667008] sd 0:0:0:0: [sda] Attached SCSI disk
> [    5.716945] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8821
> [    5.718745] Bluetooth: hci0: rtl: rom_version status=0 version=1
> [    5.718749] Bluetooth: hci0: rtl: loading rtl_bt/rtl8821a_fw.bin
> [    5.718830] Bluetooth: hci0: rtl: loading rtl_bt/rtl8821a_config.bin
> [    5.718849] bluetooth hci0: Direct firmware load for rtl_bt/rtl8821a_config.bin failed with error -2
> [    5.718858] Bluetooth: hci0: rtl: cfg_sz -2, total sz 17428
> [    5.997400] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
> drivers/bluetooth/btrtl.c  | 62 +++++++++++++++++++-------------------
> drivers/bluetooth/btrtl.h  |  8 ++---
> drivers/bluetooth/hci_h5.c |  2 +-
> 3 files changed, 36 insertions(+), 36 deletions(-)

I have some similar patch in my tree. Can you check what is still missing and send a new version. Thanks.

Regards

Marcel

