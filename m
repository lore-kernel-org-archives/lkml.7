Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B3C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697B021882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfJNNPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D931B3082E4E;
        Mon, 14 Oct 2019 13:15:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D786046B;
        Mon, 14 Oct 2019 13:15:51 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] Add CascadeLake-N Support
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <67aaedb2-dc74-7a60-7345-1c160e6b08e5@redhat.com>
Date:   Mon, 14 Oct 2019 09:15:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 14 Oct 2019 13:15:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/19 3:30 PM, Srinivas Pandruvada wrote:
> Add support for SST-BF on CascadeLake-N support.  The CascadeLake-N
> processor only support SST-BF and not other SST functionality.
>

Sorry Srinivas, was away from keyboard all last week :(

> v3:
> Fix crash due to geline

^^^ curious how you hit this?  I was repeatedly testing and couldn't
get it to happen.

> Fix display to perf-profile info and base-freq info command
> Fix output for coremask
> Fix base frequency CPU list. This should be displayed for a package
> Auto mode support for base-freq enable/disable
> One of the patch for config only change folded to next one where it is
> used.
>
> The patch 1 has nothing to do with the CLX-N. It saves some bytes in the
> size.
>

Reviewed-by: Prarit Bhargava <prarit@redhat.com>

P.
