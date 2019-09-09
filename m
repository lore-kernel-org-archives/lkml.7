Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E5C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF36E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405288AbfIIRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:02:29 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:32894 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbfIIRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:02:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 78F6A18224D99;
        Mon,  9 Sep 2019 17:02:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bulb50_4f83836154911
X-Filterd-Recvd-Size: 1233
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 17:02:26 +0000 (UTC)
Message-ID: <78acf5cf46bec83c007692be057851a28bed9108.camel@perches.com>
Subject: Re: [PATCH] Bluetooth: trivial: tidy up printk message output from
 btrtl.
From:   Joe Perches <joe@perches.com>
To:     Rui Salvaterra <rsalvaterra@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 Sep 2019 10:02:25 -0700
In-Reply-To: <20190909150329.1779-1-rsalvaterra@gmail.com>
References: <20190909150329.1779-1-rsalvaterra@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 16:03 +0100, Rui Salvaterra wrote:
> The rtl_dev_* calls in the Realtek USB Bluetooth driver add unnecessary
> device prefixes and new lines at the end of most messages, which make the
> dmesg output look like this:

OK, but maybe you could fix this one too:

drivers/bluetooth/hci_h5.c:             rtl_dev_err(h5->hu->hdev, "set baud rate command failed\n");


