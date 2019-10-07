Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7EDC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E656320867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570446196;
	bh=VDBJ4s2BZaKphj3RNMld+/VgIar3sIhB0/Ql1nq99ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iDHyglUbKTyISdnmQqS1XXMsWo+EZa/rWc97GoY5hhKRJZgRZwIIG0X3lQsfiINpL
	 BCLr5zFbPjwicmE+GzftAY7R16E5Gr2e4cacUn0PA+v/y5rwIi+MmW0DR2FyFWH/P2
	 y1c06cbRQPWPLacx9/Crc1uFRi0B/N9AjEmtyBaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfJGLDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfJGLDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:03:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0A4206BB;
        Mon,  7 Oct 2019 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570446194;
        bh=VDBJ4s2BZaKphj3RNMld+/VgIar3sIhB0/Ql1nq99ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVEmyDOU6lbwHpoqzNTAWCRu/nc4m0xpnDXn5bJnROx1XOCO7yl1BrWzg+4JP9viy
         AASXTopzobJ0XHc/IyKtsdm1eomZjMc2IAaAyKGoZhSrKRLFpMgPlA0lwKO3TJpuv7
         kPSUsy0QLUxxm1rriVZO5QODDivsbRjvOSlBEgFo=
Date:   Mon, 7 Oct 2019 13:03:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com, skomatineni@nvidia.com
Subject: Re: [PATCH v3 0/7] add Tegra194 XUSB host and pad controller support
Message-ID: <20191007110311.GA614644@kroah.com>
References: <20191004162906.4818-1-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004162906.4818-1-jckuo@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 12:28:59AM +0800, JC Kuo wrote:
> Hi,
> 
> This series introduces support for Tegra194 XUSB host and pad
> controller. Tegra194 XUSB host and pad controller are highly
> similar to the controllers found on Tegra186. Therefore, it's
> possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.

I've taken patches 1 and 2 through my USB tree.  If you want/need me to
take the others, please get acks from those maintainers on them so I can
do so.

thanks,

greg k-h
