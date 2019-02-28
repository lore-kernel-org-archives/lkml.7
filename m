Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AC6C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AC0218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366993;
	bh=1FWONd6O6xGsDvwwjuMEPc8xtFSFiHr6WxHoGtKX0HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DfH7wL4GskQZaWA6B33Ggz4sTpusPzzFfU/VMImj+lPRUbha1Gaet6dSNPFFzM8Bi
	 7GoA9ZBANJ8yqB9YNkamL5dDx7R4h8eJ59SUoNwT7gW8P+82JxVgknzl9Np4jRa79K
	 My9yEC6PaXukjayUg0X9IwuWNFuO6M2/oj1GtSPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389060AbfB1PQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:16:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:11072 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388682AbfB1PQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:29 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 07:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="142405347"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2019 07:16:27 -0800
Date:   Thu, 28 Feb 2019 08:16:43 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.19 59/64] nvme-pci: fix rapid add remove
 sequence
Message-ID: <20190228151642.GA21796@localhost.localdomain>
References: <20190228151105.11277-1-sashal@kernel.org>
 <20190228151105.11277-59-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228151105.11277-59-sashal@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:11:00AM -0500, Sasha Levin wrote:
> From: Keith Busch <keith.busch@intel.com>
> 
> [ Upstream commit 5c959d73dba6495ec01d04c206ee679d61ccb2b0 ]

This patch was broken, so please make sure to include the one that
fixes this:

  Upstream commit 4726bcf30fad37cc555cd9dcd6c73f2b2668c879
  ("nvme-pci: add missing unlock for reset error")
