Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D0CC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49AC214E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 18:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKISqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 13:46:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:11656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfKISqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 13:46:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2019 10:46:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,286,1569308400"; 
   d="scan'208";a="404777363"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2019 10:46:49 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E99AD300E00; Sat,  9 Nov 2019 10:46:48 -0800 (PST)
Date:   Sat, 9 Nov 2019 10:46:48 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Qi Liu <liuqi115@hisilicon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        huangdaode <huangdaode@hisilicon.com>,
        linyunsheng <linyunsheng@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [QUESTION]perf stat: comment of miss ratio
Message-ID: <20191109184648.GB573472@tassilo.jf.intel.com>
References: <F57F094935A66448B135517D3F6EA397F35063@DGGEMA504-MBS.china.huawei.com>
 <20191109024754.GA573472@tassilo.jf.intel.com>
 <b7e93eb7-2ef9-1448-c4ca-7495bc934b32@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7e93eb7-2ef9-1448-c4ca-7495bc934b32@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So, may I send a patch to fix all these strings?

Yes, probably needed for all of them.

-Andi
