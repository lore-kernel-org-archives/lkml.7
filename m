Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71811C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfE2LiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:38:24 -0400
Received: from verein.lst.de ([213.95.11.211]:54210 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfE2LiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:38:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E068268AFE; Wed, 29 May 2019 13:37:58 +0200 (CEST)
Date:   Wed, 29 May 2019 13:37:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 0/5] prerequisites for device reserved local mem
 rework
Message-ID: <20190529113758.GA9399@lst.de>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com> <20190529113427.GC11952@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529113427.GC11952@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 04:34:27AM -0700, Greg KH wrote:
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Christoph, this is going through your tree, right?

Yes, I'll pіck it up.
