Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC242145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbfFKNum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:50:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35662 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2387866AbfFKNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:50:41 -0400
Received: (qmail 1721 invoked by uid 2102); 11 Jun 2019 09:50:40 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2019 09:50:40 -0400
Date:   Tue, 11 Jun 2019 09:50:40 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <bleung@chromium.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <libusb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] USB: add usbfs ioctl to retrieve the connection parameters
In-Reply-To: <20190610223658.GA162167@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1906110950130.1535-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019, Dmitry Torokhov wrote:

> Recently usfbs gained availability to retrieve device speed, but there
> is sill no way to determine the bus number or list of ports the device
> is connected to when using usbfs. While this information can be obtained
> from sysfs, not all environments allow sysfs access. In a jailed
> environment a program might be simply given an opened file descriptor to
> usbfs device, and it is really important that all data can be gathered
> from said file descriptor.
> 
> This patch introduces a new ioctl, USBDEVFS_CONNINFO_EX, which return
> extended connection information for the device, including the bus
> number, address, port list and speed. The API allows kernel to extend
> amount of data returned by the ioctl and userspace has an option of
> adjusting the amount of data it is willing to consume. A new capability,
> USBDEVFS_CAP_CONNINFO_EX, is introduced to help userspace in determining
> whether the kernel supports this new ioctl.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

