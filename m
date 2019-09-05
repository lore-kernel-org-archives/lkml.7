Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4403C2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfIENxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:53:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:53272 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfIENxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:53:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 06:53:51 -0700
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="207873587"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 06:53:48 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2B2112069D; Thu,  5 Sep 2019 16:53:16 +0300 (EEST)
Date:   Thu, 5 Sep 2019 16:53:16 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, mareklindner@neomailbox.ch,
        mchehab@kernel.org, leon@kernel.org, dledford@redhat.com,
        a@unstable.cc, sw@simonwunderlich.de, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 2/3] media: v4l2: Use FIELD_SIZEOF directly
Message-ID: <20190905135316.GF5475@paasikivi.fi.intel.com>
References: <1567687896-19996-1-git-send-email-zhongjiang@huawei.com>
 <1567687896-19996-3-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567687896-19996-3-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 08:51:35PM +0800, zhong jiang wrote:
> It's more clear  to use FIELD_SIZEOF instead of its implementation.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
