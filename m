Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18879C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7154206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfC2PMx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:12:53 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:59014 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbfC2PMw (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Fri, 29 Mar 2019 11:12:52 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 29 Mar 2019 09:12:51 -0600
Message-Id: <5C9E35EF0200007800222E0B@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.0 
Date:   Fri, 29 Mar 2019 09:12:47 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/Xen: streamline (and fix) PV CPU enumeration
References: <5C9B92EA020000780022227B@prv1-mh.provo.novell.com>
 <2f027b4b-dce2-3e90-dc1b-c824bc8eb355@oracle.com>
 <5C9C8DDC0200007800222606@prv1-mh.provo.novell.com>
 <eda3938f-02a5-e5a2-4718-d75bc488f296@oracle.com>
 <5C9DDD530200007800222B22@prv1-mh.provo.novell.com>
 <24df98be-21e7-617e-7651-ae34e2a2e512@oracle.com>
In-Reply-To: <24df98be-21e7-617e-7651-ae34e2a2e512@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 29.03.19 at 14:42, <boris.ostrovsky@oracle.com> wrote:
> On 3/29/19 4:54 AM, Jan Beulich wrote:
>>>>> On 28.03.19 at 17:50, <boris.ostrovsky@oracle.com> wrote:
>>>
>>> Given especially xen_pv_smp_prepare_cpus(), I think re-working proper
>>> setting of present/possible masks is well beyond the scope of your
>>> original patch.
>> Well, then the question is, what (if any) changes are you
>> expecting me to make for this change to be acceptable? Or do
>> you perhaps want me to add a 2nd patch on top addressing
>> the other outlined anomalies?
> 
> If your goal is just to fix the dom0_max_vcpus issue then this patch is
> sufficient (but the commit message should say that this is what the
> patch is for).
> 
> But if you are trying to make cpu masks management done properly then I
> think this patch alone does not address this fully.

I.e. folding the further items discussed into this patch would be
fine by you? (I'm just trying to avoid having to go through
several more rounds of patch submissions.)

Jan


