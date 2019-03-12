Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BC9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89482075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552395362;
	bh=HTw32ICmUS6/OkVq9cu+3LMLNyUDmjek2zM8KY6ylbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kkH2DG7/8d5k7lHoG+Y6d3atH1nq2HcIHBucYtmnxPMgQdV7IZZur8yjTevdtiCaK
	 3NutR51x5VuiWvIeXhRVR2+awGJelbwflUiP0Ep3a+X+8FdyA9tcC8Uj/vk++/LGFZ
	 zprKf9RYREKPqZs+3iAmwqjKh2G7/1HWcDhkvtUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCLM4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:56:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:56:01 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6069206BA;
        Tue, 12 Mar 2019 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552395360;
        bh=HTw32ICmUS6/OkVq9cu+3LMLNyUDmjek2zM8KY6ylbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4klf6XK3Rl89gF91Jr4odFri1VCV81ryQxBfe5gUji8qOXGOENRfD283nxfOBKkN
         qd1udgYtMIBwVRnwFKuwoiEeciFWGFS8RRETIP73V3jad4yiBQjaWDRH3g/fEC4JlB
         zWWRza2AtulUB6ebdH6piU+/EjtimIWYNeTd1iRA=
Date:   Tue, 12 Mar 2019 05:56:00 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     stable@vger.kernel.org, jgross@suse.com,
        herbert.van.den.bergh@oracle.com, sstabellini@kernel.org,
        sboyd@kernel.org, frederic@kernel.org, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
Subject: Re: [Xen-devel] [PATCH v4.9 1/1] jiffies: use jiffies64_to_nsecs()
 to fix 100% steal usage for xen vcpu hotplug
Message-ID: <20190312125600.GF23540@kroah.com>
References: <1551772744-524-1-git-send-email-dongli.zhang@oracle.com>
 <15c804c0-eeb1-2adb-9cbf-4a28d39983a0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c804c0-eeb1-2adb-9cbf-4a28d39983a0@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:35:40PM +0800, Dongli Zhang wrote:
> Thanks to Joe Jin's reminding, this patch is applicable to mainline linux
> kernel, although there is no issue due to this kind of bug in mainline kernel.
> 
> Therefore, can I first submit this patch to mainline kernel and then backport it
> to stable linux with more detailed explanation how the issue is reproduced on xen?

Yes, please do that.

thanks,

greg k-h
