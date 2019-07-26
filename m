Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334FDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025AF21880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564129100;
	bh=dt4j9TpaI8Y9Rlugmz9J36iB3zzyKY530FYg//lafM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rxw1uAYb1qYSPkgyU0xww2MRRoRsBeSwe/uWAuqee2eyTDqxudE1lcB8uyE8k2qWl
	 w+MdNpEmvJ/u6UW0yRZxm3Siogp4f6HPaDYwUqYT3T1hnQjUseubXApE38ZThlZzoR
	 LM/11oLdEL1PTX6o8CdSmoMyU7DlSFrJIBWaLNOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZIST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfGZISS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:18:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1664F21880;
        Fri, 26 Jul 2019 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564129097;
        bh=dt4j9TpaI8Y9Rlugmz9J36iB3zzyKY530FYg//lafM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V25elAwaTbciJEwzuSeFyMAAbEdEhXFkN8IUCxy3BSkEI/5gLDHIL74lyWjZvi5u0
         pabo3ac7u26e78TQv5gBDdaOFMmPY1lCIUZUafkoYcKD8PH/o2qGuuxZ5L32VnboWB
         vdK0bibMXuMzZUAGIrpmr25GvSAHD5WCwd3z3dFg=
Date:   Fri, 26 Jul 2019 10:18:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Message-ID: <20190726081815.GA15572@kroah.com>
References: <20190726074012.2590-1-je.yen.tam@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726074012.2590-1-je.yen.tam@ni.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:40:12PM +0800, Je Yen Tam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>

Looks good, now queued up, thanks for all of the revisions.

greg k-h
