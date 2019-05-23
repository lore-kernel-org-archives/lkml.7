Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D4C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09870204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfEWHMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:12:33 -0400
Received: from verein.lst.de ([213.95.11.211]:44598 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:12:32 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0A93D68B05; Thu, 23 May 2019 09:12:09 +0200 (CEST)
Date:   Thu, 23 May 2019 09:12:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v6 0/5] prerequisites for device reserved local mem
 rework
Message-ID: <20190523071208.GA12312@lst.de>
References: <20190522142748.10078-1-laurentiu.tudor@nxp.com> <20190523065602.GA11928@lst.de> <20190523070755.GA23832@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523070755.GA23832@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:07:55AM +0200, Greg KH wrote:
> I have no objection for you just taking this whole series as-is, no need
> to worry about merge conflicts with the USB tree, I doubt anything will
> be touching this area of code anytime soon.
> 
> So if you want to take it now, feel free to add:
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> to all of these.
> 
> Or, if you really like/want a branch to pull from, I can do that as
> well, which ever is easiest for you to work with as you all are doing
> the hard work here, not me :)

Nah, I can happily take it.  I'll open the dma-mapping tree after -rc2.
