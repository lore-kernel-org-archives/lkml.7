Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F32C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86DD217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfHHFba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:31:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:14087 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbfHHFba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:31:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 22:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="374730924"
Received: from jbrandeb-mobl2.amr.corp.intel.com (HELO localhost) ([10.254.39.134])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2019 22:31:28 -0700
Date:   Wed, 7 Aug 2019 22:31:27 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     <christopher.lee@cspi.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jesse.brandeburg@intel.com
Subject: Re: [PATCH] myri10ge: remove unneeded variable
Message-ID: <20190807223127.00007fd8@intel.com>
In-Reply-To: <1564563226-13367-1-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1564563226-13367-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 16:53:46 +0800
Ding Xiang <dingxiang@cmss.chinamobile.com> wrote:

> "error" is unneeded,just return 0
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
