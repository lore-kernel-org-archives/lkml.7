Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D13AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4905B214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfDWRfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:35:11 -0400
Received: from verein.lst.de ([213.95.11.211]:48225 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbfDWRfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:35:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3D02668AFE; Tue, 23 Apr 2019 19:34:56 +0200 (CEST)
Date:   Tue, 23 Apr 2019 19:34:56 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Deepak Singh Rawat <drawat@vmware.com>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/vmwgfx: Fix dma API layer violation
Message-ID: <20190423173456.GA25596@lst.de>
References: <20190423123242.3028-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423123242.3028-1-thellstrom@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, thanks!

Reviewed-by: Christoph Hellwig <hch@lst.de>
