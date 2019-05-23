Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053EC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC99E2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfEWG40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:56:26 -0400
Received: from verein.lst.de ([213.95.11.211]:44461 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWG40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:56:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2ECB668B05; Thu, 23 May 2019 08:56:03 +0200 (CEST)
Date:   Thu, 23 May 2019 08:56:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v6 0/5] prerequisites for device reserved local mem
 rework
Message-ID: <20190523065602.GA11928@lst.de>
References: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522142748.10078-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we seem to be getting ready to merge this series:  can the usb
maintainers please commit it to an immutable branch that I can pull
into the dma-mapping tree?  These changes are a preparation for
reworking the per-device DMA coherent allocator, and I'd prefer not
to wait for the next merge window with the next steps.
