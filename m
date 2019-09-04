Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BCC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3402922CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIDJFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:05:52 -0400
Received: from verein.lst.de ([213.95.11.211]:37466 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfIDJFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:05:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC445227A8A; Wed,  4 Sep 2019 11:05:48 +0200 (CEST)
Date:   Wed, 4 Sep 2019 11:05:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] remoteproc: don't allow modular build
Message-ID: <20190904090548.GA13541@lst.de>
References: <20190902200746.16185-1-hch@lst.de> <20190902200746.16185-4-hch@lst.de> <20190903210739.GW6167@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903210739.GW6167@minitux>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 02:07:39PM -0700, Bjorn Andersson wrote:
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Please pick this together with the other patches.

Thanks, I've applied the series to the dma-mapping tree for 5.4.
