Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAC4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB192084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbfJUVWA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:22:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:16597 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUVWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 14:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="398796611"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.54.70.82])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2019 14:21:59 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Yi Wang <wang.yi59@zte.com.cn>, jhs@mojatatu.com
Cc:     xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: Re: [PATCH] net: sched: taprio: fix -Wmissing-prototypes warnings
In-Reply-To: <1571658424-4273-1-git-send-email-wang.yi59@zte.com.cn>
References: <1571658424-4273-1-git-send-email-wang.yi59@zte.com.cn>
Date:   Mon, 21 Oct 2019 14:23:08 -0700
Message-ID: <877e4xztc3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yi Wang <wang.yi59@zte.com.cn> writes:

> We get one warnings when build kernel W=1:
> net/sched/sch_taprio.c:1155:6: warning: no previous prototype for ‘taprio_offload_config_changed’ [-Wmissing-prototypes]
>
> Make the function static to fix this.
>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---

This looks like it should be directed to net-next.

When you re-send it for net-next, feel free to add my:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
--
Vinicius
