Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B274C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21657208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfEMPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:47:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:53768 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728712AbfEMPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:47:42 -0400
Received: (qmail 4582 invoked by uid 2102); 13 May 2019 11:47:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2019 11:47:40 -0400
Date:   Mon, 13 May 2019 11:47:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Igor Plyatov <plyatov@gmail.com>
cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Initialisation of SOC USB pads
In-Reply-To: <607c6b4c-d53a-8115-aa60-2a8461607d40@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1905131146380.1478-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019, Igor Plyatov wrote:

> Dear developers,
> 
> can you please explain who must configure AT91SAM9G20 SOC pads to 
> operate as USB Host port? Is it AT91Bootstrap, U-Boot bootloader, Linux 
> kernel or this is not required at all?
> 
> I ask, because during connection of USB disk, my board complains
> 
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device descriptor read/64, error -62
> usb 1-1: device not accepting address 4, error -62
> usb 1-1: device not accepting address 5, error -62
> usb usb1-port1: unable to enumerate USB device
> 
> 
> Looks like there is no connectivity between USB Host module of SOC and 
> USB device. Or am I wrong?
> 
> 
> My setup is:
> 
> 
> * AT91SAM9G20 based custom board;
> * Linux kernel 4.9.36, from LINUX4SAM project.
> * USB disk connected to USB Host port 0 (HDPA, HDMA pins of SOC). 39 Ohm 
> series resistors and 15 Kohm pull-down resistors added at these lines. 
> Connectivity between SOC and USB device confirmed by Ohmmeter.
> * USB_VBUS voltage measured at USB connector = 4.96 VDC.

You probably should ask somebody at the LINUX4SAM project.

Alan Stern

