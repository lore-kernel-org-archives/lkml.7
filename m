Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251BCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7482084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565814077;
	bh=DIiT5t06AKD3T2c856g4N8QDDAj4vmC3zOzzxFNapcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ERfNRmgK545fdVqLU52eXbZjq56EaKHn62rSVU937STrtKr8X/sY2e6UoCQAUsSCo
	 nUb3QPbNQU8e2UglXWejDFJaDctntEpiGClot+bCqNBPTX7rdaodOdZ3HO14nt/3Ak
	 ycoxMBJrH/YZoL8WSK9q+Vc2OlU6JpNgP40Ia/LE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfHNUVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:21:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:62596 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfHNUVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:21:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 13:21:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="scan'208";a="260610415"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2019 13:21:13 -0700
Date:   Wed, 14 Aug 2019 14:19:01 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        "sjg@google.com" <sjg@google.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Jared Dominguez <jared.dominguez@dell.com>
Subject: Re: [PATCH v2] nvme: Add quirk for LiteON CL1 devices running FW
 22301111
Message-ID: <20190814201900.GA3511@localhost.localdomain>
References: <1565813304-16710-1-git-send-email-mario.limonciello@dell.com>
 <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f20898-b9af-eee0-97de-0a568de54b57@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:14:50PM -0700, Sagi Grimberg wrote:
> Mario,
> 
> Can you please respin a patch that applies cleanly on nvme-5.4?

This fixes a regression we introduced in 5.3, so it should go in
5.3-rc. For this to apply cleanly, though, we'll need to resync to Linus'
tree to get Rafael's PCIe ASPM check after he sends his linux-pm pull
request.
