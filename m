Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A822067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="Gg9ms/qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbfJJNa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:30:58 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:58319 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfJJNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=quv4NTOkLsYzLEUOtD0kQGcbjs9O5FlvKDWJavW93Z8=; b=Gg9ms/qnO4DEAYLLFns0SicFJN
        trgL2GUvuLlGpLkHe6v/q2Dunh1KiQdK5FEb8Z6N6AOjp8CoBa1PX23vTi0MDTLZ+la4lT9W/0930
        nxiM5AzSJXo3mI4O/A5hwGAfDGPOtx2ELIbpr1uWm/kxveFF7aTTD2CkUUH9bWXl/Cq2C8BnKHC+m
        R/YwuZhMEhxcW1ltJgIJBMM/VQum3vcyhvyhP31Mne//3/PpEY+gyxOi+0P8YZaJoCWMIXNTENYiO
        Ymx9ZoORbCrU+19MKjsekW6HThTmzAkLGSpf6sMijjtWlCKiV6+XD5kUj8SytHGF5v5RMl6r3KrPh
        eHazJiBw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58246 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1iIYWu-0007X3-KR; Thu, 10 Oct 2019 15:30:56 +0200
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
 <20191001134555.GB22532@ziepe.ca>
 <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
 <20191009104531.GW16989@phenom.ffwll.local>
 <1bc77839-c47a-6e79-dd6e-e26e05b34eae@tronnes.org>
 <20191009133138.scz3i5jjcqt3gnjd@gilmour>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b3fd63ce-3b8b-c8b8-3ed1-8331ab9a2440@tronnes.org>
Date:   Thu, 10 Oct 2019 15:30:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009133138.scz3i5jjcqt3gnjd@gilmour>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 09.10.2019 15.31, skrev Maxime Ripard:
> On Wed, Oct 09, 2019 at 02:48:20PM +0200, Noralf Trønnes wrote:
>> Den 09.10.2019 12.45, skrev Daniel Vetter:
>>> On Tue, Oct 01, 2019 at 04:07:38PM +0200, Noralf Trønnes wrote:
>>>> Hi drm-misc maintainers,
>>>>
>>>> I have just applied a patch to drm-misc-next that as it turns out should
>>>> have been applied to -fixes for this -rc cycle.
>>>>
>>>> Should I cherry pick it to drm-misc-next-fixes?
>>>
>>> Yup, cherry pick and reference the commit that's already in -next (in case
>>> it creates conflicts down the road that reference makes the mess easier to
>>> understand).
>>>
>>
>> I remembered that Maxime just sent out a fixes pull and the subject says
>> drm-misc-fixes. The prevous one he sent out was -next-fixes.
>> So it looks like I should cherry pick to drm-misc-fixes for it to show
>> up in 5.4?
> 
> drm-misc-next-fixes is the branch where we gather fixes supposed to be
> applied on top of drm-misc-next during the merge window. If you have
> something targeting the current release, it should be drm-misc-fixes
> indeed.

Thanks, it's applied now.

Noralf.

> 
> Maxime
> 
