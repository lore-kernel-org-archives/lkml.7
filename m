Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2AC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070D42053B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbfIDQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:42:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38117 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfIDQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:42:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5YMG-0003Uf-5q; Wed, 04 Sep 2019 10:42:12 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i5YMF-0000Z5-KX; Wed, 04 Sep 2019 10:42:12 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
References: <20190903162519.7136-1-sashal@kernel.org>
        <20190903162519.7136-111-sashal@kernel.org>
        <87ef0xqq9f.fsf@x220.int.ebiederm.org>
        <20190903194526.GH5281@sasha-vm>
Date:   Wed, 04 Sep 2019 11:41:55 -0500
In-Reply-To: <20190903194526.GH5281@sasha-vm> (Sasha Levin's message of "Tue,
        3 Sep 2019 15:45:26 -0400")
Message-ID: <87y2z4nhd8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i5YMF-0000Z5-KX;;;mid=<87y2z4nhd8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19zYZU/xsW7us0tfO+uH4u3qzYGa3Y2+bo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH AUTOSEL 4.19 111/167] signal/arc: Use force_sig_fault where appropriate
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Sep 03, 2019 at 11:49:16AM -0500, Eric W. Biederman wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>
>>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>>
>>> [ Upstream commit 15773ae938d8d93d982461990bebad6e1d7a1830 ]
>>
>>To the best of my knowledge this is just a clean up, no changes in
>>behavior are present.
>>
>>The only reason I can see to backport this is so that later fixes could
>>be applied cleanly.
>>
>>So while I have no objections to this patch being backported I don't see
>>why you would want to either.
>
> This patch along with the next one came in as a dependency for
> a8c715b4dd73c ("ARC: mm: SIGSEGV userspace trying to access kernel
> virtual memory").

Thanks for providing the rest of the context.

That looks like a perfect reason for backporting this patch.

Eric


