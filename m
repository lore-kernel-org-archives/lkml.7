Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C45A208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfHFQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:21:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:22438 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732531AbfHFQV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:21:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 09:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="374103242"
Received: from ellie.jf.intel.com (HELO ellie) ([10.24.12.161])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 09:21:56 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: sched: sch_taprio: fix memleak in error path for sched list parse
In-Reply-To: <20190806100425.4356-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
References: <20190806100425.4356-1-ivan.khoronzhuk@linaro.org>
Date:   Tue, 06 Aug 2019 09:21:56 -0700
Message-ID: <871rxyqn6j.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:

> In case off error, all entries should be freed from the sched list
> before deleting it. For simplicity use rcu way.
>
> Fixes: 5a781ccbd19e46 ("tc: Add support for configuring the taprio scheduler")
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


