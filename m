Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C04C742A9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054F621530
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfGLDiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:38:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:16893 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbfGLDiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:38:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 20:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,481,1557212400"; 
   d="scan'208";a="186517666"
Received: from gonegri-mobl.ger.corp.intel.com (HELO localhost) ([10.252.48.192])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2019 20:37:59 -0700
Date:   Fri, 12 Jul 2019 06:37:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v8 0/2] fTPM: firmware TPM running in TEE
Message-ID: <20190712033758.vnwrmdxvz2kplt65@linux.intel.com>
References: <20190705204746.27543-1-sashal@kernel.org>
 <20190711200858.xydm3wujikufxjcw@linux.intel.com>
 <20190711201059.GA18260@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711201059.GA18260@apalos>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:10:59PM +0300, Ilias Apalodimas wrote:
> Will report back any issues when we start using it on real hardware
> rather than QEMU
> 
> Thanks
> /Ilias

That would awesome. PR is far away so there is time to add more
tested-by's. Thanks.

/Jarkko
