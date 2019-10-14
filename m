Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B015EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913A120673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfJNT0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:26:11 -0400
Received: from outgoing-stata.csail.mit.edu ([128.30.2.210]:44807 "EHLO
        outgoing-stata.csail.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730590AbfJNT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:26:11 -0400
Received: from [4.30.142.84] (helo=srivatsab-a01.vmware.com)
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1iK5yp-000RoV-PV; Mon, 14 Oct 2019 15:26:07 -0400
Subject: Re: [PATCH 3/3] tracing/hwlat: Fix a few trivial nits
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
 <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
 <20191014152421.112bfa96@gandalf.local.home>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <c9506423-c50f-9f1d-672e-4add0e5123e3@csail.mit.edu>
Date:   Mon, 14 Oct 2019 12:26:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014152421.112bfa96@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 12:24 PM, Steven Rostedt wrote:
> On Thu, 10 Oct 2019 11:51:17 -0700
> "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
> 
>> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
>>
>> Update the source file name in the comments, and fix a grammatical
>> error.
> 
> Patch 1 and 2 have already been applied to Linus's tree.
> 
> I've queued this one up for the next merge window.
> 
> Thanks!
> 

Thanks a lot Steve!

Regards,
Srivatsa
