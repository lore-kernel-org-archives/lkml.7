Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D4FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0E520815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfETL6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 07:58:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:28368 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730727AbfETL6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 07:58:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:58:33 -0700
X-ExtLoop1: 1
Received: from mhauser-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.244])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2019 04:58:29 -0700
Date:   Mon, 20 May 2019 14:58:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com
Subject: Re: [PATCH v3 1/2] ftpm: firmware TPM running in TEE
Message-ID: <20190520115827.GG27805@linux.intel.com>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190415155636.32748-2-sashal@kernel.org>
 <20190515081250.GA7708@linux.intel.com>
 <20190517132226.GB11972@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517132226.GB11972@sasha-vm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 09:22:26AM -0400, Sasha Levin wrote:
> The whole TEE subsystem is already well documented in our kernel tree
> (https://www.kernel.org/doc/Documentation/tee.txt) and beyond. I can add
> a reference to the doc here, but I'd rather not add a bunch of TEE
> related comments as you suggest later in your review.
> 
> The same way a PCI device driver doesn't describe what PCI is in it's
> code, we shouldn't be doing the same for TEE here.

Thanks for pointing out the documentation! That is sufficient.

/Jarkko
