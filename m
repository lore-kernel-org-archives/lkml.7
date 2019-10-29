Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639DCA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B02086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfJ2ICl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:02:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:17582 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfJ2ICk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:02:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 01:02:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="401068940"
Received: from fyin-dev.sh.intel.com (HELO [10.239.143.122]) ([10.239.143.122])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 01:02:39 -0700
Subject: Re: linux-next: manual merge of the vhost tree with the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191029151928.780c8ede@canb.auug.org.au>
From:   Yin Fengwei <fengwei.yin@intel.com>
Message-ID: <f22614d2-3275-fd98-9382-aeff1ca814fa@intel.com>
Date:   Tue, 29 Oct 2019 16:02:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191029151928.780c8ede@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/10/29 下午12:19, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vhost tree got a conflict in:
> 
>    drivers/acpi/processor_idle.c
> 
> between commit:
> 
>    fa583f71a99c ("ACPI: processor_idle: Skip dummy wait if kernel is in guest")
> 
> from the pm tree and commit:
> 
>    a04c0533b07c ("ACPI: disable extra P_LVLx access on KVM")
Sorry for this. I only check the linus tree and didn't notice there is
this patch in pm tree.

BTW, from this patch (a04c0533b07c), it has todo to extend the
hypervisor not only for kvm. So I suppose it's time to add one more:
ACRN. Thanks.

Regards
Yin, Fengwei

> 
> from the vhost tree.
> 
> I fixed it up (I just used the pm tree version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 
